//
//  FirstViewController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/5/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var electronLable: UILabel!
    @IBOutlet weak var protonLabel: UILabel!
    @IBOutlet weak var neutronLabel: UILabel!
    @IBOutlet weak var ePermittivityLable: UILabel!
    @IBOutlet weak var magneticLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red:0.89, green:0.58, blue:0.53, alpha:1.0).cgColor,UIColor(red:0.84, green:0.43, blue:0.46, alpha:1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let font:UIFont? = UIFont(name:"HelveticaNeue-Italic", size:20)
        let fontSuper:UIFont? = UIFont(name:"HelveticaNeue-Italic", size:10)
        
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "me", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        electronLable.attributedText = attString
        
        let proString:NSMutableAttributedString = NSMutableAttributedString(string: "mp", attributes: [.font:font!])
        proString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        protonLabel.attributedText = proString
      
        let neuString:NSMutableAttributedString = NSMutableAttributedString(string: "mn", attributes: [.font:font!])
        neuString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        neutronLabel.attributedText = neuString
        
        let permString:NSMutableAttributedString = NSMutableAttributedString(string: "\u{03b5}0", attributes: [.font:font!])
        permString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        ePermittivityLable.attributedText = permString
       
        let magString:NSMutableAttributedString = NSMutableAttributedString(string: "\u{03bc}0", attributes: [.font:font!])
        magString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        magneticLable.attributedText = magString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

