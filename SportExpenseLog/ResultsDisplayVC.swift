//
//  ViewController.swift
//  SportExpenseLog
//
//  Created by Sonny Ambrogio on 2015-09-25.
//  Copyright © 2015 Viking Panda. All rights reserved.
//

import UIKit
import CoreData

class ResutsDisplayVC: UIViewController {
    
    //MARK:- IVARS
  
    let expenses = [NSManagedObject]()
    let litersPerKm = 0.075
    
    var totalCost = 0
    var totalGames = 0
    var totalkm = 0
    



    //MARK:- Actions and Outlets
    
    @IBAction func unwindToResultsDisplayVC(segue: UIStoryboardSegue) {
        updateDisplay()
    }

    
    @IBOutlet var backgroundViews: [UIView]!
    @IBOutlet weak var gameNumberLabel: UILabel!
    @IBOutlet weak var kmNumberLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
        removeColourBackgroundsOnText()
 
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK:- ***** Functions *****

    func updateDisplay() {
        addTotals()
        let km = Double(totalkm)
        let kmTotalCost = (km * litersPerKm)
        let total = totalCost + Int(kmTotalCost)
        
        totalMoneyLabel.text = "$\(total)"
        gameNumberLabel.text = String(totalGames)
        kmNumberLabel.text = "\(totalkm) km"
    }
    


}


//MARK:- Colour Extensions

extension ResutsDisplayVC {
    func removeColourBackgroundsOnText() {  // all text labels will have coloured backgrounds removed. They are just there for layout purposes
        for view in backgroundViews {
            view.backgroundColor = UIColor.clearColor()
        }
    }
    
    
    // retrieve all cost and add them together
    func addTotals () {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext : NSManagedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Expense")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            print("===\(results)")
            
            //calculate grand expense
            var moneyGrandTotal  = 0
            var gamesGrandTotal = 0
            var kmGrandTotal = 0
            
            
            for order in results {
                let hotelTotals = order.valueForKey("hotelCost") as! Int
                let foodTotals = order.valueForKey("foodCost") as! Int
                let equipmentTotals = order.valueForKey("equipmentCost") as! Int
                let kmTotal = order.valueForKey("kmDriven") as! Int
                let gameTotal = order.valueForKey("gamesAttended") as! Int
                
                moneyGrandTotal += (hotelTotals + foodTotals + equipmentTotals)
                gamesGrandTotal += gameTotal
                kmGrandTotal += kmTotal
            }
            totalCost = moneyGrandTotal
            totalGames = gamesGrandTotal
            totalkm = kmGrandTotal
            
            print("grand Total = \(moneyGrandTotal)")
        } catch let error as NSError {
            print(error)
        }
    }
  
}

extension UIColor {
    class func badgerMaroon() -> UIColor {
        let colour = UIColor(red: 152/255, green: 24/255, blue: 47/255, alpha: 1)
        return colour
    }
}


