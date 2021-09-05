//
//  MainViewController.swift
//  ChangeColorView
//
//  Created by Слава Платонов on 05.09.2021.
//

import UIKit

protocol ViewControllerDelegate {
    func setNewColor(red: Float, green: Float, blue: Float)
}

class MainViewController: UIViewController {
    
    private var redColor: Float?
    private var greenColor: Float?
    private var blueColor: Float?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ViewController else { return }
        viewController.delegate = self
        
        viewController.red = redColor ?? 0
        viewController.green = greenColor ?? 0
        viewController.blue = blueColor ?? 0
    }
    
}

extension MainViewController: ViewControllerDelegate {

    func setNewColor(red: Float, green: Float, blue: Float) {
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        redColor = red
        greenColor = green
        blueColor = blue
    }
}
