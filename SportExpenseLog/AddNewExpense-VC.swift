//
//  AddNewExpense-VC.swift
//  SportExpenseLog
//
//  Created by Sonny Ambrogio on 2015-10-05.
//  Copyright © 2015 Viking Panda. All rights reserved.
//

import UIKit
import CoreData

class AddNewExpense_VC: UIViewController {
    
    //MARK: - Variables
    var expenses = [NSManagedObject]()

    
    //MARK: - Outlets
    
    @IBOutlet weak var expenseNameTextInput: UITextField!
    @IBOutlet weak var kmDrivenTextInput: UITextField!
    

    //MARK: - Actions
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
       
        saveExpense()
        self.performSegueWithIdentifier("segueBackToList", sender: nil)
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCoreData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Functions
    
    func saveExpense() {
        // 1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // 2
        let entity = NSEntityDescription.entityForName("Expense", inManagedObjectContext: managedContext)
        
        let _expense = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        let kmTextInputtoInt = Int(kmDrivenTextInput.text!)
        
        
        // 3
        _expense.setValue(expenseNameTextInput!.text, forKey: "titleText")
        _expense.setValue(kmTextInputtoInt, forKey: "kmDriven")
        
        // 4
        do {
             expenses.append(_expense)
           try managedContext.save()
            print(expenses)
            
            // 5
            
        } catch {
            print("oops")
        }
    }
    
    func fetchCoreData() {
        let appDeleagte = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDeleagte.managedObjectContext
        
        // 2
        let fetchRequest = NSFetchRequest(entityName: "Expense")
        
        // 3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            expenses = results as! [NSManagedObject]
        } catch {
            print("shit")
        }
    }
    
    
    
    
    
    
    

}