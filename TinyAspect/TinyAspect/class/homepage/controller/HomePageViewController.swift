//
//  HomePageViewController.swift
//  TinyAspect
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController {
    
    //导航下面的分类数据
    lazy var dataArray = NSMutableArray()
    
    var scrollView:UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.createSearchBarView()
        
        self.downloaderCategoryData()
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    func createScrollButton(array:NSMutableArray){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        var btnArray = Array<String>()
        
        for i in 0..<array.count+1{
            var btnName = String()
            if i == 0{
                btnName = "推荐"
            }else{
                let model = array[i-1] as! TACategoryModel
                btnName = model.name!
            }
            btnArray.append(btnName)
        }
        
        let bgView = TAScrollView(frame: CGRectMake(0, 64, KScreenWidth-30, 40), titleNames: btnArray)
        self.view.addSubview(bgView)
        
        
    }
    
    
    //这个是在当前视图控制器创建的滚动Button(效果一样)
    /*
    func createScrollViewBtn(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        scrollView = UIScrollView()
        scrollView?.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView!)
        
        //滚动视图约束
        scrollView?.snp_makeConstraints {
            [weak self]
            (make) in
            make.top.equalTo(self!.view).offset(64)
            make.left.equalTo(self!.view)
            make.right.equalTo(self!.view).offset(-30)
            make.height.equalTo(40)
        }
        
        let smallContainerView = UIView()
        smallContainerView.tag = 10
        scrollView?.addSubview(smallContainerView)

        //容器视图约束
        smallContainerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView!)
            make.height.equalTo(self!.scrollView!)
        }
        print(self.dataArray.count)
        var lastView: UIView? = nil
        for i in 0..<self.dataArray.count+1{
            var title = String()
            
            if i == 0{
                title = "推荐"
            }else{
                let model = self.dataArray[i-1] as! TACategoryModel
                title = model.name!
            }
            
            let btn = UIButton.createBtn(title, bgImageNmae: nil, selectImageName: nil, target: self, action: #selector(clickBtn(_:)))
            
            btn.titleLabel?.font = UIFont.systemFontOfSize(13)
            let w = NSString(string: title).boundingRectWithSize(CGSizeMake(CGFloat.max, 255), options: .TruncatesLastVisibleLine, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(13)], context: nil).size.width
            
            smallContainerView.addSubview(btn)
            
            btn.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(smallContainerView)
                make.width.equalTo(w)
                if i == 0 {
                    make.left.equalTo(smallContainerView).offset(20)
                }else{
                    make.left.equalTo((lastView?.snp_right)!).offset(20)
                }
            })
            
            lastView = btn
            
        }
        
        //修改容器视图约束
        smallContainerView.snp_makeConstraints(closure: {
            (make) in
            make.right.equalTo((lastView?.snp_right)!).offset(20)
        })
        
     
    }
     */
    
    func clickBtn(btn:UIButton){
        
    }
    
    //创建searchbar
    func createSearchBarView(){
        let searchView = TASearchView()
        searchView.frame = CGRectMake(0, 0, KScreenWidth, 44)
        self.navigationItem.titleView = searchView
        
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
    }
    
    //导航下面的分类
    func downloaderCategoryData(){
        
        let downloader = TADownloader()
        downloader.delegate = self
        
        downloader.type = .Category
        
        downloader.downloaderWithUrlString("http://www.weixinkd.com/v3/User/getinfo.json?access=WIFI&channel=c1010&app_version=3.3.1&version_code=331&device_platform=android&os_version=KVT49L%2Bdev-keys&os_api=19&device_model=vivo%2BX710L&request_time=1472273755&uuid=864855028286054&openudid=34703b1d82ddf181&phone_sim=1&carrier=CMCC&uid=13833334&sign=bc83ee7549e010ce63d09671d0febd19")
        
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

//MARK: 导航下面分类的下载

extension HomePageViewController:TADownloaderDelegate{
    
    func downloader(downloader: TADownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: TADownloader, didFinishWithData data: NSData?) {
        
        if downloader.type == .Category{
            if let tmpData = data{
                let jsonData = try! NSJSONSerialization.JSONObjectWithData(tmpData, options: .MutableContainers)
                if jsonData.isKindOfClass(NSDictionary.self){
                    let dict = jsonData as! Dictionary<String,AnyObject>
                    let array = dict["items"] as! Array<Dictionary<String,AnyObject>>
                    for tmpDict in array{
                        let model = TACategoryModel()
                        model.setValuesForKeysWithDictionary(tmpDict)
                        dataArray.addObject(model)
                    }
                    dispatch_async(dispatch_get_main_queue(), { 
                        //self.createScrollViewBtn()
                        self.createScrollButton(self.dataArray)
                    })
                }
            }
            
        }
    }
}






