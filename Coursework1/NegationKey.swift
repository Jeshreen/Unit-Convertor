//
//  NegationKey.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/26/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class NegationKey: UITextField {
        
        let temperature = TemperatureController()
        
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.keyboardType = UIKeyboardType.decimalPad
        }
        
        //creating the negation button
        fileprivate func getAccessoryButtons() -> UIView
        {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.superview!.frame.size.width, height: 44))
            view.backgroundColor = UIColor(red:0.80, green:0.82, blue:0.85, alpha:1.0)
            
            let minusButton = UIButton(type: UIButtonType.custom)
            minusButton.setTitle("NEGATION", for: UIControlState())
            let buttonWidth = view.frame.size.width;
            minusButton.frame = CGRect(x: 70, y: 0, width: buttonWidth, height: 44);
            minusButton.addTarget(self, action: #selector(NegationKey.minusTouchUpInside(_:)), for: UIControlEvents.touchUpInside)
            view.addSubview(minusButton)
            return view;
        }
        
        
        //adding the minus value to the text box
        @objc func minusTouchUpInside(_ sender: UIButton!) {
            
            let text = self.text!
            if(text.isEmpty == false) {
                let index: String.Index = text.index(text.startIndex, offsetBy: 1)
                let firstChar = text[..<index]
                if firstChar == "-" {
                    self.text = String(text[index...])
                } else {
                    self.text = "-" + text
                    self.endEditing(true)
                }
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            self.inputAccessoryView = getAccessoryButtons()
        }
        
    

}
