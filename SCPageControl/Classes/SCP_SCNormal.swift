//
//  SCPageControl_normal.swift
//  Pods
//
//  Created by Myoung on 2017. 4. 27..
//
//

import UIKit

class SCP_SCNormal: UIView {

    var numberOfPage: Int = 0, currentOfPage: Int = 0
    var f_start_point: CGFloat = 0.0, f_start: CGFloat = 0.0
    
    var screenWidth : CGFloat = UIScreen.main.bounds.size.width
    var screenHeight : CGFloat = UIScreen.main.bounds.size.height
    
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
    func set_view(_ page: Int, current: Int, current_color: UIColor) {
        
        numberOfPage = page
        currentOfPage = current
        
        let f_all_width: CGFloat = CGFloat((numberOfPage-1)*20 + 25)
        
        guard f_all_width < self.frame.size.width else {
            print("frame.Width over Number Of Page")
            return
        }
        
        var f_width: CGFloat = 10.0, f_height: CGFloat = 10.0
        var f_x: CGFloat = (self.frame.size.width-f_all_width)/2.0, f_y: CGFloat = (self.frame.size.height-f_height)/2.0
        
        f_start_point = f_x
        
        for i in 0 ..< numberOfPage {
            let img_page = UIImageView()
            
            if i == currentOfPage {
                f_width = 25.0
                img_page.alpha = 1.0
            } else {
                f_width = 10.0
                img_page.alpha = 0.4
            }            
            
            img_page.frame = CGRect(x: f_x, y: f_y, width: f_width, height: f_height)
            img_page.layer.cornerRadius = img_page.frame.size.height/2.0
            img_page.backgroundColor = current_color
            img_page.tag = i+10
            self.addSubview(img_page)
            
            f_x += f_width + 10
        }        
    }
    
    // ## Call the move page in scrollView ##
    func scroll_did(_ scrollView: UIScrollView) {
     
        let f_page = scrollView.contentOffset.x / scrollView.frame.size.width
        
        let tag_value = get_imgView_tag(f_page)+10
        let f_next_start: CGFloat = (CGFloat(tag_value-10) * scrollView.frame.size.width)
        
        let f_move: CGFloat = (15*(f_start-scrollView.contentOffset.x)/scrollView.frame.size.width)
        let f_alpha: CGFloat = (0.6*(scrollView.contentOffset.x-f_next_start)/scrollView.frame.size.width)
                        
        if let iv_page: UIImageView = self.viewWithTag(tag_value) as? UIImageView,
            tag_value >= 10 && tag_value+1 < 10+numberOfPage {
            
            iv_page.frame = CGRect(x: f_start_point+((CGFloat(tag_value)-10)*20),
                                   y: iv_page.frame.origin.y,
                                   width: 25+(f_move+((CGFloat(tag_value)-10)*15)),
                                   height: iv_page.frame.size.height)
            iv_page.alpha = 1-f_alpha
            
            if let iv_page_next: UIImageView = self.viewWithTag(tag_value+1) as? UIImageView {
                let f_page_next_x: CGFloat = ((f_start_point+35)+((CGFloat(tag_value)-10)*20))
                iv_page_next.frame = CGRect(x: f_page_next_x+(f_move+((CGFloat(tag_value)-10)*15)),
                                            y: iv_page_next.frame.origin.y,
                                            width: 10-(f_move+((CGFloat(tag_value)-10)*15)),
                                            height: iv_page_next.frame.size.height)
                iv_page_next.alpha = 0.4+f_alpha
            }
        }
    }
    
    // ## return ImageView tag number ##
    func get_imgView_tag(_ f_page: CGFloat) -> Int {
        let f_temp = f_page - 0.02
        return Int(f_temp)
    }
    
    // ## Call the moment in rotate Device ##
    func set_rotateDevice(_ frame: CGRect) {
        self.frame = frame
        let f_all_width: CGFloat = CGFloat((numberOfPage-1)*20 + 25)
        var f_x: CGFloat = (self.frame.size.width-f_all_width)/2.0
        
        f_start_point = f_x
        
        for subview in self.subviews {
            if subview.isKind(of: UIImageView.classForCoder()) {
                subview.frame.origin.x = f_x
                f_x += subview.frame.size.width + 10
            }
        }
    }
}
