//
//  ReviewTableViewController.swift
//  Review
//
//  Created by Naizaa Inwonderland on 9/12/2560 BE.
//  Copyright © 2560 Naizaa Inwonderland. All rights reserved.
//

import UIKit
import CoreData

class ReviewTableViewController: UITableViewController {
    
    var myReview : [Review] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Review"
        
    }
    override func viewWillAppear(_ animated: Bool) {

        // Add a background view to the table view
        let backgroundImage = UIImage(named: "Paper.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        // center and scale background image
        imageView.contentMode = .scaleAspectFit
        
        // no lines where there aren't cells
        tableView.tableFooterView = UIView()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
        
        //เคลียร์ Array ก่อนจะแสดงผล
        myReview.removeAll()
        
        //สร้าง Object ของ AppDelegate เพื่อเรียกใช้ persistentContainer
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        //สร้างตัวเรียกข้อมูลขึ้นมาจากฐานข้อมูล
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReviewTB")
        myFetchRequest.returnsObjectsAsFaults = false
        
        do{
            let myFetchResults = try myContext.fetch(myFetchRequest)
            if myFetchResults.count > 0 {
                for myResult in myFetchResults as! [NSManagedObject] {
                    let myReviewName = myResult.value(forKey: "reviewName") as! String
                    let myReviewComment = myResult.value(forKey: "reviewComment") as! String
                    let myReviewScore = myResult.value(forKey: "reviewScore") as! Int
                    let myReviewImage = UIImage(data:  myResult.value(forKey: "reviewImage") as! Data)!
                    let myReviewInfo = Review(ReviewName : myReviewName, ReviewScore : myReviewScore, ReviewComment: myReviewComment, ReviewImage : myReviewImage)
                    myReview.append(myReviewInfo)
                    
                }
            }
        }catch let error as NSError{
            print(error.description)
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReview.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReviewTableViewCell
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)

        // Configure the cell...
        cell.lblName.text = myReview[indexPath.row].ReviewName
        cell.lblComment.text = myReview[indexPath.row].ReviewComment
        cell.lblScore.text = "\(myReview[indexPath.row].ReviewScore)"
        cell.myImage.image = myReview[indexPath.row].ReviewImage
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //สร้าง Object ของ AppDelegate เพื่อเรียกใช้ persistentContainer
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        
        if editingStyle == .delete {
            //ลบข้อมูลในฐานข้อมูล
            //เรียกข้อมูลที่จะลบขึ้นมาจากฐานข้อมูล
            let myFetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "ReviewTB")
            myFetchRequest.returnsObjectsAsFaults = false
            
             //กําหนดเงื่อนไขการดึงข้อมูล
            let myPredicate = NSPredicate(format: "reviewName == %@", myReview[indexPath.row].ReviewName)
             myFetchRequest.predicate = myPredicate
            
            do{
                 let myFetchResults = try myContext.fetch(myFetchRequest)
                 if myFetchResults.count > 0 {
                    let myResult = myFetchResults.first as! NSManagedObject
                    //ลบข้อมูลออกจากฐานข้อมูล
                    myContext.delete(myResult)
                }
            }catch let error as NSError {
                print(error.description)
            }
            
            //ลบออกจาก Data Source Array
            myReview.remove(at: indexPath.row)
            
            
            //ลบออกจาก Tableview
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            //บันทึกการลบข้อมูลออกจากฐานข้อมูล
            do {
                try myContext.save()
            }catch let error as NSError{
                print(error.description)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let myReviewVC = segue.destination as! ReviewViewController
                myReviewVC.theReview = myReview[indexPath.row]
        }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation


}
