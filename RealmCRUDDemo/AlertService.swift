//
//  AlertService.swift
//  RealmCRUDDemo
//
//  Created by Asmita Borawake on 04/10/19.
//  Copyright © 2019 Asmita Borawake. All rights reserved.
//

import Foundation
import UIKit

class AlertService{
    
    private init(){}
    
    static func addAlert(vc: UIViewController, completion: @escaping (String, Int?, String?) -> Void){
        
        let alert = UIAlertController(title: "Add Line", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTF) in
            lineTF.placeholder = "Enter Pickup Line"
        }
        alert.addTextField { (scoreTF) in
            scoreTF.placeholder = "Enter Score"
        }
        alert.addTextField { (emailTF) in
            emailTF.placeholder = "Enter Email"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                let scoreString = alert.textFields?[1].text,
                let emailString = alert.textFields?.last?.text
                else {return}
            
            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString
            
            completion(line,score,email)
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func update(vc: UIViewController, pickupLine: PickUpLine, completion: @escaping (String, Int?, String?) -> Void){
        
        let alert = UIAlertController(title: "Update Line", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTF) in
            lineTF.placeholder = "Enter Pickup Line"
            lineTF.text = pickupLine.line
        }
        alert.addTextField { (scoreTF) in
            scoreTF.placeholder = "Enter Score"
            scoreTF.text = pickupLine.scoreString()
        }
        alert.addTextField { (emailTF) in
            emailTF.placeholder = "Enter Email"
            emailTF.text = pickupLine.email
        }
        
        let action = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                let scoreString = alert.textFields?[1].text,
                let emailString = alert.textFields?.last?.text
                else {return}
            
            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString
            
            completion(line,score,email)
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}

