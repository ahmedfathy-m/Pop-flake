//
//  SettingsTableViewHandler.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 06/08/2022.
//

import UIKit

class SettingsTableViewHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    var coordinator: AppCoordinator?
    let settings = [("Dark Mode", "circle.righthalf.filled", false),
                   ("Complaints", "exclamationmark.circle.fill", true)]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as! SettingsCell
        cell.settingTitle.text = settings[indexPath.row].0
        cell.settingIcon.image = UIImage(systemName: settings[indexPath.row].1)
        cell.switchButton.isHidden = settings[indexPath.row].2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settings[indexPath.row].0 == "Complaints" {
            coordinator?.goToComplaintsView()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
