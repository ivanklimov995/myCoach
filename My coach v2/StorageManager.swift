//
//  StorageManager.swift
//  My coach v2
//
//  Created by Иван Климов on 18.10.2022.
//

import Foundation
import RealmSwift


let realm = try! Realm ()

class StoragemManager{
    
    static func  saveObject(_ newTraining: Training){
        try! realm.write({
            realm.add(newTraining)
        })
    }
    
    static func deleteObgect(_ training: Training){
        try! realm.write({
            realm.delete(training)
        })
    }

}
