//
//  ReminderListCell1.swift
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/24.
//

import UIKit

class ReminderListCell1: UITableViewCell {
    typealias DoneButtonAction = () -> Void

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!

    var doneButtonAction: DoneButtonAction?
    
    @IBAction func doneButtonTriggered(_ sender: UIButton) {
        doneButtonAction?()
    }
}
