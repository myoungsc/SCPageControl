//
//  SCP_SCFlatBar.swift
//  Pods
//
//  Created by Myoung on 2017. 5. 2..
//
//

import UIKit

class SCP_SCJAFlatBar: UIView {

    var numberOfPage: Int = 0, currentOfPage: Int = 0
    var f_start_point: CGFloat = 0.0, f_last_x: CGFloat = 0.0
    
    let img_move = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // ## view init method ##
    func set_view(_ page: Int, current: Int, current_color: UIColor, disable_color: UIColor?) {
        
        numberOfPage = page
        currentOfPage = current
        
        let f_all_width: CGFloat = CGFloat(numberOfPage*20)
        
        guard f_all_width < self.frame.size.width else {
            print("frame.Width over Number Of Page")
            return
        }
        
        let f_width: CGFloat = 15.0, f_height: CGFloat = 3.0
        var f_x: CGFloat = ((self.frame.size.width-f_all_width)/2.0) - (f_width/2.0)
        var f_y: CGFloat = (self.frame.size.height-f_height)/2.0, f_move_x: CGFloat = 0.0
        
        f_start_point = f_x
        
        for i in 0 ..< numberOfPage {
            let img_page = UIImageView(frame: CGRect(x: f_x, y: f_y, width: f_width, height: f_height))
            img_page.backgroundColor = current_color
            img_page.alpha = 0.2
            img_page.layer.cornerRadius = img_page.frame.size.height/2.0
            img_page.tag = i+10
            self.addSubview(img_page)
            
            if i == current {
                f_move_x = img_page.frame.origin.x + 11
            }
            
            f_x += f_width + 5
        }
        
        f_last_x = f_move_x
       
        img_move.frame = CGRect(x: f_move_x, y: f_y, width: f_width, height: f_height)
        img_move.backgroundColor = current_color
        img_move.layer.cornerRadius = img_move.frame.size.height/2.0
        img_move.tag = 5
        self.addSubview(img_move)
    }
    
    // ## Call the move page in scrollView ##
    func scroll_did(_ scrollView: UIScrollView) {
        let f_move_x: CGFloat = (20*(scrollView.contentOffset.x/scrollView.frame.size.width))
        img_move.frame.origin.x = f_start_point + f_move_x
        f_last_x = img_move.frame.origin.x
    }
    
    // ## Call the moment in rotate Device ##
    func set_rotateDevice(_ frame: CGRect) {
        self.frame = frame
        
        let f_width: CGFloat = CGFloat(numberOfPage*20) - 7.5
        var f_x: CGFloat = (self.frame.size.width-f_width)/2.0
        
        f_start_point = f_x
        
        for subview in self.subviews {
            if subview.isKind(of: UIImageView.classForCoder()) {
                if subview.tag != 5 {
                    subview.frame.origin.x = f_x
                    f_x += subview.frame.size.width + 5
                }
            }
        }
        img_move.frame.origin.x = f_start_point
    }
    
}
