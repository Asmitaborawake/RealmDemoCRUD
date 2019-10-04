//
//  ViewController.swift
//  RealmCRUDDemo
//
//  Created by Asmita Borawake on 04/10/19.
//  Copyright © 2019 Asmita Borawake. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {

    @IBOutlet weak var pickuplineTableview: UITableView!
    
    var pickuplines : Results<PickUpLine>!
    var notificationToken : NotificationToken?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmService.shared.realm
        pickuplines = realm.objects(PickUpLine.self)
        pickuplineTableview.rowHeight = 85
        
      notificationToken =   realm.observe { (notification, realm) in
            self.pickuplineTableview.reloadData()
        }
        
        RealmService.shared.observeRealmError(vc: self) { (error) in
            //handle error here user alert to show error will do latter
            print(error ?? "no error")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        notificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(vc: self)
    }

    @IBAction func addBtnClick(_ sender: Any) {
        
        AlertService.addAlert(vc: self) { (line, score, email) in
            let newpickupline = PickUpLine(line: line, score: score, email: email)
            RealmService.shared.create(object: newpickupline)
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickuplines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pickuplineTableview.dequeueReusableCell(withIdentifier: "pickupcell", for: indexPath) as! PickUpLineTableViewCell
        
        let pickupline = pickuplines[indexPath.row]
        cell.configureData(pickuplinedata: pickupline)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selecteed")
        
        let pickupline = pickuplines[indexPath.row]
        AlertService.update(vc: self, pickupLine: pickupline) { (line, score, email) in
            let dict : [String:Any?] = ["line": line, "score":score, "email": email]
            RealmService.shared.update(object: pickupline, dictionery: dict)
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        let pickupline = pickuplines[indexPath.row]
        
        RealmService.shared.delete(object: pickupline)
    }
    
    
}

