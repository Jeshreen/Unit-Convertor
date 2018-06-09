//
//  LiquidController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/12/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class LiquidController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var textGallon: UITextField!
    @IBOutlet weak var textLiter: UITextField!
    @IBOutlet weak var textPint: UITextField!
    @IBOutlet weak var textOunce: UITextField!
    var arrLiquid = [String]()
    var savedArrLiquid = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textGallon.becomeFirstResponder()
        
        // adding the gradient to the background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red:0.89, green:0.58, blue:0.53, alpha:1.0).cgColor,UIColor(red:0.84, green:0.43, blue:0.46, alpha:1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(LiquidController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        self.textGallon.delegate = self
        self.textLiter.delegate = self
        self.textPint.delegate = self
        self.textOunce.delegate = self
    }
    
    //swiping down the key board
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // save user default data
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textGallon.text, forKey: "gallonValue")
        defaults.set(textLiter.text, forKey: "literValue")
        defaults.set(textPint.text, forKey: "pintValue")
        defaults.set(textOunce.text, forKey: "ounceValue")
        defaults.synchronize()
    }
    
    // apply user defaults
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let gallonValue = defaults.string(forKey: "gallonValue")
        let literValue = defaults.string(forKey: "literValue")
        let pintValue = defaults.string(forKey: "pintValue")
        let ounceValue = defaults.string(forKey: "ounceValue")
        textGallon.text = gallonValue
        textLiter.text = literValue
        textPint.text = pintValue
        textOunce.text = ounceValue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // gallon value changed
    @IBAction func gallonChanged(_ sender: UITextField) {
        let gallonValue = (self.textGallon.text! as NSString).floatValue
        let literValue = gallonValue / 0.21996924
        let pintValue = literToPint(liter: literValue)
        let ounceValue = literToOunce(liter: literValue)
        self.textLiter.text = String(format: "%.4f",literValue)
        self.textPint.text = String(format: "%.4f",pintValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
    }
  
    //liter value changed
    @IBAction func literChanged(_ sender: UITextField) {
        let literValue = (self.textLiter.text! as NSString).floatValue
        let gallonValue = literToGallon(liter: literValue)
        let pintValue = literToPint(liter: literValue)
        let ounceValue = literToOunce(liter: literValue)
        self.textGallon.text = String(format: "%.4f",gallonValue)
        self.textPint.text = String(format: "%.4f",pintValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
    }
   
    // pint value changed
    @IBAction func pintChanged(_ sender: UITextField) {
        let pintValue = (self.textPint.text! as NSString).floatValue
        let literValue = pintValue / 1.759754
        let gallonValue = literToGallon(liter: literValue)
        let ounceValue = literToOunce(liter: literValue)
        self.textGallon.text = String(format: "%.4f",gallonValue)
        self.textLiter.text = String(format: "%.4f",literValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
    }
    
   // ounce value changes
    @IBAction func ounceChanged(_ sender: UITextField) {
        let ounceValue = (self.textOunce.text! as NSString).floatValue
        let literValue = ounceValue / 35.19508
        let gallonValue = literToGallon(liter: literValue)
        let pintValue = literToPint(liter: literValue)
        self.textGallon.text = String(format: "%.4f",gallonValue)
        self.textLiter.text = String(format: "%.4f",literValue)
        self.textPint.text = String(format: "%.4f",pintValue)
    }
    
    //minor fucntion liter to pint
    func literToPint(liter:Float)-> Float{
        let pint = liter * 1.759754
        return pint
    }
    
    // minro fucntion liter to ounce
    func literToOunce(liter:Float)->Float{
        let ounce = liter * 35.19508
        return ounce
    }
    
    //minor function liter to gallon
    func literToGallon(liter:Float)->Float{
        let gallon = liter * 0.21996924
        return gallon
    }
    
    // saving the data
    @IBAction func saveData(_ sender: Any) {
        if let savedArrLiquid = UserDefaults.standard.object(forKey: "recentLiquid") as? [String]{
            arrLiquid = savedArrLiquid
        }
        
        //restrincting to the recent 5
        if (arrLiquid.count == 5){
            arrLiquid.remove(at: 0)
        }
        
        //to check for zero and prevent it getting saved
        if(textGallon.text == "0"){
            textGallon.text = String("0.0000")
        }
        if(textPint.text == "0"){
            textPint.text = String("0.0000")
        }
        if(textLiter.text == "0"){
            textLiter.text = String("0.0000")
        }
        if(textOunce.text == "0"){
            textOunce.text = String("0.0000")
        }
        
        //saving the items
        if ((textOunce.text?.isEmpty)! || (textPint.text?.isEmpty)! || (textLiter.text?.isEmpty)! || (textGallon.text?.isEmpty)!) == false {
            if((textOunce.text == "0.0000") && (textPint.text == "0.0000") && (textLiter.text == "0.0000") && (textGallon.text == "0.0000")) == false {
                
                //alert
                let refreshAlert = UIAlertController(title: "", message: "Your Data is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                //save
                arrLiquid.append(textGallon.text! + " Gallons = " + textLiter.text! + " Liters = " + textPint.text! + " Pints = " + textOunce.text! + " Ounce ")
                let defaults = UserDefaults.standard
                defaults.set(arrLiquid, forKey: "recentLiquid")
                
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
    
    // poreventing the user from entering two decimal values
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")
        
        if arrayOfString.count > 2 {
            return false
        }
        return true
    }
}
