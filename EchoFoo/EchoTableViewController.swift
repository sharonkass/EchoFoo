//
//  EchoTableViewController.swift
//  EchoFoo
//
//  Created by Sharon Kass on 2/3/17.
//  Copyright © 2017 RoboTigers. All rights reserved.
//

import UIKit
import CoreData

class EchoTableViewController: UITableViewController {

    var echoArray: [NSManagedObject] = []
    
    @IBAction func refreshButtonAction(_ sender: UIBarButtonItem) {
        print("Refresh table")
        refreshEchoArray()
        tableView.reloadData()
    }
    
    private func refreshEchoArray() {
        CoreDataStack.defaultStack.syncWithCompletion(nil)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Echo")
        do {
            let resultArray = try CoreDataStack.defaultStack.managedObjectContext.fetch(fetchRequest)
            self.echoArray = (resultArray as NSArray) as! [NSManagedObject]
        } catch {
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Refresh echoArray everytime the view loads
        // SHARON: Taking this out and replacing with Ensemble CoreDataStack below
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Echo")
//        do {
//            echoArray = try managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
        
//        CoreDataStack.defaultStack.syncWithCompletion(nil)
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Echo")
//        do {
//            let resultArray = try CoreDataStack.defaultStack.managedObjectContext.fetch(fetchRequest)
//            self.echoArray = (resultArray as NSArray) as! [NSManagedObject]
//        } catch {
//            return
//        }
        
        refreshEchoArray()
        
        title = "\(echoArray.count) Echos"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshEchoArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return echoArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "echoItem", for: indexPath)
        
        // Configure the cell...
        let echo = echoArray[indexPath.row] as! Echo
        cell.textLabel?.text = echo.text
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return
//            }
//            let managedContext = appDelegate.persistentContainer.viewContext
//            let echo = echoArray[indexPath.row]
//            managedContext.delete(echo)
//            do {
//                try managedContext.save()
//            } catch let error as NSError {
//                print("Could not save. \(error), \(error.userInfo)")
//            }
            
            CoreDataStack.defaultStack.syncWithCompletion(nil)
            let echo = echoArray[indexPath.row]
            do {
                CoreDataStack.defaultStack.managedObjectContext.delete(echo)
                try CoreDataStack.defaultStack.managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            // Update our global variable
            echoArray.remove(at: indexPath.row)
            
            // Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Update title
            title = "\(echoArray.count) Echos"
            
        } //else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //}
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
