//
//  ReminderTransformSceneViewcontroller.swift
//  Today
//
//  Created by ThisEwan on 2021/6/17.
//

import UIKit

class TransformSceneViewController: UIViewController {
    
    private var transformSceneViewController: TransformSceneViewControllerOC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transformSceneViewController = TransformSceneViewControllerOC()
        transformSceneViewController?.onViewDidload(self);
    }
    
    func configue() {
        
        NSLog("configue")
    }
    
    @IBAction func Start(_ sender: Any) {
        
        NSLog("Start Transform")
    }
}

