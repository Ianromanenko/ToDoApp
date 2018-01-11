//
//  ChangeTaskViewController.swift
//  ToDoApp
//
//  Created by Yan on 2018-01-10.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit
import CoreData

class ChangeTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    let context = PersistanceService.context
    var chosenTask: ToDo?
    
    override func viewWillAppear(_ animated: Bool) {
        titleTextView.text = chosenTask?.title
        if chosenTask?.notes == "" {
            notesTextView.text = "Description"
        } else {
            notesTextView.text = chosenTask?.notes
        }
    }
    
    @IBAction func updateBtn(_ sender: UIButton) {
        chosenTask?.title = titleTextView.text
        chosenTask?.notes = notesTextView.text
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.context.delete(self.chosenTask!)
            PersistanceService.saveContext()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(chosenTask ?? "")
   
    }

}
