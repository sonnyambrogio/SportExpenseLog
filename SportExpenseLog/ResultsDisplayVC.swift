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
    
    
    



    //MARK:- Actions and Outlets
    
    @IBAction func unwindToResultsDisplayVC(segue: UIStoryboardSegue) {
    }

    
    @IBOutlet var backgroundViews: [UIView]!
    @IBOutlet weak var gameNumberLabel: UILabel!
    @IBOutlet weak var kmNumberLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeColourBackgroundsOnText()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK:- ***** Functions *****

    


}


//MARK:- Colour Extensions

extension ResutsDisplayVC {
    func removeColourBackgroundsOnText() {  // all text labels will have coloured backgrounds removed. They are just there for layout purposes
        for view in backgroundViews {
            view.backgroundColor = UIColor.clearColor()
        }
    }
}

