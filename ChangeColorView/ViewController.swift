//
//  ViewController.swift
//  ChangeColorView
//
//  Created by Слава Платонов on 21.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    var red: Float!
    var green: Float!
    var blue: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
        
        updateBackgroundColor()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
        delegate.setNewColor(red: redSlider.value , green: greenSlider.value, blue: blueSlider.value)
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
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
}
