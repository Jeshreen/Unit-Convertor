//
//  SpeedController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/12/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class SpeedController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textMeter: UITextField!
    @IBOutlet weak var textKm: UITextField!
    @IBOutlet weak var textMiles: UITextField!
    var arrSpeed = [String]()
    var savedArrTemperature = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textMeter.becomeFirstResponder()
        
        //gradient to the background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red:0.89, green:0.58, blue:0.53, alpha:1.0).cgColor,UIColor(red:0.84, green:0.43, blue:0.46, alpha:1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(SpeedController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        self.textMeter.delegate = self
        self.textKm.delegate = self
        self.textMiles.delegate = self
    }
    
    //swipe down the key board
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // saving the user defaults
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textMeter.text, forKey: "meterValue")
        defaults.set(textKm.text, forKey: "kmValue")
        defaults.set(textMiles.text, forKey: "milesValue")
        defaults.synchronize()
        
    }

    // applying the user defaults
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let meterValue = defaults.string(forKey: "meterValue")
        let kmValue = defaults.string(forKey: "kmValue")
        let milesValue = defaults.string(forKey: "milesValue")
        textMeter.text = meterValue
        textKm.text = kmValue
        textMiles.text = milesValue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // meter value changed fucntion
    @IBAction func meterChanged(_ sender: UITextField) {
        let meterValue = (self.textMeter.text! as NSString).floatValue
        let kmValue = meterValue * 3.6
        let milesValue = meterToMiles(meter: meterValue)
        self.textKm.text = String(format: "%.4f",kmValue)
        self.textMiles.text = String(format: "%.4f",milesValue)
    }
  
    // km value changed fucntion
    @IBAction func kmChanged(_ sender: UITextField) {
        let kmValue = (self.textKm.text! as NSString).floatValue
        let meterValue = kmValue / 3.6
        let milesValue = meterToMiles(meter: meterValue)
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textMiles.text = String(format: "%.4f",milesValue)
    }
  
    //miles value changed function
    @IBAction func milesChanged(_ sender: UITextField) {
        let milesValue = (self.textMiles.text! as NSString).floatValue
        let meterValue = milesValue * 0.44704
        let kmValue = meterValue * 3.6
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textKm.text = String(format: "%.4f",kmValue)
    }
    
    // minor function meter - miles
    func meterToMiles(meter:Float)->Float{
        let miles = meter / 0.44704
        return miles
    }
 
    // saving the data
    @IBAction func saveData(_ sender: Any) {
        if let savedArrTemperature = UserDefaults.standard.object(forKey: "recentSpeed") as? [String]{
            arrSpeed = savedArrTemperature
        }
        
        //restricting to the recent 5
        if (arrSpeed.count == 5){
            arrSpeed.remove(at: 0)
        }
        
        //to prevent zeros getting saved
        if(textMeter.text == "0"){
            textMeter.text = String("0.0000")
        }
        if(textKm.text == "0"){
            textKm.text = String("0.0000")
        }
        if(textMeter.text == "0"){
            textMeter.text = String("0.0000")
        }
        
        //saving the items
        if((textKm.text?.isEmpty)! || (textMeter.text?.isEmpty)! || (textMiles.text?.isEmpty)!) == false {
             if((textKm.text == "0.0000") && (textMeter.text == "0.0000") && (textMiles.text == "0.0000")) == false {
               
                
                //alert
                let refreshAlert = UIAlertController(title: "", message: "Your Data is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                //save
                arrSpeed.append(textMeter.text! + " Meter per sec = " + textKm.text! + " Kilo meter per hour = " + textMiles.text! + " Miles per hour ")
                let defaults = UserDefaults.standard
                defaults.set(arrSpeed, forKey: "recentSpeed")
                
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
    
    // preventing te user entering two decimal places.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")
        
        if arrayOfString.count > 2 {
            return false
        }
        return true
    }
    
}
