//
//  SCP_SCFillCircle.swift
//  Pods
//
//  Created by Myoung on 2017. 5. 1..
//
//

import UIKit

class SCP_SCJAFillCircle: UIView {
    
    var numberOfPage: Int = 0, currentOfPage: Int = 0
    var f_start_point: CGFloat = 0.0, f_start: CGFloat = 0.0
    var f_circle: CGFloat = 0.0
    
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
        
        f_circle = 10.0
        var f_x: CGFloat = ((self.frame.size.width-f_all_width)/2.0) + 5, f_y: CGFloat = (self.frame.size.height-f_circle)/2.0
        
        f_start_point = f_x
        
        for i in 0 ..< numberOfPage {
            let img_page = UIImageView()
            img_page.layer.borderColor = current_color.cgColor
            img_page.frame = CGRect(x: f_x, y: f_y, width: f_circle, height: f_circle)
            img_page.layer.cornerRadius = img_page.frame.size.height/2.0
            img_page.tag = i+10
            self.addSubview(img_page)
            
            if i == currentOfPage {
                img_page.layer.borderWidth = f_circle/2.0
            } else {
                img_page.layer.borderWidth = 1.0
            }
            
            f_x += f_circle + 10
        }
    }
    
    // ## Call the move page in scrollView ##
    func scroll_did(_ scrollView: UIScrollView) {
        
        let f_page = scrollView.contentOffset.x / scrollView.frame.size.width
        
        let tag_value = get_imgView_tag(f_page)+10
        let f_next_start: CGFloat = (CGFloat(tag_value-10) * scrollView.frame.size.width)
        let f_border_width = (f_circle/2.0)-1.0
        let f_border: CGFloat = (f_border_width*(scrollView.contentOffset.x-f_next_start)/scrollView.frame.size.width)
        
        if let iv_page: UIImageView = self.viewWithTag(tag_value) as? UIImageView,
            tag_value >= 10 && tag_value+1 < numberOfPage+10 {
            iv_page.layer.borderWidth = (f_circle/2.0)-f_border
            
            if let iv_page_next: UIImageView = self.viewWithTag(tag_value+1) as? UIImageView {
                iv_page_next.layer.borderWidth = 1+f_border
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
        
        let f_width: CGFloat = CGFloat(numberOfPage*20)
        var f_x: CGFloat = (self.frame.size.width-f_width)/2.0 + 5
        
        f_start_point = f_x
        
        for subview in self.subviews {
            if subview.isKind(of: UIImageView.classForCoder()) {
                subview.frame.origin.x = f_x
                f_x += subview.frame.size.width + 10
            }
        }
    }
}
