//
//  ViewController.swift
//  ChangeColorView
//
//  Created by Слава Платонов on 21.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var colorView: UIView! {
        didSet {
            colorView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            doneButton.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var delegate: ViewControllerDelegate!
    var currentColor: CIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        updateSliders()
        updateTextField()
        updateColorView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func updateColorView() {
        colorView.backgroundColor = UIColor(ciColor: currentColor)
    }
    
    private func updateTextField() {
        redTextField.text = String(format: "%.2f", Float(currentColor.red))
        greenTextField.text = String(format: "%.2f", Float(currentColor.green))
        blueTextField.text = String(format: "%.2f", Float(currentColor.blue))
    }
    
    private func updateSliders() {
        redSlider.value = Float(currentColor.red)
        greenSlider.value = Float(currentColor.green)
        blueSlider.value = Float(currentColor.blue)
    }
    
    @IBAction func updateBackgroundColor() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        redValueLabel.text = String(format: "%.2f", red)
        greenValueLabel.text = String(format: "%.2f", green)
        blueValueLabel.text = String(format: "%.2f", blue)
        
        redTextField.text = redValueLabel.text
        greenTextField.text = greenValueLabel.text
        blueTextField.text = blueValueLabel.text
        
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    @IBAction func doneButtonTaped() {
        guard let color = colorView.backgroundColor else { return }
        delegate.setNewColor(color)
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newColorValue = textField.text else { return }
        guard let floatValue = Float(newColorValue) else { return }
        
        if textField == redTextField {
            redSlider.value = floatValue
        } else if textField == greenTextField {
            greenSlider.value = floatValue
        } else if textField == blueTextField {
            blueSlider.value = floatValue
        }
        updateBackgroundColor()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == redTextField {
            greenTextField.becomeFirstResponder()
        } else if textField == greenTextField {
            blueTextField.becomeFirstResponder()
        } else {
            textField.endEditing(true)
        }
        return true
    }
}
