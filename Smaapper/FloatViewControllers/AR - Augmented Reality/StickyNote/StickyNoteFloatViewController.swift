//
//  StickyNoteFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/07/23.
//

import UIKit
import ARKit
import RealmSwift


class StickyNoteFloatViewController: FloatViewController {
    static let identifierApp = K.Sticky.identifierApp
    
    lazy var screen: StickyNoteView = {
        let view = StickyNoteView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    private func initialization() {
        setEnabledDraggable(true)
        setFrameWindow(CGRect(x: K.Sticky.FloatView.x,
                              y: K.Sticky.FloatView.y,
                              width: K.Sticky.FloatView.width ,
                              height: K.Sticky.FloatView.height))
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        UtilsFloatView.setShadowActiveFloatView(screen)
        do {
            try screen.cameraARKit.runSceneView(loadWorldMapData: K.worldMapData)
        } catch let error {
            print(error.localizedDescription)
        }
        
        testWithRealm()
        
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
        screen.cameraARKit.pauseSceneView()
    }
    

//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
        screen.cameraARKit.delegate = self
    }
    
    private func createARPlane() -> ARGeometryBuilder {
        return ARGeometryBuilder()
            .setPlane { build in
                build
                    .setSize(0.08, 0.08)
            }
    }
    
    private func createARNode(_ geometry: ARGeometryBuilder) -> ARNodeBuilder {
        return ARNodeBuilder()
            .setGeometry(geometry)
            .setAutoFollowCamera()
    }
    
    private func addStickyNote() {
        let stickyView = screen.getStickyNote()
        configStickyNoteToAR(stickyView)
        hideKeyboard()
    }
    
    private func hideKeyboard() {
        screen.noteTextField.setText(K.String.empty)
            .setKeyboard { buid in
                buid
                    .setHideKeyboard(true)
            }
    }
    
    private func configStickyNoteToAR(_ stickyNote: UIView, _ position: simd_float4x4? = nil) {
        let stickyNoteMaterial = createStickyNoteMaterial(stickyNote)
        let stickyNoteARNode = configObjectAR(stickyNoteMaterial, position)
        addNodeArSceneView(stickyNoteARNode)
        enabledOrDisableRedoButton()
    }
    
    private func createStickyNoteMaterial(_ stickyNote: UIView) -> UIImage {
        return stickyNote.convertToImage ?? UIImage()
    }
    
    private func configObjectAR(_ stickyNoteMaterial: UIImage, _ position: simd_float4x4? = nil) -> ARNodeBuilder {
        let material = ARMaterialBuilder()
            .setDiffuseTexture(stickyNoteMaterial)
        
        let geometryPlane = createARPlane()
            .setMaterial(material)
        
        if let position = getPosition(position) {
            let stickyNoteARNode = createARNode(geometryPlane)
                .setPosition(position)
            stickyNoteARNode.setIdentifier(screen.noteTextField.getText)
            return stickyNoteARNode
        }
        
        return ARNodeBuilder()
    }
    
    private func getPosition(_ position: simd_float4x4?) -> simd_float4x4? {
        if let position { return position }
        return screen.cameraARKit.getPositionByCam(centimetersAhead: 8)
    }
    
    private func addNodeArSceneView(_ node: ARNodeBuilder) {
        screen.cameraARKit.addNode(node)
    }
    
    private func revemoStickNote() {
        removeStickNoteAR()
        enabledOrDisableRedoButton()
    }
    
    private func removeStickNoteAR() {

    }
    
    private func enabledOrDisableRedoButton() {
        screen.redoButtonStickyAR.setHidden(false)
    }
    
    private func recreatingStickyNoteOnWorldMap(_ anchor: ARAnchor) {
        let stickyView = screen.recreateStickyNote(anchor.name ?? K.String.empty)
        configStickyNoteToAR(stickyView, anchor.transform)
    }
    
}


//  MARK: - EXTENSION TapeMeasureViewDelegate

extension StickyNoteFloatViewController: StickyNoteViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
    func addButtonTapped() {
        addStickyNote()
    }
    
    func redoButtonTapped() {
        revemoStickNote()
    }
    
}


//  MARK: - EXTENSION TapeMeasureViewDelegate

extension StickyNoteFloatViewController: ARSceneViewBuilderDelegate {
    func requestCameraElevation(isElevation: Bool) {
        if isElevation {
            print("retira mensagem de colocar a camera levantada porra")
            return
        }
        print("LEVANTA A PORRA DA CAMERA")
    }
    
    
    func stateARSceneview(_ state: ARSceneState) {
        switch state {
        case .waitingWorldMapRecognition:
            print("RECONHECENDO ............................")
        case .excessiveMotion:
            print("FICA QUIETOOOOO")
        case .done:
            print("DOOOOOOOOOOOOOOOONNNNNNNNNNNNNNEEEEEEEEEEEEEEEEE")
        }
    }
    
    
    func saveWorldMap(_ worldMapData: Data?, _ error: WorldMapError?) {
        if error != nil {
            print("ERRO:", error ?? "")
            return
        }
        if let worldMapData {
            K.worldMapData = worldMapData
            print("salvou:", worldMapData.count)
            
        }

    }
    
