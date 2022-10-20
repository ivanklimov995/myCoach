//
//  CollectionViewCell.swift
//  My coach v2
//
//  Created by Иван Климов on 18.10.2022.
//

import UIKit
import RealmSwift
class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exerciseWeighAndApo: UITextView!
    @IBOutlet weak var exerciseName: UILabel!
    
    
    func appendedTextView(exercise: Exercise) {
            exerciseName.text = exercise.nameExercise
            exerciseWeighAndApo.text = "Вес \(exercise.weightExercise), повторов \(exercise.approachesExercise) \n"
    }
}
