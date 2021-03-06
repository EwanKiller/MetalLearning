/*
 See LICENSE folder for this sample's licensing information.
 */

import UIKit

class ReminderListViewController: UITableViewController {
    static let showTransformSceneSegueIdentifier = "ShowTransformSceneSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showTransformSceneSegueIdentifier,
           let destination = segue.destination as? TransformSceneViewController {
                destination.configue()
                }
    }
}

extension ReminderListViewController {
    static let reminderListCellIdentifier = "ReminderListCell"
    static let reminderListCellIdentifier1 = "ReminderListCell1"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Reminder.testData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderListCellIdentifier, for: indexPath) as? ReminderListCell else {
            fatalError("Unable to dequeue ReminderCell")
        }
        let reminder = Reminder.testData[indexPath.row]
        let image = reminder.isComplete ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        cell.titleLabel.text = reminder.title
        cell.dateLabel.text = reminder.dueDate
        cell.doneButton.setBackgroundImage(image, for: .normal)
        cell.doneButtonAction = {
            Reminder.testData[indexPath.row].isComplete.toggle()
            tableView.reloadRows(at: [indexPath], with: .none)
       }
        return cell
    }
}
