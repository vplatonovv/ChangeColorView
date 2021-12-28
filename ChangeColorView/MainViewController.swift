//
//  MainViewController.swift
//  ChangeColorView
//
//  Created by Слава Платонов on 05.09.2021.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func setNewColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingView = segue.destination as? SettingsViewController else { return }
        guard let color = view.backgroundColor else { return }
        let ciColor = CIColor(color: color)
        settingView.delegate = self
        settingView.currentColor = ciColor
    }
    
}

extension MainViewController: ViewControllerDelegate {
    func setNewColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
