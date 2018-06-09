//
//  MinusCodeController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/19/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class MinusCodeController: UIViewController {
    
    let temperature = TemperatureController()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.keyboardType = UIKeyboardType.decimalPad
        
    }
    
    fileprivate func getAccessoryButtons() -> UIView
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.superview!.frame.size.width, height: 44))
        view.backgroundColor = UIColor.lightGray
        
        let minusButton = UIButton(type: UIButtonType.custom)
        //        let doneButton = UIButton(type: UIButtonType.custom)
        minusButton.setTitle("-", for: UIControlState())
        //        doneButton.setTitle("Done", for: UIControlState())
        let buttonWidth = view.frame.size.width/3;
        minusButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: 44);
        //        doneButton.frame = CGRect(x: view.frame.size.width - buttonWidth, y: 0, width: buttonWidth, height: 44);
        
        minusButton.addTarget(self, action: #selector(DecimalMinusTextField.minusTouchUpInside(_:)), for: UIControlEvents.touchUpInside)
        //        doneButton.addTarget(self, action: #selector(DecimalMinusTextField.doneTouchUpInside(_:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(minusButton)
        //        view.addSubview(doneButton)
        
        return view;
    }
    
    @objc func minusTouchUpInside(_ sender: UIButton!) {
        
        let text = self.text!
        if(text.characters.count > 0) {
            let index: String.Index = text.characters.index(text.startIndex, offsetBy: 1)
            let firstChar = text.substring(to: index)
            if firstChar == "-" {
                self.text = text.substring(from: index)
                //temperature.celciusChanged(text)
            } else {
                self.text = "-" + text
            }
        }
    }
    
    //    @objc func doneTouchUpInside(_ sender: UIButton!) {
    //        self.resignFirstResponder();
    //
    //    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.inputAccessoryView = getAccessoryButtons()
    }

  

}
