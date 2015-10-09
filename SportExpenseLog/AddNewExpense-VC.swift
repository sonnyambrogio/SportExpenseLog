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
    
    var expenses = [NSManagedObject]()  // coredata managed object
    var date = NSDate()
    
    
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var numOfGamesTextInput: UITextField!
    @IBOutlet weak var gearInputTextField: UITextField!
    @IBOutlet var kmInputTextField: [UITextField]!
    @IBOutlet var foodInputTextField: [UITextField]!
    @IBOutlet var hotelInputTextField: [UITextField]!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var expenseTypeOutlet: UISegmentedControl!
    @IBOutlet weak var kmDrivenStackView: UIStackView!
    @IBOutlet weak var gearInfoStackView: UIStackView!
    @IBOutlet weak var foodInfoStackView: UIStackView!
    @IBOutlet weak var hotelInfoStackView: UIStackView!
    @IBOutlet weak var tournyInfoStackView: UIStackView!

    
    // UserInput Outlets
    @IBOutlet weak var HotelCostTextField: UITextField!
    @IBOutlet weak var FoodCostTextField: UITextField!
    @IBOutlet weak var NumberOfGamesTextField: UITextField!
    @IBOutlet weak var kmDrivenTextField: UITextField!
    @IBOutlet weak var equipmentCostTextField: UITextField!
    

    
    //MARK: - Actions

    @IBAction func expenseTypeSegmentedControl(sender: UISegmentedControl) {
        presentProperStackBasedOnSegment()
        
    }
    
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
        // Save as an expense in coreData
        saveExpense()
        print(date)
        
        // Segue back to the list when save function completes
        self.performSegueWithIdentifier("segueBackToList", sender: nil)
    }
    

    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch CoreData for appending new instances
        fetchCoreData()

        // set all stackViews as hidden(stay hidden until individual segmentes are selected.
        hideAllStackViews()
        
        // the inital segment selected by default is the farthest Left, which happens to be
        // the tounamentInfo input...So set the tournyInfo StackView to be visable
        tournyInfoStackView.hidden = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}













//MARK: - Functions

extension AddNewExpense_VC {
    
    func hideAllStackViews() {
        tournyInfoStackView.hidden = true
        hotelInfoStackView.hidden = true
        foodInfoStackView.hidden = true
        gearInfoStackView.hidden = true
        kmDrivenStackView.hidden = true
    }
    
    func presentProperStackBasedOnSegment() {
        
        // hide all stack views
        hideAllStackViews()
        
        // show the proper StackView Based on segment selection..(Change to Switch Statement Later)
        if expenseTypeOutlet.selectedSegmentIndex == 0 {
            tournyInfoStackView.hidden = false
        }
        if expenseTypeOutlet.selectedSegmentIndex == 1 {
            hotelInfoStackView.hidden = false
            
        }
        if expenseTypeOutlet.selectedSegmentIndex == 2 {
            foodInfoStackView.hidden = false
            
        }
        if expenseTypeOutlet.selectedSegmentIndex == 3 {
            gearInfoStackView.hidden = false
            
        }
        if expenseTypeOutlet.selectedSegmentIndex == 4 {
            kmDrivenStackView.hidden = false
        }
    }

    
    func keyboardWasShown(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
 
}
















//MARK:- CoreData Functions

extension AddNewExpense_VC {
    
    
    func saveExpense() {
        // 1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // 2
        let entity = NSEntityDescription.entityForName("Expense", inManagedObjectContext: managedContext)
        
        let _expense = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        
        
        // 3
        
        _expense.setValue(Int(FoodCostTextField.text!), forKey: "foodCost")
        _expense.setValue(Int(HotelCostTextField.text!), forKey: "hotelCost")
        _expense.setValue(Int(kmDrivenTextField.text!), forKey: "kmDriven")
        _expense.setValue(Int(NumberOfGamesTextField.text!), forKey: "gamesAttended")
        _expense.setValue(Int(equipmentCostTextField.text!), forKey: "equipmentCost")
        
        
        
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


//MARK:- Alerts

extension AddNewExpense_VC {
    
    func fillAllTextFieldsAlert() {
        
        let alert = UIAlertController(title: "Problem Detected", message: "Please Fill In All Text Fields", preferredStyle: .Alert)
        
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(ok)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}













