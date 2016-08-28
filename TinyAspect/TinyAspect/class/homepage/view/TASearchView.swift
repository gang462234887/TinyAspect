//
//  TASearchView.swift
//  TinyAspect
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class TASearchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel.createLabel("微看点", font: UIFont.systemFontOfSize(20), textAlignment: .Center, textColor: UIColor(white: 0.8, alpha: 1.0))
        //计算文字的宽度来自适应屏幕
        let w = NSString(string: label.text!).boundingRectWithSize(CGSizeMake(CGFloat.max, 255), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(20)], context: nil).size.width
        label.frame = CGRectMake(10,0,w,44)
        addSubview(label)

        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor(red: 18/255.0, green: 18/255.0, blue: 18/255.0, alpha: 1.0)
        self.addSubview(searchBar)
        
        searchBar.snp_makeConstraints { (make) in
            make.right.equalTo(self)
            make.height.equalTo(44)
            make.top.equalTo(self)
            make.left.equalTo(label.snp_right).offset(10)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
