//
//  TACategoryModel.swift
//  TinyAspect
//
//  Created by qianfeng on 16/8/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class TACategoryModel: NSObject {
    
    
    var id:String?
    var name:String?
    var sname:String?
    
    var pic:String?
    var bookcount:String?
    var des:String?
    
    var realcount:String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "description"{
            self.des = value as? String
        }
    }

}
