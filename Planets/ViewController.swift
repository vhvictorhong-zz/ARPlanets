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
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let earthNode = SCNNode()
        earthNode.geometry = SCNSphere(radius: 0.2)
        earthNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "2k_earth_daymap")
        earthNode.position = SCNVector3(0, 0, -1)
        self.sceneView.scene.rootNode.addChildNode(earthNode)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

