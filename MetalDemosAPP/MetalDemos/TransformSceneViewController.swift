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
    
    @IBAction func RotateAroundX(_ sender: UISwitch) {
        transformSceneViewController?.switchRotateX(sender.isOn)
    }
    @IBAction func RotateAroundY(_ sender: UISwitch) {
        transformSceneViewController?.switchRotateY(sender.isOn)
    }
    @IBAction func RotateAroundZ(_ sender: UISwitch) {
        transformSceneViewController?.switchRotateZ(sender.isOn)
    }
    @IBAction func ScaleSlider(_ sender: UISlider) {
        transformSceneViewController?.scaleModel(sender.value);
    }
}

