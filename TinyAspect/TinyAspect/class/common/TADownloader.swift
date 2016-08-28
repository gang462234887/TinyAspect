//
//  TADownloader.swift
//  TinyAspect
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

public enum TADownloaderType:Int{
    
    case Category = 10   //导航下面的分类
    
}

protocol TADownloaderDelegate:NSObjectProtocol {
    
    func downloader(downloader:TADownloader,didFailWithError error:NSError)
    
    func downloader(downloader:TADownloader,didFinishWithData data:NSData?)
}

class TADownloader: NSObject {
    
    weak var delegate:TADownloaderDelegate?
    
    var type:TADownloaderType?
    
    func downloaderWithUrlString(urlString:String){
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if error != nil{
                self.delegate?.downloader(self, didFailWithError: error!)
            }else{
                let httpRes = response as! NSHTTPURLResponse
                if httpRes.statusCode == 200{
                    if data != nil{
                        self.delegate?.downloader(self, didFinishWithData: data)
                    }
                }else{
                    print("下载失败")
                }
            }
        }
        task.resume()
    }
}
