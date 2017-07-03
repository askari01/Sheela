//
//  ViewController.swift
//  Sheela
//
//  Created by Syed Askari on 30/06/2017.
//  Copyright © 2017 Askari. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/test.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // trying to add text and a box
        
//        var box = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
//        box.position = SCNVector3(0, 0, -0.2)
//        sceneView.scene.rootNode.addChildNode(box)
        
        var text = SCNText(string: "My Name is Sheela", extrusionDepth: 0.1)
        text.firstMaterial?.diffuse.contents = UIColor.orange
        
        let textNode = SCNNode(geometry: text)
        textNode.name = "circle"
        textNode.position = SCNVector3(0, 0, -3)
//        textNode.scale = SCNVector3(0.02, 0.02, 0.02)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        
        let image = UIImage(named: "kat")
        let floor = SCNFloor()
        let material = SCNMaterial()
        material.diffuse.contents = image
        material.isDoubleSided = true
        
        floor.materials = [material]
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(0, -90, 0)
//        floorNode.scale = SCNVector3(-0.01, -0.01, -0.01)
        floorNode.rotation = SCNVector4(300,0,30,-90)
        
//        sceneView.scene.rootNode.addChildNode(floorNode)
    }
    
    // adding touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchPointScene = touch?.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchPointScene!, options: nil)
        if let result = hitResults.first {
            handleTouchFor(node: result.node)
        }
        
    }
    
    // touch check
    func handleTouchFor(node: SCNNode) {
        print ("hello sheela")
        if node.name == "circle" {
            print("Sheeela Touched")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
