//
//  VolumeController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/12/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class VolumeController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textM3: UITextField!
    @IBOutlet weak var textCm3: UITextField!
    @IBOutlet weak var textLiter: UITextField!
    @IBOutlet weak var cm3Label: UILabel!
    @IBOutlet weak var m3Label: UILabel!

    var arrvolume = [String]()
    var savedArrVolume = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textM3.becomeFirstResponder()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(VolumeController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        //gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red:0.89, green:0.58, blue:0.53, alpha:1.0).cgColor,UIColor(red:0.84, green:0.43, blue:0.46, alpha:1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    
        //setting the super script font
        let font:UIFont? = UIFont(name:"HelveticaNeue", size:17)
        let fontSuper:UIFont? = UIFont(name:"HelveticaNeue", size:10)
        
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "cm3", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:8], range: NSRange(location:2,length:1))
        cm3Label.attributedText = attString
        
        let atString:NSMutableAttributedString = NSMutableAttributedString(string: "m3", attributes: [.font:font!])
        atString.setAttributes([.font:fontSuper!,.baselineOffset:8], range: NSRange(location:1,length:1))
        m3Label.attributedText = atString
        
        self.textM3.delegate = self
        self.textCm3.delegate = self
        self.textLiter.delegate = self
    }
    
    //keyboard automatically swipe down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //save user defaults
    @objc func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textM3.text, forKey: "m3Value")
        defaults.set(textCm3.text, forKey: "cm3Value")
        defaults.set(textLiter.text, forKey: "literValue")
        defaults.synchronize()
        
    }
    
    //apply user defaults
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let m3Value = defaults.string(forKey: "m3Value")
        let cm3Value = defaults.string(forKey: "cm3Value")
        let literValue = defaults.string(forKey: "literValue")
        textM3.text = m3Value
        textCm3.text = cm3Value
        textLiter.text = literValue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //m3 value changed
    @IBAction func m3Changed(_ sender: UITextField) {
        let m3Value = (self.textM3.text! as NSString).floatValue
        let cm3Value = m3Value * 1000000
        let literValue = cmToLiter(cm3: cm3Value)
        self.textCm3.text = String(format: "%.4f",cm3Value)
        self.textLiter.text = String(format: "%.4f",literValue)
    }
    
    //cm3 value changed
    @IBAction func cm3Changed(_ sender: UITextField) {
        let cm3Value = (self.textCm3.text! as NSString).floatValue
        let m3Value = cm3Value / 1000000
        let literValue = cmToLiter(cm3: cm3Value)
        self.textM3.text = String(format: "%.4f",m3Value)
        self.textLiter.text = String(format: "%.4f",literValue)
    }
    
    //Liter value changed
    @IBAction func literChanged(_ sender: UITextField) {
        let literValue = (self.textLiter.text! as NSString).floatValue
        let cm3Value = literValue * 1000
        let m3Value = cm3Value / 1000000
        self.textM3.text = String(format: "%.4f",m3Value)
        self.textCm3.text = String(format: "%.4f",cm3Value)
    }
    
    //minor fucntion cm - Liter
    func cmToLiter(cm3:Float)->Float{
        let liter = cm3 / 1000
        return liter
    }
    
    //saving the data
    @IBAction func saveData(_ sender: Any) {
        if let savedArrVolume = UserDefaults.standard.object(forKey: "recentVolume") as? [String]{
            arrvolume = savedArrVolume
        }
        
        //restricting to recent 5
        if (arrvolume.count == 5){
            arrvolume.remove(at: 0)
        }
        
        //to prevent zero being saved
        if(textCm3.text == "0"){
            textCm3.text = String("0.0000")
        }
        if(textM3.text == "0"){
            textM3.text = String("0.0000")
        }
        if(textLiter.text == "0"){
            textLiter.text = String("0.0000")
        }
        
        //saving the items
        if ((textLiter.text?.isEmpty)! || (textM3.text?.isEmpty)! || (textCm3.text?.isEmpty)!) == false {
            if((textM3.text == "0.0000") && (textCm3.text == "0.0000") && (textLiter.text == "0.0000")) == false {
                
                //alert
                let refreshAlert = UIAlertController(title: "", message: "Your Data is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                //save
                arrvolume.append(textM3.text! + " ㎥ = " + textCm3.text! + " c㎥ = " + textLiter.text! + " Liter ")
                let defaults = UserDefaults.standard
                defaults.set(arrvolume, forKey: "recentVolume")
                
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
    
    // preventing the user from entering teo decimal values
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")
        
        if arrayOfString.count > 2 {
            return false
        }
        return true
    }
}
