//
//  ViewController.swift
//  SCPageControl
//
//  Created by myoung on 04/17/2017.
//  Copyright (c) 2017 myoung. All rights reserved.
//

import UIKit
import SCPageControl

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var sc_main: UIScrollView!
    @IBOutlet weak var ScPageControl: SCPageControlView!
        
    let screenWidth : CGFloat = UIScreen.main.bounds.size.width
    let screenHeight : CGFloat = UIScreen.main.bounds.size.height
    
    let arr_color: [UIColor] = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.purple, UIColor.brown]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sc_main.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        sc_main.delegate = self
        sc_main.isPagingEnabled = true
        sc_main.contentSize = CGSize(width: screenWidth*5.0, height: screenHeight)
        //sc_main.contentOffset = CGPoint(x: sc_main.frame.size.width, y: 0); //<-Only Start Page Not first Page
        
        for i in 0 ..< Int(sc_main.contentSize.width/screenWidth) {
            let lb_title = UILabel(frame: CGRect(x: screenWidth*CGFloat(i), y: 0, width: screenWidth, height: screenHeight))
            lb_title.text = "\(i) Page"
            lb_title.textAlignment = .center
            lb_title.textColor = arr_color[i]
            lb_title.font = UIFont.boldSystemFont(ofSize: 30.0)
            sc_main.addSubview(lb_title)
        }
        
        
        //SCPageControlView Setting Value
        
        //set_view Function
        //First parameter is Page Count
        //Seconde Parameter is Start Page
        //Third Parameter is PageControl tint_Color
        ScPageControl.frame = CGRect(x: 0, y: screenHeight-50, width: screenWidth, height: 50)
        ScPageControl.set_view(5, current: 0, tint_color: UIColor.red)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: ***** ScrollView Delegate *****
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Added as required
        ScPageControl.scroll_did(scrollView)
    }

}

