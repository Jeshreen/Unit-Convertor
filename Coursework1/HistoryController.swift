//
//  HistoryController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/16/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class HistoryController: UIViewController {

    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
    
    var speed = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //background gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red:0.89, green:0.58, blue:0.53, alpha:1.0).cgColor,UIColor(red:0.84, green:0.43, blue:0.46, alpha:1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //getting the data according to the user defaulk key
    override func viewWillAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "recentSpeed") as? [String]{
            speed = x
            printDataSpeed()
        }
    }
    
    //printing the data to the respective labels
    func printDataSpeed(){
        if (speed.isEmpty == false){
            if speed.indices.contains(0){
                conversionlbl1.text = speed[0]
            }
            if speed.indices.contains(1){
                conversionlbl2.text = speed[1]
            }
            if speed.indices.contains(2){
                conversionlbl3.text = speed[2]
            }
            if speed.indices.contains(3){
                conversionlbl4.text = speed[3]
            }
            if speed.indices.contains(4){
                conversionlbl5.text = speed[4]
            }
        }
    }
    
}
