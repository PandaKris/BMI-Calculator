//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Kristanto Sean N on 05/04/22.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var resultContainerView: UIView!
    
    @IBOutlet weak var bmiResult: UILabel!
    @IBOutlet weak var bmiDescription: UILabel!
    
    let agePicker = UIPickerView()
    let genderPicker = UIPickerView()
    
    var agePickerOptions = Array(2...100)
    var genderPickerOptions = ["", "Male", "Female"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        agePicker.tag = 1
        genderPicker.tag = 2
        
        agePicker.delegate = self
        agePicker.dataSource = self
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        ageField.inputView = agePicker
        genderField.inputView = genderPicker
        
        heightField.keyboardType = .decimalPad
        weightField.keyboardType = .decimalPad
        
        title = "BMI Calculator"
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        resultContainerView.layer.cornerRadius = 16
        
        bmiResult.text = "Input your age, gender, width, and height to get your result"
        bmiDescription.text = ""
        
     //   setupNavigationMultilineTitle()

    }
    


    @IBAction func doCalculate(_ sender: Any) {
        
        // Get Input
        let weight = Double(weightField.text ?? "0") ?? 0
        let height = Double(heightField.text ?? "0") ?? 0
        
        print("weight: \(weight)")
        print(height)
        
        // Run Process
        let bmi = weight / (height/100 * height/100)
        
        print(bmi)
        
        var result = ""
        switch (bmi) {
            case 0...16:
                result = "Based on your BMI value, you are severely underweight and need to gain \(calculateWeightAdjustment(normalBMI: 18.5, weight: weight, height: height)) kg"
            case 16...17:
                result = "Based on your BMI value, you are moderately underweight and need to gain \(calculateWeightAdjustment(normalBMI: 18.5, weight: weight, height: height)) kg"
            case 17...18.5:
                result = "Based on your BMI value, you are underweight and need to gain \(calculateWeightAdjustment(normalBMI: 18.5, weight: weight, height: height)) kg"
            case 18.5...25:
                result = "Your BMI is normal"
            case 25...30:
                result = "Based on your BMI value, you are overweight and need to lose \(calculateWeightAdjustment(normalBMI: 25, weight: weight, height: height)) kg"
            case 30...35:
                result = "Based on your BMI value, you have Class I Obesity and need to lose \(calculateWeightAdjustment(normalBMI: 25, weight: weight, height: height)) kg"
            case 35...40:
                result = "Based on your BMI value, you have Class II Obesity and need to lose \(calculateWeightAdjustment(normalBMI: 25, weight: weight, height: height)) kg"
            case 40...100:
                result = "Based on your BMI value, you have Class III Obesity and need to lose \(calculateWeightAdjustment(normalBMI: 25, weight: weight, height: height)) kg"
            default:
                result = "Not Found!"
            
        }
                
        // Display Output
        bmiResult.textColor = .label
        bmiResult.text = "Your BMI Index is \(bmi.rounded(toPlaces: 2)) kg/m2"
        bmiDescription.text = result
        
        print(weight, height, bmi, result)
    }
    
    
    func calculateWeightAdjustment(normalBMI: Double, weight: Double, height: Double) -> Double {
        let idealWeight = normalBMI * (height/100 * height/100)
        return abs(weight - idealWeight).rounded(toPlaces: 2)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return agePickerOptions.count
        } else {
            return genderPickerOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return "\(agePickerOptions[row])"
        } else {
            return "\(genderPickerOptions[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1) {
            ageField.text = String(agePickerOptions[row])
        } else {
            genderField.text = genderPickerOptions[row]
        }
    }
    
}
