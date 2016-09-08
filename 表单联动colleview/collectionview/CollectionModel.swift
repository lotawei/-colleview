//
//  CollectionModel.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/8.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class CollectionModel: NSObject {

    var   name:String!
    lazy var   subcategories:NSMutableArray = {
       let   sub = NSMutableArray(capacity: 0)
        return  sub
    }()
     init(dic:NSDictionary) {
        super.init()
        self.name = dic["name"] as! String
        let  subcategories = dic["subcategories"] as! NSArray
        for dic in subcategories {
            let    subcate = SubCategoryModel(dic: dic as! NSDictionary)
            self.subcategories.addObject(subcate)
        }
    }
    

}
class SubCategoryModel: NSObject {
    var    icon_url:String!
    var     name:String!
     init(dic:NSDictionary)
    {
        super.init()
        self.name = dic["name"] as! String
        self.icon_url = dic["icon_url"] as! String
        
    }
}
