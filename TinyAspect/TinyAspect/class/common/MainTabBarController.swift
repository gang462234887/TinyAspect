//
//  MainTabBarController.swift
//  TinyAspect
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //tabbar的背景视图
    var bgView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //影藏系统的TabBar
        self.tabBar.hidden = true
        
        self.createViewControllers()
    }
    
    //创建视图控制器
    func createViewControllers(){
        let ctrlNames = ["HomePageViewController","DiscoverViewController","SubscribeViewController","MyViewController"]
        
        let imageNames = ["tabbar_icon0","tabbar_icon1","tabbar_icon2","tabbar_icon3"]
        
        let selectImageNames = ["tabbar_highlight_icon0","tabbar_highlight_icon1","tabbar_highlight_icon2","tabbar_highlight_icon3"]
        
        let titleNames = ["首页","发现","订阅","我的"]
        
        var array = Array<UINavigationController>()
        for i in 0..<imageNames.count{
            let ctrlName = "TinyAspect." + ctrlNames[i]
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let vCtrl = cls.init()
            
            let navCtrl = UINavigationController(rootViewController: vCtrl)
            array.append(navCtrl)
        }
        self.viewControllers = array
        
        self.createCoutomTabBar(imageNames, selectImageNames: selectImageNames, titleNames: titleNames)
    }
    
    //自定制tabbar
    func createCoutomTabBar(imageNames:[String],selectImageNames:[String],titleNames:[String]){
        self.bgView = UIView.createView()
        self.bgView?.backgroundColor = UIColor.whiteColor()
        self.bgView?.layer.borderWidth = 1
        self.bgView?.layer.borderColor = UIColor.grayColor().CGColor
        self.view.addSubview(self.bgView!)
        
        self.bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo((self?.view)!)
            make.top.equalTo((self?.view.snp_bottom)!).offset(-49)
        })
        
        let width = KScreenWidth/4.0
        
        for i in 0..<imageNames.count{
            let btn = UIButton.createBtn(nil, bgImageNmae: imageNames[i], selectImageName: selectImageNames[i], target: self, action: #selector(clickBtn(_:)))
            btn.tag = 300+i
            self.bgView!.addSubview(btn)
            
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.top.bottom.equalTo((self?.bgView)!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
            })
            
            let label = UILabel.createLabel(titleNames[i], font: UIFont.systemFontOfSize(10), textAlignment: .Center, textColor: UIColor.grayColor())
            label.tag = 400
            btn.addSubview(label)
            
            label.snp_makeConstraints(closure: {
                (make) in
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(12)
            })
            
            if i==0{
                btn.selected = true
                label.textColor = UIColor(red: 69/255.0, green: 191/255.0, blue: 24/255.0, alpha: 1.0)
            }
        }
    }
    
    
    //tabbar的点击事件
    func clickBtn(btn:UIButton){
        let lastView = self.bgView?.viewWithTag(300+selectedIndex)
        if let lastBtnView = lastView{
            let lastBtn = lastBtnView as! UIButton
            lastBtn.selected = false
            
            let lastLabelView = lastBtnView.viewWithTag(400)
            if let labelView = lastLabelView{
                let label = labelView as! UILabel
                label.textColor = UIColor.grayColor()
            }
        }
        
        let curLabelView = btn.viewWithTag(400)
        if let curLabel = curLabelView{
            let label = curLabel as! UILabel
            label.textColor = UIColor(red: 69/255.0, green: 191/255.0, blue: 24/255.0, alpha: 1.0)
            btn.selected = true
        }
        
        selectedIndex = btn.tag - 300
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
