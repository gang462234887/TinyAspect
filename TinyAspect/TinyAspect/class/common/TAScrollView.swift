//
//  TAScrollView.swift
//  TinyAspect
//
//  Created by qianfeng on 16/8/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class TAScrollView: UIView {

    
   
    init(frame: CGRect,titleNames:[String]) {
        super.init(frame: frame)
        
        let scrollView = UIScrollView()
        self.addSubview(scrollView)
        scrollView.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
            })
        
        let hrView = UIView.createView()
        hrView.backgroundColor = UIColor.grayColor()
        self.addSubview(hrView)
        
        hrView.snp_makeConstraints { (make) in
            make.bottom.equalTo(scrollView)
            make.top.equalTo(scrollView.snp_bottom).offset(-1)
            make.width.equalTo(KScreenWidth)
            make.left.equalTo(scrollView)
        }
        
        let containerView = UIView.createView()
        scrollView.addSubview(containerView)
        scrollView.showsHorizontalScrollIndicator = false
        containerView.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
        })
        
        var lastView: UIView? = nil
        for i in 0..<titleNames.count{
            
            let w = NSString(string: titleNames[i]).boundingRectWithSize(CGSizeMake(CGFloat.max, 255), options: .TruncatesLastVisibleLine, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15)], context: nil).size.width
            
            let btn = TACategoryBtn(labelW: w)
            
            btn.configTitle(titleNames[i])

            containerView.addSubview(btn)
            
            btn.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(containerView)
                make.width.equalTo(w)
                if i == 0 {
                    make.left.equalTo(containerView).offset(20)
                }else{
                    make.left.equalTo((lastView?.snp_right)!).offset(20)
                }
            })
            
            lastView = btn

        }
        
        //修改容器视图约束
        containerView.snp_makeConstraints(closure: {
            (make) in
            make.right.equalTo((lastView?.snp_right)!).offset(20)
        })
        
        
    }
    
    func clickBtn(btn:TACategoryBtn){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class TACategoryBtn:UIControl{
    private var label:UILabel?
    
    init(labelW:CGFloat) {
        super.init(frame: CGRectZero)
        
        //按钮上面的文字
        self.label = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(15), textAlignment: .Center, textColor: UIColor.grayColor())
        self.label?.frame = CGRectMake(0, 0, labelW, 40)
        
        self.addSubview(self.label!)
    }
    
    //显示文字
    func configTitle(title:String){
        self.label?.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}













