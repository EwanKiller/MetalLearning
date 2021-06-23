/*
 See LICENSE folder for this sample's licensing information.
 */

import Foundation

struct Reminder {
    var title: String
    var dueDate: String? = nil
    var notes: String? = nil
    var isComplete: Bool = false
}

extension Reminder {
    static var testData = [
        Reminder(title: "Transform Cube", dueDate: "2021/06/10", notes: "Show how a cube do  affinetransform" , isComplete: true),
        Reminder(title: "Roaming Camera", dueDate: "2021/06/17", notes: "Show how a camera in 3D space", isComplete: false),
//        Reminder(title: "Pick up new contacts", dueDate: Date().addingTimeInterval(24000.0), notes: "Optometrist closes at 6:00PM"),
//        Reminder(title: "Add notes to retrospective", dueDate: Date().addingTimeInterval(3200.0), notes: "Collaborate with project manager", isComplete: true),
//        Reminder(title: "Interview new project manager candidate", dueDate: Date().addingTimeInterval(60000.0), notes: "Review portfolio"),
//        Reminder(title: "Mock up onboarding experience", dueDate: Date().addingTimeInterval(72000.0), notes: "Think different"),
//        Reminder(title: "Review usage analytics", dueDate: Date().addingTimeInterval(83000.0), notes: "Discuss trends with management"),
//        Reminder(title: "Confirm group reservation", dueDate: Date().addingTimeInterval(92500.0), notes: "Ask about space heaters"),
//        Reminder(title: "Add beta testers to TestFlight", dueDate: Date().addingTimeInterval(101000.0), notes: "v0.9 out on Friday")
    ]
}

