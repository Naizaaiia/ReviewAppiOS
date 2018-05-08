//
//  ViewController.swift
//  Review
//
//  Created by Naizaa Inwonderland on 9/12/2560 BE.
//  Copyright © 2560 Naizaa Inwonderland. All rights reserved.
//

import UIKit
import CoreData
import Social

class ReviewViewController: UIViewController {
    
    var theReview : Review = Review()
    
    @IBOutlet weak var imgWall: UIImageView!
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBAction func shearMethod(_ sender: Any) {
        
        let activityItems = [imgWall.image!]
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityController.excludedActivityTypes = [UIActivityType.mail, UIActivityType.copyToPasteboard]
        self.present(activityController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
 
        if let image = createFinalImageText() {
            imgWall.image = image
        }
        
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

    
    func createFinalImageText () -> UIImage? {
        
        let image = UIImage(named: "Wall1.jpg")
        
        let viewToRender = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
        
        // here you can set the actual image width : image.size.with ?? 0 / height : image.size.height ?? 0
        let imgView = UIImageView(frame: viewToRender.frame)
        
        imgView.image = image
        
        viewToRender.addSubview(imgView)
        
        //ส่วนชื่อ
        let textNameImgView = UIImageView(frame: viewToRender.frame)
        textNameImgView.image = imageFromName(text: "\(theReview.ReviewName)", size: viewToRender.frame.size)
        viewToRender.addSubview(textNameImgView)
        
        
        //ส่วนคอมเมนท์
        let textCommentImgView = UIImageView(frame: viewToRender.frame)
        textCommentImgView.image = imageFromComment(text: "\(theReview.ReviewComment)", size: viewToRender.frame.size)
        viewToRender.addSubview(textCommentImgView)
        
        //ส่วนคะแนน
        let textScoreImgView = UIImageView(frame: viewToRender.frame)
        textScoreImgView.image = imageFromScore(text: "\(theReview.ReviewScore)", size: viewToRender.frame.size)
        viewToRender.addSubview(textScoreImgView)
        
        //ส่วนคะแนนเต็ม
        let textFullScoreImgView = UIImageView(frame: viewToRender.frame)
        textFullScoreImgView.image = imageFromFullScore(text: "10", size: viewToRender.frame.size)
        viewToRender.addSubview(textFullScoreImgView)
        
        //ส่วน Backsplash
        let textBacksplashImgView = UIImageView(frame: viewToRender.frame)
        textBacksplashImgView.image = imageFromBacksplash(text: "/", size: viewToRender.frame.size)
        viewToRender.addSubview(textBacksplashImgView)
        
        //ส่วนรูป
        let ImgViewImage = UIImageView(frame: viewToRender.frame)
        ImgViewImage.image = imageFromImg(image: (theReview.ReviewImage), size: viewToRender.frame.size)
        viewToRender.addSubview(ImgViewImage)
        
        UIGraphicsBeginImageContextWithOptions(viewToRender.frame.size, false, 0)
        viewToRender.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage
    }
    
    func imageFromImg( image : UIImage , size:CGSize) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            image.draw(in: CGRect(x: size.width/1.8, y: size.height/3.3, width: size.width/2.5, height: size.height/2.5))
            
        }
        return img
    }
    
    
    func imageFromName(text: String , size:CGSize) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs = [NSAttributedStringKey.font: UIFont(name: "SanamDeklenchaya", size: 25)!, NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.paragraphStyle: paragraphStyle]
            
            text.draw(with: CGRect(x: 0, y: size.height/15, width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            
        }
        return img
    }
    
    func imageFromComment(text: String , size:CGSize) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs = [NSAttributedStringKey.font: UIFont(name: "SanamDeklenchaya", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.paragraphStyle: paragraphStyle]
            
            text.draw(with: CGRect(x: 0, y: size.height/1.25, width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            
        }
        return img
    }
    
    func imageFromScore(text: String , size:CGSize) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attrs = [NSAttributedStringKey.font: UIFont(name: "SanamDeklenchaya", size: 35)!, NSAttributedStringKey.foregroundColor: UIColor.yellow, NSAttributedStringKey.paragraphStyle: paragraphStyle]
            
            text.draw(with: CGRect(x: size.width/9, y: size.height/2.3, width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            
        }
        return img
    }
    
    func imageFromFullScore(text: String , size:CGSize) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attrs = [NSAttributedStringKey.font: UIFont(name: "SanamDeklenchaya", size: 35)!, NSAttributedStringKey.foregroundColor: UIColor.yellow, NSAttributedStringKey.paragraphStyle: paragraphStyle]
            
            text.draw(with: CGRect(x: size.width/3.4, y: size.height/2.3, width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            
        }
        return img
    }
    
    func imageFromBacksplash(text: String , size:CGSize) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attrs = [NSAttributedStringKey.font: UIFont(name: "SanamDeklenchaya", size: 35)!, NSAttributedStringKey.foregroundColor: UIColor.yellow, NSAttributedStringKey.paragraphStyle: paragraphStyle]
            
            text.draw(with: CGRect(x: size.width/4.5, y: size.height/2.3, width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            
        }
        return img
    }
    
}

