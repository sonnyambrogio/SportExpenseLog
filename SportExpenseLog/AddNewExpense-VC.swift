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
    var nsDate = NSDateFormatter()

    var hotelValueToSave: Int?
    var foodValueToSave: Int?
    var kmValueToSave: Int?
    var gamesValueToSave: Int?
    var equipmentValueToSave: Int?
    var titleValueToSave: String?
    
    var guardFailed: Bool?
    
    
    //MARK: - Outlets
    

    
    
    @IBOutlet weak var expenseTypeOutlet: UISegmentedControl!
    @IBOutlet weak var kmDrivenStackView: UIStackView!
    @IBOutlet weak var gearInfoStackView: UIStackView!
    @IBOutlet weak var foodInfoStackView: UIStackView!
    @IBOutlet weak var hotelInfoStackView: UIStackView!
    @IBOutlet weak var tournyInfoStackView: UIStackView!

    
    // TournyInput Outlets
    @IBOutlet weak var tournyHotelTextField: UITextField!
    @IBOutlet weak var tournyFoodTextField: UITextField!
    @IBOutlet weak var tournyKmTextField: UITextField!
    @IBOutlet weak var tournyNumGamesTextField: UITextField!
    
    // Standalone Hotel Input
    @IBOutlet weak var standAloneHotelTextInput: UITextField!
    
    // StandAlone Food Input
    @IBOutlet weak var standAloneFoodTextInput: UITextField!
    
    // StandAlone Equipment Input

    @IBOutlet weak var standAloneEquipmentCostTextField: UITextField!
    
    // StandAlone km Driven Input
    @IBOutlet weak var standAloneKmTextInput: UITextField!
    

    
    //MARK: - Actions

    @IBAction func expenseTypeSegmentedControl(sender: UISegmentedControl) {
        presentProperStackBasedOnSegment()
        
    }
    
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
        
        // perform guard before saving
        guardBeforeSave()
        
        if guardFailed == false {
        // Save as an expense in coreData
        saveExpense()
        }
        
        // Segue back to the list when save function completes
        self.performSegueWithIdentifier("segueToMain", sender: nil)
    }
    

    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register taps for keyboard dismissal
        registerTap()
        
        // set the NavigationaBar style
        navigationController?.navigationBar.tintColor = UIColor.badgerMaroon()
        
        
        // Fetch CoreData for appending new instances
        fetchCoreData()

        // set all stackViews as hidden(stay hidden until individual segmentes are selected.)
        hideAllStackViews()
        
        // the inital segment selected by default is the farthest Left, which happens to be
        // the tounamentInfo input...So set the tournyInfo StackView to be visable by default
        tournyInfoStackView.hidden = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        // observers for when the keyboeard is on or off screen
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
   

}













//MARK: - StackView Handling

extension AddNewExpense_VC {
    
    func hideAllStackViews() {
        tournyInfoStackView.hidden = true
        hotelInfoStackView.hidden = true
        foodInfoStackView.hidden = true
        gearInfoStackView.hidden = true
        kmDrivenStackView.hidden = true
    }
    
    func presentProperStackBasedOnSegment() {
        
        // Initialy hide all stack views
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

        // 3 - this is where the setting of the values comes in
        
        _expense.setValue(foodValueToSave, forKey: "foodCost")
        _expense.setValue(hotelValueToSave, forKey: "hotelCost")
        _expense.setValue(kmValueToSave, forKey: "kmDriven")
        _expense.setValue(gamesValueToSave, forKey: "gamesAttended")
        _expense.setValue(equipmentValueToSave, forKey: "equipmentCost")
        _expense.setValue(nsDate, forKey: "date")
        _expense.setValue(titleValueToSave, forKey: "titleValue")
        
        // 4 - Saving the setValues ans an "expense"
        do {
            expenses.append(_expense)
            try managedContext.save()
            print(expenses)
            
            // 5 - error handling
            
        } catch let error as NSError {
            print(error)
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
        } catch let error as NSError {
            print(error)
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



//MARK:- General Functions

extension AddNewExpense_VC {
    
    // tapGestureRecogniser
    func registerTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard"))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
    }
    
    // dismiss the keyboard from View
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // move view up when keyboard is brought on screen to ensure keyboard does not cover TextField Entries.
    // This should be tweeked somehow to ensure that this only takes place on smaller screens. Not really needed on 6 or 6+
    func keyboardWillShow(notification: NSNotification) {

        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.view.transform = CGAffineTransformMakeTranslation(0, -110)
            }, completion: nil)
        
    }
    
