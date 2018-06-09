//
//  WeightHistoryController.swift
//  Coursework1
//
//  Created by Jeshreen Balraj on 3/17/18.
//  Copyright © 2018 Jeshreen Balraj. All rights reserved.
//

import UIKit

class WeightHistoryController: UIViewController{

    
    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
    var arrweight = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting the gradient to the background
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
    
    // getting the data according to the user default key
    override func viewWillAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "recentWeight") as? [String]{
            arrweight = x
           
        }
        printDataWeight()
    }

    //printing the data a to the label
    func printDataWeight(){
        if (arrweight.isEmpty == false){
            if arrweight.indices.contains(0){
                conversionlbl1.text = arrweight[0]
            }
            if arrweight.indices.contains(1){
                conversionlbl2.text = arrweight[1]
            }
            if arrweight.indices.contains(2){
                conversionlbl3.text = arrweight[2]
            }
            if arrweight.indices.contains(3){
                conversionlbl4.text = arrweight[3]
            }
            if arrweight.indices.contains(4){
                conversionlbl5.text = arrweight[4]
            }
        }
    }

}
