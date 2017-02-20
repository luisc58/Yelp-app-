//
//  webViewControl.swift
//  Yelp
//
//  Created by luis castillo on 2/19/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD
class webViewControl: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var url : URL?
    let first = BusinessesViewController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let request = NSURLRequest(url: url!);
        webView.loadRequest(request as URLRequest);  
        
     //|*SWIPE GESTURE
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
        
    func respondToSwipeGesture(gesture: UISwipeGestureRecognizer) {
        print("Swiped right")
         let UISwipeGesture = gesture 
            switch UISwipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right: 
                //| CHANGE VIEWCONTROLLERS IF SWIPE GESTURE IS RIGHT
                let storyBoard =  self.storyboard?.instantiateViewController(withIdentifier: "main") as! BusinessesViewController
                self.present(storyBoard, animated: true, completion: nil)
                
            default:
                break
                
        }
    }
}
