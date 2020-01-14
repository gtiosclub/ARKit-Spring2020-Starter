//
//  ViewController.swift
//  ARKit Spring2020 Final
//
//  Created by Phil Zet on 04/09/2017.
//  Copyright © 2017 Phil Zet. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SceneKit.ModelIO

class ViewController: UIViewController {
    
    // outlets
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var statusLabel: UILabel!
    
    // instance vars
    var selectedPlane: VirtualPlane?
    var mugNode: SCNNode!
    
    // Planes: every plane is identified by a UUID.
    var planes = [UUID: VirtualPlane]() {
        didSet {
            if planes.count > 0 {
                sessionStatus = .ready
            } else {
                if sessionStatus == .ready { sessionStatus = .initialized }
            }
        }
    }
    
    // tracking the session status. if it fails, we remove all nodes
    var sessionStatus = ARSessionState.initialized {
        didSet {
            DispatchQueue.main.async { self.statusLabel.text = self.sessionStatus.description }
            if sessionStatus == .failed {
                sceneView.scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
                    node.removeFromParentNode()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // round corners of status label
        statusLabel.layer.cornerRadius = 20.0
        statusLabel.layer.masksToBounds = true
        
        // TODO:
        // Set the view's delegate
        // Show statistics such as fps and timing information
        // configure settings and debug options for scene
        // Create a new scene and Set the scene to the view
        // initialize coffee node
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        // Run the view's session
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
    }
    
    // MARK: - Adding, updating and removing planes in the scene in response to ARKit plane detection.
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // create a 3d plane from the anchor
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // updating plane anchors as the tracking is updated
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // handling removing a plane
    }
    
    // MARK: - Session tracking methods
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
    // MARK: - Selecting planes and adding out coffee mug.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // get the first detected touch
        // check if the session is OK
        // perform hit testing (detect location in sceneview)
        // perform hit testing to find the plane
        // clone the coffee mug and place it at the detected location
    }
    
    func virtualPlaneProperlySet(touchPoint: CGPoint) -> VirtualPlane? {
        let hits = sceneView.hitTest(touchPoint, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first, let identifier = firstHit.anchor?.identifier, let plane = planes[identifier] {
            self.selectedPlane = plane
            return plane
        }
        return nil
    }
    
    func addCoffeeToPlane(plane: VirtualPlane, atPoint point: CGPoint) {
        let hits = sceneView.hitTest(point, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first {
            if let anotherMug = mugNode?.clone() {
                anotherMug.position = SCNVector3Make(firstHit.worldTransform.columns.3.x, firstHit.worldTransform.columns.3.y, firstHit.worldTransform.columns.3.z)
                sceneView.scene.rootNode.addChildNode(anotherMug)
            }
        }
    }
    
}
