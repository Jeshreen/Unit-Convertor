//
//  TemperatureController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/12/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class TemperatureController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textCelcius: UITextField!
    @IBOutlet weak var textFahrenhiet: UITextField!
    @IBOutlet weak var textKelvin: UITextField!
    var arrTemperature = [String]()
    var savedArrTemperature = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textCelcius.becomeFirstResponder()
        
//        adding a gradient to the background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red:0.89, green:0.58, blue:0.53, alpha:1.0).cgColor,UIColor(red:0.84, green:0.43, blue:0.46, alpha:1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(TemperatureController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
   
        // preventing two decimal places in the text box
        self.textCelcius.delegate = self
        self.textFahrenhiet.delegate = self
        self.textKelvin.delegate = self
    }

    //swipe down the key board
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
// saving to user defaults
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textCelcius.text, forKey: "celciusValue")
        defaults.set(textFahrenhiet.text, forKey: "farValue")
        defaults.set(textKelvin.text, forKey: "kelValue")
        defaults.synchronize()
        
    }
    
    //applying the userdefaults
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let centValue = defaults.string(forKey: "celciusValue")
        let farenValue = defaults.string(forKey: "farValue")
        let kelValue = defaults.string(forKey: "kelValue")
        textCelcius.text = centValue
        textFahrenhiet.text = farenValue
        textKelvin.text = kelValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
// celcius value changed fucntion
    @IBAction func celciusChanged(_ sender: UITextField) {
            let centValue = (self.textCelcius.text! as NSString).floatValue
            let farenValue = centToFar(cent: centValue)
            let kelValue = centValue + 273.15
            self.textFahrenhiet.text = String(format: "%.4f",farenValue)
            self.textKelvin.text = String(format: "%.4f",kelValue)
 
    }
    
  // farenhiet value changed fucntion
    @IBAction func farenhiteChanged(_ sender: UITextField) {
        let farenValue = (self.textFahrenhiet.text! as NSString).floatValue
        let centValue = farToCent(far: farenValue)
        let kelValue = centValue + 273.15
        self.textKelvin.text = String(format: "%.4f",kelValue)
        self.textCelcius.text = String(format: "%.4f",centValue)
    }
    
    // kelvin value changed fucntion
    @IBAction func kelvinChanged(_ sender: UITextField) {
        let kelValue = (self.textKelvin.text! as NSString).floatValue
        let centValue = kelValue - 273.15
        let farenValue = centToFar(cent: centValue)
        self.textCelcius.text = String(format: "%.4f",centValue)
        self.textFahrenhiet.text = String(format: "%.4f",farenValue)
    }
 
//    minor function celcius to farenheit
    func centToFar (cent:Float)->Float{
        let far = cent*(9/5) + 32
        return far
    }
    
    //minor function faranhiet to Celcius
    func farToCent (far:Float)->Float{
        let cent = (far - 32)*(5/9)
        return cent
    }
    
    //saving the data
    @IBAction func saveData(_ sender: Any) {
        if let savedArrTemperature = UserDefaults.standard.object(forKey: "recentTemperature") as? [String]{
            arrTemperature = savedArrTemperature
        }
        
        //restricting to the recent 5
        if (arrTemperature.count == 5){
            arrTemperature.remove(at: 0)
        }
        
        //to restrict zeros getting saved
        if(textKelvin.text == "0"){
            textKelvin.text = String("0.0000")
        }
        if(textCelcius.text == "0"){
            textCelcius.text = String("0.0000")
        }
        if(textFahrenhiet.text == "0"){
            textFahrenhiet.text = String("0.0000")
        }
        
        //savign the items
        if ((textKelvin.text?.isEmpty)!||(textCelcius.text?.isEmpty)!||(textFahrenhiet.text?.isEmpty)!) == false{
            if((textKelvin.text == "0.0000") && (textCelcius.text == "0.0000") && (textFahrenhiet.text == "0.0000")) == false {
                
                //alert
                let refreshAlert = UIAlertController(title: "", message: "Your Data is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                //save
                arrTemperature.append(textCelcius.text! + " Celcius = " + textFahrenhiet.text! + " Fahrenhiet = " + textKelvin.text! + " Kelvin ")
                let defaults = UserDefaults.standard
                defaults.set(arrTemperature, forKey: "recentTemperature")
                
            } else {
                
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
    
    //applying the minus value on text fields
    @IBAction func celciusEnd(_ sender: UITextField) {
        celciusChanged(textCelcius)
    }
    
   
    @IBAction func farenhiteEnd(_ sender: UITextField) {
        farenhiteChanged(textFahrenhiet)
    }
    
    @IBAction func kelvinEnd(_ sender: UITextField) {
        kelvinChanged(textKelvin)
    }
    
    //preventing the user from entering two decimal points
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")
        
        if arrayOfString.count > 2 {
            return false
        }
        return true
    }
    
    
}
