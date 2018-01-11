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

    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].notes
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showChangeTaskViewController", sender: self)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do{
            let list = try PersistanceService.context.fetch(fetchRequest)
            self.list = list
            self.tableView.reloadData()
        } catch {}

    }

    
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
            task.title = title
            task.notes = notes
            PersistanceService.saveContext()
            self.list.append(task)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
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

    
    
    
    

    

