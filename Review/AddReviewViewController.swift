//
//  AddReviewViewController.swift
//  Review
//
//  Created by Naizaa Inwonderland on 9/12/2560 BE.
//  Copyright © 2560 Naizaa Inwonderland. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class AddReviewViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var myImageController : UIImagePickerController?
    var isNewImage = false
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func selectImgMethod(_ sender: Any) {
        myImageController = UIImagePickerController()
        if let theController = myImageController{
            theController.sourceType = .savedPhotosAlbum
            theController.mediaTypes = [String(kUTTypeImage)]
            theController.allowsEditing = true
            theController.delegate = self
            present(theController, animated: true, completion: nil)

        }
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        //ปิด album controller
        picker.dismiss(animated: true, completion: nil)
        
        //นํารูปที่เลือกไปแสดงใน ImageView
        let theImage = info[UIImagePickerControllerEditedImage] as! UIImage
        imgView.image = theImage
    }
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtScore: UITextField!
    
    @IBAction func seveMethod(_ sender: Any) {
        //สร้าง Object ของ AppDelegate เพื่อเรียกใช้ persistentContainer
        let myAppDelegate = UIApplication.shared.delegate as!  AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        //สร้าง Object ข้อมูล ReviewTB
        let newReview = NSEntityDescription.insertNewObject(forEntityName: "ReviewTB", into: myContext)
        newReview.setValue(txtName.text!, forKey: "reviewName")
        newReview.setValue(txtComment.text!, forKey: "reviewComment")
        newReview.setValue(Int(txtScore.text!)!, forKey:  "reviewScore")
        let theImageData = UIImagePNGRepresentation(imgView.image!)! as NSData
         newReview.setValue(theImageData, forKey: "reviewImage")
        
        //บันทึกลงฐานข้อมูล
        do{
            try myContext.save()
            print("บันทึกข้อมูลแล้ว!")
        }catch{
            print("ไม่สามารถบันทึกข้อมูลได้")
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func cancelMethod(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var txtComment: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        
    }
    
    func assignbackground(){
        
        let background = UIImage(named: "Paper.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    func adjustingHeight(_ show:Bool, notification:NSNotification) {
        var userInfo = notification.userInfo!
        //อ่านขนาดของ Virtual Keyboard
        let keyboardFrame:CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as!NSValue).cgRectValue.size
        //ปรับตําแหน่งของปุ่ม Sign In
        if show {
            bottomConstraint.constant += keyboardFrame.height
        }
        else{
            bottomConstraint.constant -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        adjustingHeight(true, notification: notification)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        adjustingHeight(false, notification: notification)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:
            NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
