//
//  Review.swift
//  Review
//
//  Created by Naizaa Inwonderland on 9/12/2560 BE.
//  Copyright © 2560 Naizaa Inwonderland. All rights reserved.
//

import UIKit

class Review: NSObject {
    
    var ReviewName : String
    var ReviewScore : Int
    var ReviewComment : String
    var ReviewImage : UIImage
    
    override init(){
        self.ReviewName = ""
        self.ReviewComment = ""
        self.ReviewScore = 0
        self.ReviewImage = UIImage()
    }
    
    init(ReviewName : String, ReviewScore : Int, ReviewComment : String, ReviewImage : UIImage){
        self.ReviewName = ReviewName
        self.ReviewScore = ReviewScore
        self.ReviewComment = ReviewComment
        self.ReviewImage = ReviewImage
    }
}

