//
//  AboutViewController.swift
//  Review
//
//  Created by Naizaa Inwonderland on 13/12/2560 BE.
//  Copyright © 2560 Naizaa Inwonderland. All rights reserved.
//

import UIKit
import CoreData

class AboutViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var txtName: UILabel!
    
    @IBOutlet weak var txtNumber: UILabel!
    
    @IBOutlet weak var txtEngr: UILabel!
    
    @IBOutlet weak var txtUniver: UILabel!

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
