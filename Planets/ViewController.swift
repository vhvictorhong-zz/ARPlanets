//
//  ViewController.swift
//  Planets
//
//  Created by Victor Hong on 18/12/2017.
//  Copyright © 2017 Victor Hong. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let sunNode = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        
        sunNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun Diffuse")
        sunNode.position = SCNVector3(0, 0, -1)
        earthParent.position = SCNVector3(0, 0, -1)
        venusParent.position = SCNVector3(0, 0, -1)
        moonParent.position = SCNVector3(1.2, 0, 0)
        self.sceneView.scene.rootNode.addChildNode(sunNode)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)

        let earthNode = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2, 0, 0))
        let venusNode = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        let earthMoonNode = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        
        let sunRotation = rotation(time: 8)
        let earthParentRotation = rotation(time: 14)
        let venusParentRotation = rotation(time: 10)
        let earthRotation = rotation(time: 8)
        let venusRotation = rotation(time: 8)
        let moonRotation = rotation(time: 5)
        
        sunNode.runAction(sunRotation)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        earthNode.runAction(earthRotation)
        venusNode.runAction(venusRotation)
        moonParent.runAction(moonRotation)
        
        earthParent.addChildNode(earthNode)
        earthParent.addChildNode(moonParent)
        venusParent.addChildNode(venusNode)
        earthNode.addChildNode(earthMoonNode)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position

        return planet
        
    }

    func rotation(time: TimeInterval) -> SCNAction {
        
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverAction = SCNAction.repeatForever(rotation)
        
        return foreverAction
        
    }
    
}

extension Int {
    
    var degreesToRadians: Double {return Double(self) * .pi/180}
    
}
