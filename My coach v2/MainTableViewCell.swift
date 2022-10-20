//
//  MainTableViewCell.swift
//  My coach v2
//
//  Created by Иван Климов on 18.10.2022.
//

import UIKit
import RealmSwift

class MainTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    
    lazy var allExerciseInTren = List<Exercise>()
  
    
    @IBOutlet weak var deleteOutlet: UIButton!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func getExercise(training: Training){
        self.allExerciseInTren = training.exercises
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        layout.scrollDirection = .horizontal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allExerciseInTren.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection Cell", for: indexPath) as! CollectionViewCell
        
        collectionCell.appendedTextView(exercise: allExerciseInTren[indexPath.row])
        return collectionCell
    }
    
}


extension MainTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.frame.height
        let widht = collectionView.frame.width / 1.5
        return CGSize(width: widht, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
