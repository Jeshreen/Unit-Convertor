//
//  LiquidHistoryController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/17/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class LiquidHistoryController: UIViewController {

    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
    var liquid = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //settign the gradient background
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
    
    //getting the data accordign the user default key
    override func viewWillAppear(_ animated: Bool) {
        if let n = UserDefaults.standard.object(forKey: "recentLiquid") as? [String]{
            liquid = n
            printDataLiquid()
        }
    }
    
    //printing the data according to the labels
    func printDataLiquid(){
        if (liquid.isEmpty == false){
            if liquid.indices.contains(0){
                conversionlbl1.text = liquid[0]
            }
            if liquid.indices.contains(1){
                conversionlbl2.text = liquid[1]
            }
            if liquid.indices.contains(2){
                conversionlbl3.text = liquid[2]
            }
            if liquid.indices.contains(3){
                conversionlbl4.text = liquid[3]
            }
            if liquid.indices.contains(4){
                conversionlbl5.text = liquid[4]
            }
        }
    }
    
}
