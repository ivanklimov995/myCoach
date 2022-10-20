//
//  File.swift
//  My coach v2
//
//  Created by Иван Климов on 18.10.2022.
//

import Foundation
import RealmSwift

class Training: Object {
    @objc dynamic var date = Date()
    var exercises = List<Exercise>()
    
    func createExercise(name: String, weight: Int, approaches: Int)  {
        let newExercise = Exercise()
        newExercise.nameExercise = name
        newExercise.weightExercise = weight
        newExercise.approachesExercise = approaches
        exercises.append(newExercise)
        
    }
}

class Exercise: Object{
    @objc dynamic var nameExercise: String = ""
    @objc dynamic var weightExercise: Int = 0
    @objc dynamic var approachesExercise: Int = 0
}
