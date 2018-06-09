//
//  measuringunitsController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/12/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class measuringunitsController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textCm: UITextField!
    @IBOutlet weak var textMeter: UITextField!
    @IBOutlet weak var textInch: UITextField!
    @IBOutlet weak var textMm: UITextField!
    @IBOutlet weak var textYard: UITextField!
    var arrDistance = [String]()
    var savedArrDistance = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textCm.becomeFirstResponder()
        
        //adding the gradient to the background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red:0.89, green:0.58, blue:0.53, alpha:1.0).cgColor,UIColor(red:0.84, green:0.43, blue:0.46, alpha:1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(measuringunitsController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    
        //adding the delegated
        self.textCm.delegate = self
        self.textMeter.delegate = self
        self.textInch.delegate = self
        self.textMm.delegate = self
        self.textYard.delegate = self
    }

    //swipe down the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //saving the user defaults
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textCm.text, forKey: "CmValue")
        defaults.set(textMeter.text, forKey: "MeterValue")
        defaults.set(textInch.text, forKey: "InchValue")
        defaults.set(textMm.text, forKey: "MmValue")
        defaults.set(textYard.text, forKey: "YardValue")
        defaults.synchronize()
        
    }
    
    //applying the user defaults
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let cmValue = defaults.string(forKey: "CmValue")
        let meterValue = defaults.string(forKey: "MeterValue")
        let inchValue = defaults.string(forKey: "InchValue")
        let mmValue = defaults.string(forKey: "MmValue")
        let yardValue = defaults.string(forKey: "YardValue")
        textCm.text = cmValue
        textMm.text = meterValue
        textInch.text = inchValue
        textMm.text = mmValue
        textYard.text = yardValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // CM value changed function
    @IBAction func cmChanged(_ sender: UITextField) {
        let cmValue = (self.textCm.text! as NSString).floatValue
        let meterValue = cmToM(cm: cmValue)
        let inchValue = cmToInch(cm: cmValue)
        let mmValue = cmToMm(cm: cmValue)
        let yardValue = inchToYard(inch: inchValue)
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textInch.text = String(format: "%.4f",inchValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textYard.text = String(format: "%.4f",yardValue)
    }
    
    // meter value changed fucntion
    @IBAction func meterChanged(_ sender: UITextField) {
        let meterValue = (self.textMeter.text! as NSString).floatValue
        let cmValue = meterValue * 100
        let inchValue = cmToInch(cm: cmValue)
        let mmValue = cmToMm(cm: cmValue)
        let yardValue = inchToYard(inch: inchValue)
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textInch.text = String(format: "%.4f",inchValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textYard.text = String(format: "%.4f",yardValue)
    }
   
    //inch value changed function
    @IBAction func inchChanged(_ sender: UITextField) {
        let inchValue = (self.textInch.text! as NSString).floatValue
        let cmValue = inchValue / 0.39370
        let meterValue = cmToM(cm: cmValue)
        let mmValue = cmToMm(cm: cmValue)
        let yardValue = inchToYard(inch: inchValue)
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textYard.text = String(format: "%.4f",yardValue)
    }

    // MM value changed fucntion
    @IBAction func mmChanged(_ sender: UITextField) {
        let mmValue = (self.textMm.text! as NSString).floatValue
        let cmValue = mmValue / 10
        let meterValue = cmToM(cm: cmValue)
        let inchValue = cmToInch(cm: cmValue)
        let yardValue = inchToYard(inch: inchValue)
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textInch.text = String(format: "%.4f",inchValue)
        self.textYard.text = String(format: "%.4f",yardValue)
    }
    
    //yard value changed fucntion
    @IBAction func yardChanged(_ sender: UITextField) {
        let yardValue = (self.textYard.text! as NSString).floatValue
        let cmValue = yardValue * 91.44
        let meterValue = cmToM(cm: cmValue)
        let inchValue = cmToInch(cm: cmValue)
        let mmValue = cmToMm(cm: cmValue)
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textInch.text = String(format: "%.4f",inchValue)
    }
    
    //minor fucntion CM - M
    func cmToM (cm:Float)->Float{
        let M = cm / 100
        return M
    }
    
    //minor fucntion CM - Inch
    func cmToInch (cm:Float)->Float{
        let Inch = cm * 0.393701
        return Inch
    }
    
    //minor fucntion CM - MM
    func cmToMm (cm:Float)->Float{
        let Mm = cm * 10
        return Mm
    }
    
    //minor fucntion inch - yard
    func inchToYard (inch:Float)->Float{
        let Yard = inch * 0.027778
        return Yard
    }
    
    // saving the data
    @IBAction func saveData(_ sender: Any) {
        if let savedArrDistance = UserDefaults.standard.object(forKey: "recentDistance") as? [String]{
            arrDistance = savedArrDistance
        }
        
        //restricting to the recent 5
        if (arrDistance.count == 5){
            arrDistance.remove(at: 0)
        }
        
        //preventing zeros getting saved
        if(textMeter.text == "0"){
            textMeter.text = String("0.0000")
        }
        if(textCm.text == "0"){
            textCm.text = String("0.0000")
        }
        if(textMm.text == "0"){
            textMm.text = String("0.0000")
        }
        if(textInch.text == "0"){
            textInch.text = String("0.0000")
        }
        if(textYard.text == "0"){
            textYard.text = String("0.0000")
        }
        
        //saving the items
        if((textMeter.text?.isEmpty)! || (textCm.text?.isEmpty)! || (textMm.text?.isEmpty)! || (textInch.text?.isEmpty)! || (textYard.text?.isEmpty)!) == false{
            if((textMeter.text == "0.0000") && (textCm.text == "0.0000") && (textMm.text == "0.0000") && (textInch.text == "0.0000") && (textYard.text == "0.0000")) == false {
                
                //alert
                let refreshAlert = UIAlertController(title: "", message: "Your Data is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                //save
                arrDistance.append(textCm.text! + " Centi Meter = " + textMeter.text! + " Meter = " + textInch.text! + " Inch = " + textMm.text! + " Milli meter = " + textYard.text! + " Yards ")
                let defaults = UserDefaults.standard
                defaults.set(arrDistance, forKey: "recentDistance")
                
            } else{
                
                //alert
                let refreshAlert = UIAlertController(title: "", message: "You Cannot save empty values or zeros", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
        } else {
            
            //alert
            let refreshAlert = UIAlertController(title: "", message: "You Cannot save empty values or zeros", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    // preventing the user entering two decimal places.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")
        
        if arrayOfString.count > 2 {
            return false
        }
        return true
    }
}
