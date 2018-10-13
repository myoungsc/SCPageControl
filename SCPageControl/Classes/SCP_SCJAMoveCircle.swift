//
//  SCP_SCJAMoveCircle.swift
//  Pods
//
//  Created by Myoung on 2017. 4. 30..
//
//

import UIKit

class SCP_SCJAMoveCircle: UIView {

    let view_img = UIView()
    let img_focus = UIImageView()
    
    let circle_size: CGFloat = 17
    
    var numberOfPage: Int = 0, currentOfPage: Int = 0
    var f_start_point: CGFloat = 0.0, f_start: CGFloat = 0.0
    var isCircle: Bool = true
    
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
    func set_view(_ page: Int, current: Int, current_color: UIColor, disable_color: UIColor?, isCircleOption: Bool) {
        
        numberOfPage = page
        currentOfPage = current
        isCircle = isCircleOption
        
        let f_all_width: CGFloat = CGFloat(numberOfPage*20)
        
        guard f_all_width < self.frame.size.width else {
            print("frame.Width over Number Of Page")
            return
        }
        
        if isCircle {
            img_focus.frame = CGRect(x: 0, y: 0, width: circle_size, height: circle_size)
            img_focus.center = self.center
            img_focus.layer.cornerRadius = img_focus.frame.size.height/2.0
            img_focus.layer.borderColor = current_color.cgColor
            img_focus.layer.borderWidth = 1.0
            img_focus.backgroundColor = .clear
            self.addSubview(img_focus)
        }
        
        let f_width: CGFloat = 10.0, f_height: CGFloat = 10.0
        var f_x: CGFloat = (self.center.x-(f_width/2.0)), f_y: CGFloat = (self.frame.size.height-f_height)/2.0
        
        f_start_point = f_x
        
        view_img.frame = CGRect(x: -(CGFloat(current) * 20),
                                y: 0,
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        view_img.backgroundColor = .clear
        self.addSubview(view_img)
        
        for i in 0 ..< numberOfPage {
            let img_page = UIImageView()
            
            if i == currentOfPage {
                img_page.alpha = 1.0
            } else {
                img_page.alpha = 0.4
            }
            img_page.frame = CGRect(x: f_x, y: f_y, width: f_width, height: f_height)
            img_page.layer.cornerRadius = img_page.frame.size.height/2.0
            img_page.backgroundColor = current_color
            img_page.tag = i+10
            view_img.addSubview(img_page)
            
            f_x += f_width + 10
        }
    }
    
    // ## Call the move page in scrollView ##
    func scroll_did(_ scrollView: UIScrollView) {
        
        let f_page = scrollView.contentOffset.x / scrollView.frame.size.width
        
        let tag_value = get_imgView_tag(f_page)+10
        let f_next_start: CGFloat = (CGFloat(tag_value-10) * scrollView.frame.size.width)
        
        let f_move: CGFloat = (20*(f_start-scrollView.contentOffset.x)/scrollView.frame.size.width)
        let f_alpha: CGFloat = (0.6*(scrollView.contentOffset.x-f_next_start)/scrollView.frame.size.width)
        
        if let iv_page: UIImageView = view_img.viewWithTag(tag_value) as? UIImageView,
            tag_value >= 10 && tag_value+1 < numberOfPage+10 {
            
            view_img.frame.origin.x = 0 + f_move
            iv_page.alpha = 1-f_alpha
            
            if let iv_page_next: UIImageView = self.viewWithTag(tag_value+1) as? UIImageView {
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
        let f_width: CGFloat = 10.0
        var f_x: CGFloat = self.center.x - (f_width/2.0)
        
        f_start_point = f_x
        img_focus.center = self.center
        
        for subview in view_img.subviews {
            if subview.isKind(of: UIImageView.classForCoder()) {
                subview.frame.origin.x = f_x
                f_x += subview.frame.size.width + 10
            }
        }
    }
}
