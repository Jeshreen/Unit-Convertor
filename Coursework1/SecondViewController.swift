//
//  SecondViewController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/5/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate{
   
    @IBOutlet weak var textOunce: UITextField!
    @IBOutlet weak var textGrams: UITextField!
    @IBOutlet weak var textKg: UITextField!
    @IBOutlet weak var textStone: UITextField!
    @IBOutlet weak var textPound: UITextField!
    @IBOutlet weak var textStPounds: UITextField!
    var arrWeight = [String]()
    var savedArrWeight = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textOunce.becomeFirstResponder()
    
        // adding a gradient layer as background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red:0.89, green:0.58, blue:0.53, alpha:1.0).cgColor,UIColor(red:0.84, green:0.43, blue:0.46, alpha:1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(SecondViewController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }
    

    // set the values to user defaults to save when in background
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textOunce.text, forKey: "ounceValue")
        defaults.set(textPound.text, forKey: "poundValue")
        defaults.set(textGrams.text, forKey: "gramValue")
        defaults.set(textKg.text, forKey: "KgValue")
        defaults.set(textStone.text, forKey: "stoneValue")
        defaults.set(textStPounds.text, forKey: "stPoundsValue")
        defaults.synchronize()
    }
    
    // retrive the user defaults values from backgroound
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let ounceValue = defaults.string(forKey: "ounceValue")
        let poundValue = defaults.string(forKey: "poundValue")
        let gramsValue = defaults.string(forKey: "gramValue")
        let kgValue = defaults.string(forKey: "KgValue")
        let stoneValue = defaults.string(forKey: "stoneValue")
        let stPoundsValue = defaults.string(forKey: "stPoundsValue")
        textOunce.text = ounceValue
        textPound.text = poundValue
        textGrams.text = gramsValue
        textKg.text = kgValue
        textStone.text = stoneValue
        textStPounds.text = stPoundsValue
        
    }
    
    //display the keyboard when starting to type
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    //ounce changed function
    @IBAction func ounceChanged(_ sender: UITextField) {
        let ounceValue = (self.textOunce.text! as NSString).floatValue
        let poundValue = ounceValue / 16
        let gramValue = poundToGrams(pound: poundValue)
        let kgValue = gramToKg(gram: gramValue)
        let stoneValue = kgToStone(kg: kgValue)
        let stPoundsValue = kgToPounds(kg: kgValue)
        self.textPound.text = String(format: "%.4f", poundValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textKg.text = String(format: "%.4f",kgValue)
        self.textStone.text = "\(stoneValue)"
        self.textStPounds.text = String(format: "%.4f",stPoundsValue)
    }
    
    //pounds changed function
    @IBAction func poundChanged(_ sender: UITextField) {
        let poundValue = (self.textPound.text! as NSString).floatValue
        let ounceValue = poundValue * 16
        let gramValue = poundToGrams(pound: poundValue)
        let kgValue = gramToKg(gram: gramValue)
        let stoneValue = kgToStone(kg: kgValue)
        let stPoundsValue = kgToPounds(kg: kgValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textKg.text = String(format: "%.4f",kgValue)
        self.textStone.text = "\(stoneValue)"
        self.textStPounds.text = String(format: "%.4f",stPoundsValue)

    }
    
    //grams changed function
    @IBAction func gramsChanged(_ sender: UITextField) {
        let gramValue = (self.textGrams.text! as NSString).floatValue
        let poundValue = gramToPound(gram: gramValue)
        let ounceValue = poundValue * 16
        let kgValue = gramToKg(gram: gramValue)
        let stoneValue = kgToStone(kg: kgValue)
        let stPoundsValue = kgToPounds(kg: kgValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textPound.text = String(format: "%.4f",poundValue)
        self.textKg.text = String(format: "%.4f",kgValue)
        self.textStone.text = "\(stoneValue)"
        self.textStPounds.text = String(format: "%.4f",stPoundsValue)
    }
    
    //KG changed function
    @IBAction func kgChanged(_ sender: UITextField) {
        let kgValue = (self.textKg.text! as NSString).floatValue
        let gramValue = kgValue * 1000
        let poundValue = gramToPound(gram: gramValue)
        let ounceValue = poundValue * 16
        let stoneValue = kgToStone(kg: kgValue)
        let stPoundsValue = kgToPounds(kg: kgValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textPound.text = String(format: "%.4f",poundValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textStone.text = "\(stoneValue)"
        self.textStPounds.text = String(format: "%.4f",stPoundsValue)
    }
    
    //Stone value changed fucntion
    @IBAction func stoneChanged(_ sender: UITextField) {
        let stoneValue = (self.textStone.text! as NSString).floatValue
        let stPoundsValue = (self.textStPounds.text! as NSString).floatValue
        let kgValue = stonePoundsToKg(stone:stoneValue, pounds: stPoundsValue)
        let gramValue = kgValue * 1000
        let poundValue = gramToPound(gram: gramValue)
        let ounceValue = poundValue * 16
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textPound.text = String(format: "%.4f",poundValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textKg.text = String(format: "%.4f",kgValue)
    }
   
    //stone pounds value changed function
    @IBAction func stPoundsChanged(_ sender: UITextField) {
        let stPoundsValue = (self.textStPounds.text! as NSString).floatValue
        let stoneValue = (self.textStone.text! as NSString).floatValue
        
        if (stPoundsValue > 13){
            self.textStPounds.text = String(0.0)
        } else {
            let kgValue = stonePoundsToKg(stone:stoneValue, pounds: stPoundsValue)
            let gramValue = kgValue * 1000
            let poundValue = gramToPound(gram: gramValue)
            let ounceValue = poundValue * 16
            self.textOunce.text = String(format: "%.4f",ounceValue)
            self.textPound.text = String(format: "%.4f",poundValue)
            self.textGrams.text = String(format: "%.4f",gramValue)
            self.textKg.text = String(format: "%.4f",kgValue)
        }
    }
    
    //minor functions to change pound to grams
    func poundToGrams(pound:Float)->Float{
        let grams = pound * 453.59237
        return grams
    }
    
    //minor fucntions grams - KG
    func gramToKg(gram:Float)->Float{
        let Kg = gram / 1000
        return Kg
    }
    
    //minro functions grams - pound
    func gramToPound(gram:Float)->Float{
        let pound = gram / 453.59237
        return pound
    }
    
    //minor fucntions KG - stone
    func kgToStone(kg:Float)->Float{
        let stone = floor(kg / 6.35029318)
        return stone
    }
    
    //minor function KG - pounds
    func kgToPounds(kg:Float)->Float{
        let poundsVal = kg / 6.35029318
        let poundsNormal = poundsVal.truncatingRemainder(dividingBy: 1)
        let pounds = poundsNormal * 14
        return pounds
    }
    
    //minor fucntion stone pounds - KG
    func stonePoundsToKg(stone:Float , pounds:Float)->Float{
        let Kg = (stone + (pounds/14)) * 6.35029318
        return Kg
    }
    
    //minor function pound to ounce
    func poundToOunce(pound:Float)->Float{
        let ounce = (pound * 16)
        return ounce
    }
    
    // saving the data to an user defualt array
    @IBAction func saveData(_ sender: Any) {
       
        if let savedArrWeight = UserDefaults.standard.object(forKey: "recentWeight") as? [String]{
            arrWeight = savedArrWeight
        }
        
        //restricting to the recent 5
        if (arrWeight.count == 5){
            arrWeight.remove(at: 0)
        }
        
        //to prevent zeros getting saved
        if(textGrams.text == "0"){
            textGrams.text = String("0.0000")
        }
        if(textPound.text == "0"){
            textPound.text = String("0.0000")
        }
        if(textOunce.text == "0"){
            textOunce.text = String("0.0000")
        }
        if(textKg.text == "0"){
            textKg.text = String("0.0000")
        }
        if(textStone.text == "0"){
            textStone.text = String("0.0")
        }
        if(textStPounds.text == "0"){
            textStPounds.text = String("0.0000")
        }
        
        //saving the items
        if((textGrams.text?.isEmpty)! || (textPound.text?.isEmpty)! || (textOunce.text?.isEmpty)! || (textKg.text?.isEmpty)! || (textStone.text?.isEmpty)! || (textStPounds.text?.isEmpty)!) == false{
            if((textGrams.text == "0.0000") && (textPound.text == "0.0000") && (textOunce.text == "0.0000") && (textKg.text == "0.0000") && (textStone.text == "0.0") && (textStPounds.text == "0.0000")) == false {
                
                //alert
                let refreshAlert = UIAlertController(title: "", message: "Your Data is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                //save
                self.arrWeight.append(textOunce.text! + " Ounce = " + textPound.text! + " Pound = " + textGrams.text! + " Grams = " + textKg.text! + " Kilo Grams = " + textStone.text! + " Stone = " + textStPounds.text! + " Stone Pounds")
                let defaults = UserDefaults.standard
                defaults.set(self.arrWeight, forKey: "recentWeight")
                
            } else {
                
                //alert
                let refreshAlert = UIAlertController(title: "", message: "You Cannot save empty values or zeros", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
        } else {
            let refreshAlert = UIAlertController(title: "", message: "You Cannot save empty values or zeros", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
               
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
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

