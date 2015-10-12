//
//  CompletedEntries-TVC.swift
//  SportExpenseLog
//
//  Created by Sonny Ambrogio on 2015-10-05.
//  Copyright © 2015 Viking Panda. All rights reserved.
//

import UIKit
import CoreData

class CompletedEntries_TVC: UITableViewController {
    
    //MARK: - Variables
    var expenses = [NSManagedObject]()
    
    var dateFormatter = NSDateFormatter()
    
    
    
    //MARK: - Actions
    @IBAction func BackButton(sender: UIBarButtonItem) {
        
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoreData()
        tableView.reloadData()
        navigationController?.navigationBar.tintColor = UIColor.badgerMaroon()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expenses.count
    }

    
    
    
    
    //MARK: - TableView Delgate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // get the "expense" from the "expenses Array"
        let expense = expenses[indexPath.row]
    
        // set the cell title text to match the text entered in the "AddNewExpense" Screen.
        cell.textLabel?.text = String(expense.valueForKey("titleValue")!)
        
        // create a string to display in the detailedTextLabel
        
        
        // create the detailed test String
        let distance = expense.valueForKey("kmDriven") as! Double
        let templitresPerKilometer = 0.075
        let distanceExpese = (templitresPerKilometer * distance)
        
        let food = expense.valueForKey("foodCost") as! Double
        let equipment = expense.valueForKey("equipmentCost") as! Double
        let hotel = expense.valueForKey("hotelCost") as! Double
        
        let total = (distanceExpese + food + equipment + hotel)
        
        let detailedStringToDisplay = "Total Cost of This Entry: $\(Int(total))"
        
        print("\(distance)")
        print("food \(food)")
        print("equip \(equipment)")
        print("hotel \(hotel)")
        print("total \(total)")
        print(detailedStringToDisplay)
        cell.detailTextLabel?.text = detailedStringToDisplay
        
        // Style the text in the Cell
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDel.managedObjectContext
            context.deleteObject(expenses[indexPath.row] as NSManagedObject)
            expenses.removeAtIndex(indexPath.row)
            
            do {
                try context.save()
            } catch let error as NSError {
                print(error)
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    //MARK: - Core Data
    
    func fetchCoreData() {
        let appDeleagte = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDeleagte.managedObjectContext
        
        // 2
        let fetchRequest = NSFetchRequest(entityName: "Expense")
        
        // 3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            expenses = results as! [NSManagedObject]
        } catch let error as NSError {
            print(error)
        }
    }


    }