    func positionTouch(_ position: CGPoint) {
        
    }

    func loadAnchorWorldMap(_ anchor: ARAnchor) {
        recreatingStickyNoteOnWorldMap(anchor)
    }
    
}


class WorldMapData: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var userID: UUID
    @Persisted var environmentName: String
    @Persisted var worldMapData: Data
    
    convenience init(id: UUID = UUID(), userID: UUID, environmentName: String, worldMapData: Data) {
        self.init()
        self.id = id
        self.userID = userID
        self.environmentName = environmentName
        self.worldMapData = worldMapData
    }
}




extension StickyNoteFloatViewController {
    
    func testWithRealm() {
//        testInsert()
//        testFetch()
//        testFetchById()
//        testFetchCustomColumn()
//        testFetchCustomColumn2()
        testDELETE()
        
    }
    
    
    
    func testInsert() {
        let worldMapData = WorldMapData(userID: UUID(), environmentName: "Minha Casa", worldMapData: K.worldMapData)
        
        do {
            let realmProvider = try RealmDBProvider<WorldMapData>()
            print(realmProvider.getFileRealm())
            
            let persistence = DBManager<WorldMapData>(provider: realmProvider)
            let id = try persistence.provider.insert(worldMapData)
            
            print("ID PORRA", id)

        } catch {
            print(error)
        }
    }
    
    func testFetch() {
        do {
            let realmProvider = try RealmDBProvider<WorldMapData>()
            let persistence = DBManager<WorldMapData>(provider: realmProvider)
            let worldData = try persistence.provider.fetch()
            print(#function, worldData.count)
        } catch {
            
        }
    }
    
    func testFetchById() {
        let ids: [String] = ["62d11052-3da8-4a16-9bc4-2e6ae81da401", "5b922a2d-351e-478e-aca5-20b20eeb70bc" ]
        
        ids.forEach { id in
            if let id = UUID(uuidString: id) {
                do {
                    let realmProvider = try RealmDBProvider<WorldMapData>()
                    let persistence = DBManager<WorldMapData>(provider: realmProvider)
                    let worldData = try persistence.provider.findByID(id)
                    print(#function, worldData ?? "")
                } catch {
                    
                }
            }
        }
    }
    
    
    func testFetchCustomColumn() {
        do {
            let realmProvider = try RealmDBProvider<WorldMapData>()
            let persistence = DBManager<WorldMapData>(provider: realmProvider)
            let worldData = try persistence.provider.findByColumn(column: "environmentName", value: "CARAIO")
            print(#function,"QUANTIDADE:", worldData.count)
            worldData.forEach { item in
                print(#function, item.userID)
            }
        } catch {
            
        }
    }
    
    func testFetchCustomColumn2() {
        let id = "0342d72b-f97d-4d95-b9cc-b0e6dd1a98f5"
        do {
            let realmProvider = try RealmDBProvider<WorldMapData>()
            let persistence = DBManager<WorldMapData>(provider: realmProvider)
            let worldData = try persistence.provider.findByColumn(column: "userID", value: UUID(uuidString: id))
            worldData.forEach { item in
                print(#function,item)
            }
        } catch {
            
        }
    }
    
    
    func testUPDATE() {
        let id = "bb16e73b-770e-438e-bdbb-0ab1b5e23cd1"
        if let id = UUID(uuidString: id) {
            do {
                let realmProvider = try RealmDBProvider<WorldMapData>()
                let persistence = DBManager<WorldMapData>(provider: realmProvider)
                
                let worldData = try persistence.provider.findByID(id)
                guard let worldData else {return}
                let newWorldMap = WorldMapData(value: worldData)
                newWorldMap.environmentName = "TOP DEMAIS"
                try persistence.provider.update(newWorldMap)
                
            } catch {
                
            }
        }
    }
    
    
    
    func testDELETE() {
        let id = "c4fc6984-2c54-4bcb-a9da-b426b98ed87a"
        if let id = UUID(uuidString: id) {
            do {
                let realmProvider = try RealmDBProvider<WorldMapData>()
                let persistence = DBManager<WorldMapData>(provider: realmProvider)
                
                let worldData = try persistence.provider.findByID(id)
                guard let worldData else {return}
                
                try persistence.provider.delete(worldData)
                
            } catch {
                
            }
        }
    }
    
}
