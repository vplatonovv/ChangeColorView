//
//  MainViewController.swift
//  ChangeColorView
//
//  Created by Слава Платонов on 05.09.2021.
//

import UIKit

protocol ViewControllerDelegate {
    func setNewColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? SettingsViewController else { return }
        guard let color = view.backgroundColor else { return }
        let ciColor = CIColor(color: color)
        viewController.delegate = self
        viewController.currentColor = ciColor
    }
    
}

extension MainViewController: ViewControllerDelegate {
    func setNewColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
