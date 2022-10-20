//
//  TableViewController.swift
//  My coach v2
//
//  Created by Иван Климов on 18.10.2022.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {

    //MARK: cделать возможность повтора тренировки - если свайпнуть по ячейке
    //MARK: пофиксить баг - при создании новой трени не обновляется таблица где-то и вылетает иногда
    
    @IBOutlet weak var deleteOutlet: UIButton!
    
    var myTraining: Results<Training>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.rowHeight = 300.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTraining = realm.objects(Training.self)
        self.myTraining = self.myTraining.sorted(byKeyPath: "date", ascending: false)
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myTraining.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        cell.deleteOutlet.tag = indexPath.row
        let train = myTraining[indexPath.row]
        cell.dateLabel.text = "\(train.date.formatted(date: .abbreviated, time: .omitted))"
        cell.getExercise(training: train)
        cell.deleteOutlet.tag = indexPath.row
        return cell
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            let ind = sender.tag
            StoragemManager.deleteObgect(self.myTraining[ind])
        }
        
        self.myTraining = realm.objects(Training.self)
        self.myTraining = self.myTraining.sorted(byKeyPath: "date", ascending: false)
        self.tableView.reloadData()
    }
    
    

    
    // MARK: - Navigation

     @IBAction func unwingSegue( _ segue: UIStoryboardSegue) {
         guard let newTrenVC = segue.source as? NewTrenViewController else {return}
         DispatchQueue.main.async {
             StoragemManager.saveObject(newTrenVC.newTren)
         }
     
         self.myTraining = realm.objects(Training.self)
         self.myTraining = self.myTraining.sorted(byKeyPath: "date", ascending: false)
         self.tableView.reloadData()
     }
    
     func prepare(for segue: UIStoryboardSegue, sender: UIButton) {
        if segue.identifier == "Replay" {
            guard let destination = segue.source as? NewTrenViewController else {return}
            destination.repeatedTren.date = myTraining[sender.tag].date
            destination.repeatedTren.exercises = myTraining[sender.tag].exercises
        }
    }
    
    

}