    // move the view back down when the keyboard is dismissed.
    func keyboardWillHide(notification: NSNotification) {
        
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.view.transform = CGAffineTransformIdentity
            }, completion: nil)
    }

    

    /*
     Before saving a new entry, guard for errors in empty attributes and apply a Label depicting what it was being saved.
     ive included "0" entries in the standAlone inputs because im not really sure if when i go to add all the attributes up
     on the results screen if the adding function will error out when it comes accross nil.
    **This should also be changed to swith Statement when time is perimtted**
    */
    func guardBeforeSave() {
        
        if expenseTypeOutlet.selectedSegmentIndex == 0 {
            if tournyNumGamesTextField.text?.isEmpty == true || tournyKmTextField.text?.isEmpty == true || tournyHotelTextField.text?.isEmpty == true || tournyFoodTextField.text?.isEmpty == true {
                guardFailed = true
                fillAllTextFieldsAlert()
            } else {
                guardFailed = false
                hotelValueToSave = Int(tournyHotelTextField.text!)
                foodValueToSave = Int(tournyFoodTextField.text!)
                kmValueToSave = Int(tournyKmTextField.text!)
                gamesValueToSave = Int(tournyNumGamesTextField.text!)
                equipmentValueToSave = 0
                titleValueToSave = "Tournament"
            }
        }
        if expenseTypeOutlet.selectedSegmentIndex == 1 {
            if standAloneHotelTextInput.text?.isEmpty == true {
                guardFailed = true
                fillAllTextFieldsAlert()
            } else {
                guardFailed = false
                hotelValueToSave = Int(standAloneHotelTextInput.text!)
                foodValueToSave = 0
                kmValueToSave = 0
                gamesValueToSave = 0
                equipmentValueToSave = 0
                titleValueToSave = "Hotel"
            }
        }
        if expenseTypeOutlet.selectedSegmentIndex == 2 {
            if standAloneFoodTextInput.text?.isEmpty == true {
                guardFailed = true
                fillAllTextFieldsAlert()
            } else {
                guardFailed = false
                hotelValueToSave = 0
                foodValueToSave = Int(standAloneFoodTextInput.text!)
                kmValueToSave = 0
                gamesValueToSave = 0
                equipmentValueToSave = 0
                titleValueToSave = "Food"
            }
        }
        if expenseTypeOutlet.selectedSegmentIndex == 3 {
            if standAloneEquipmentCostTextField.text?.isEmpty == true {
                guardFailed = true
                fillAllTextFieldsAlert()
            } else {
                guardFailed = false
                hotelValueToSave = 0
                foodValueToSave = 0
                kmValueToSave = 0
                gamesValueToSave = 0
                equipmentValueToSave = Int(standAloneEquipmentCostTextField.text!)
                titleValueToSave = "Equipment"
            }
        }
        if expenseTypeOutlet.selectedSegmentIndex == 4 {
            if standAloneKmTextInput.text?.isEmpty == true {
                guardFailed = true
                fillAllTextFieldsAlert()
            } else {
                guardFailed = false
                hotelValueToSave = 0
                foodValueToSave = 0
                kmValueToSave = Int(standAloneKmTextInput.text!)
                gamesValueToSave = 1
                equipmentValueToSave = 0
                titleValueToSave = "Game"
            }
        }
    }
}