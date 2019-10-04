//
//  RealmService.swift
//  RealmCRUDDemo
//
//  Created by Asmita Borawake on 04/10/19.
//  Copyright © 2019 Asmita Borawake. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    private init(){}
    
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T:Object>(object: T){
        
        do{
            try realm.write {
                realm.add(object)
            }
        }catch{
            post(error: error)
        }
        
    }
    
    func update<T: Object>(object: T, dictionery: [String:Any?]){
        do {
            try realm.write {
                for (key,value) in dictionery{
                    object.setValue(value, forKey: key)
                }
            }
        }catch{
            post(error: error)
        }
    }
    
    func delete<T: Object>(object : T){
        do{
            try realm.write {
                realm.delete(object)
            }
        }catch{
            post(error: error)
        }
    }
    
    
    func post(error :Error){
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func observeRealmError(vc: UIViewController, compliation: @escaping (Error?) -> Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { (notification) in
            compliation(notification.object as? Error)
        }
    }
    
    
    func stopObservingErrors(vc: UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
}
