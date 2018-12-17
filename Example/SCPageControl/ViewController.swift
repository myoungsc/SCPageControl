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
    @IBOutlet weak var SCP_SCJAMoveCircle: SCPageControlView!
    @IBOutlet weak var SCP_SCJAFillCircle: SCPageControlView!
    @IBOutlet weak var SCP_SCJAFlatBar: SCPageControlView!
    
    var screenWidth : CGFloat = UIScreen.main.bounds.size.width
    var screenHeight : CGFloat = UIScreen.main.bounds.size.height
    
    let arrImg: [UIImage] = [UIImage(named: "sc0.jpg")!,
                             UIImage(named: "sc1.jpg")!,
                             UIImage(named: "sc2.jpg")!,
                             UIImage(named: "sc3.jpg")!,
                             UIImage(named: "sc4.jpg")!]
    
    let arr_color: [UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.purple, UIColor.brown]
    var previousDeviceOrientation: UIDeviceOrientation = UIDevice.current.orientation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:  #selector(deviceDidRotate),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )        
        init_view()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //if you use autolayout, initial SCPageControll in ViewDidLayoutSubviews Method
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /*
         ScPageControl.frame = ScPageControl.frame
         ScPageControl.scp_style = .SCNormal
         ScPageControl.set_view(Int(sc_main.contentSize.width/screenWidth), current: 0, tint_color: .red)
         */
    }
    
    //MARK: ## view init ##
    func init_view() {
        
        sc_main.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        sc_main.delegate = self
        sc_main.isPagingEnabled = true
        sc_main.contentSize = CGSize(width: screenWidth*5.0, height: screenHeight)
        //sc_main.contentOffset = CGPoint(x: sc_main.frame.size.width, y: 0) //<- Only Start Page Not first Page
        
        for i in 0 ..< Int(sc_main.contentSize.width/screenWidth) {
            
            let ivImage = UIImageView(frame: CGRect(x: screenWidth*CGFloat(i), y: 0, width: screenWidth, height: screenHeight-200))
            ivImage.image = arrImg[i]
            ivImage.contentMode = .scaleAspectFill
            ivImage.clipsToBounds = true
            sc_main.addSubview(ivImage)
            
            let lb_title = UILabel(frame: CGRect(x: screenWidth*CGFloat(i), y: 100, width: screenWidth, height: 100))
            lb_title.text = "\(i+1) Page"
            lb_title.textAlignment = .center
            lb_title.textColor = arr_color[i]
            lb_title.font = UIFont.boldSystemFont(ofSize: 30.0)
            sc_main.addSubview(lb_title)
        }
                
        /**
        ## SCPageControlView Setting Value ##
         - set_view Function
         - First parameter is Page Count
         - Seconde Parameter is Start Page
         - Third Parameter is PageControl tint_Color
        */
        //## Style SCNormal ##
        ScPageControl.frame = CGRect(x: 0, y: screenHeight-50, width: screenWidth, height: 50)
        ScPageControl.scp_style = .SCNormal
        ScPageControl.set_view(Int(sc_main.contentSize.width/screenWidth), current: 0, current_color: .red)
        
        //## Style SCJAMoveCircle ##
        SCP_SCJAMoveCircle.frame = CGRect(x: 0, y: screenHeight-100, width: screenWidth, height: 50)
        SCP_SCJAMoveCircle.scp_style = .SCJAMoveCircle
//        SCP_SCJAMoveCircle.isCircle = false //Not use circle
        SCP_SCJAMoveCircle.set_view(Int(sc_main.contentSize.width/screenWidth), current: 0, current_color: .orange)
        
        //## Style SCJAFillCircle ##
        SCP_SCJAFillCircle.frame = CGRect(x: 0, y: screenHeight-150, width: screenWidth, height: 50)
        SCP_SCJAFillCircle.scp_style = .SCJAFillCircle
        SCP_SCJAFillCircle.set_view(Int(sc_main.contentSize.width/screenWidth), current: 0, current_color: .green)
        
        //## Style SCJAFlatBar ##
        SCP_SCJAFlatBar.frame = CGRect(x: 0, y: screenHeight-200, width: screenWidth, height: 50)
        SCP_SCJAFlatBar.scp_style = .SCJAFlatBar
        SCP_SCJAFlatBar.set_view(Int(sc_main.contentSize.width/screenWidth), current: 0, current_color: .blue)
    }
    
    //MARK: ## ScrollView Delegate ##
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Added as required
        ScPageControl.scroll_did(scrollView)
        SCP_SCJAMoveCircle.scroll_did(scrollView)
        SCP_SCJAFillCircle.scroll_did(scrollView)
        SCP_SCJAFlatBar.scroll_did(scrollView)
    }
    
    // ## Moment in rotate Device ##
    // Only when not use AutoLayout
    @objc func deviceDidRotate() {
        
        if UIDevice.current.orientation == previousDeviceOrientation { return }
        previousDeviceOrientation = UIDevice.current.orientation
        
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        var f_x: CGFloat = 0.0
        for subview in sc_main.subviews {
            if subview.isKind(of: UILabel.classForCoder()) {
                subview.frame = CGRect(x: f_x, y: 100, width: screenWidth, height: 100)
                f_x += screenWidth
            }
        }        
        let f_page = sc_main.contentOffset.x / sc_main.frame.size.width
        
        sc_main.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        sc_main.contentSize = CGSize(width: screenWidth*5.0, height: screenHeight)
        
        ScPageControl.frame = CGRect(x: 0, y: screenHeight-50, width: screenWidth, height: 50)
        ScPageControl.set_rotateDevice()
        
        SCP_SCJAMoveCircle.frame = CGRect(x: 0, y: screenHeight-100, width: screenWidth, height: 50)
        SCP_SCJAMoveCircle.set_rotateDevice()
        
        SCP_SCJAFillCircle.frame = CGRect(x: 0, y: screenHeight-150, width: screenWidth, height: 50)
        SCP_SCJAFillCircle.set_rotateDevice()
        
        SCP_SCJAFlatBar.frame = CGRect(x: 0, y: screenHeight-200, width: screenWidth, height: 50)
        SCP_SCJAFlatBar.set_rotateDevice()
        
        sc_main.scrollRectToVisible(CGRect(x: sc_main.frame.size.width*f_page, y: 0, width:  sc_main.frame.size.width, height:  sc_main.frame.size.height), animated: true)        
    }
  
}
