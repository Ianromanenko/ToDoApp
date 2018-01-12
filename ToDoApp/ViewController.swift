//
//  ViewController.swift
//  ToDoApp
//
//  Created by Yan on 2018-01-10.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var list = [ToDo]()

    
    
    //Table set up
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showChangeTaskViewController", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    //Dynamic cell set up with data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CellsLbl") as! CellsLbl
       // cell.titleLbl.text = list[indexPath.row].title
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].notes
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        return cell
    }
 
    
    
    //Fetch data and tableView reloading
    override func viewWillAppear(_ animated: Bool) {
        //self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        //self.tableView.reloadData()
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do{
            let list = try PersistanceService.context.fetch(fetchRequest)
            self.list = list
            self.tableView.reloadData()
        } catch {}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    //Add new ToDo
    @IBAction func addTaskTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add ToDo", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Notes"
        }
        let action = UIAlertAction(title: "Post", style: .default){ (_) in
            let title = alert.textFields!.first!.text!
            let notes = alert.textFields!.last!.text!
            let task = ToDo(context: PersistanceService.context)
            if title == "" {} else {
            task.title = title
            task.notes = notes
            task.isCompleted = false
            PersistanceService.saveContext()
            self.list.append(task)
            self.tableView.reloadData()
            }}
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //Preparing for segue and getting data of selected cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChangeTaskViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedTask = list[indexPath.row]
                let changedTaskVC = segue.destination as! ChangeTaskViewController
                changedTaskVC.chosenTask = selectedTask
            }
        }
    }
}

    
    
    
    

    

