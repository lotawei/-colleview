//
//  CategoryModel.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {
    var   name:String!
    var  icon:String!
    var   spus:NSMutableArray!
    
    
    init(dic:NSDictionary) {
        
       self.spus = NSMutableArray(capacity: 0)
        self.name = dic["name"] as! String
        self.icon = dic["icon"] as!  String
        
        let  foods = dic["spus"] as!  NSArray
        
        for food in foods {
            let   afood = FoodModel(dic: food  as!  NSDictionary)
            self.spus.addObject(afood)
        }
        
    }
    
}
//食物模型
class  FoodModel:NSObject{
    var  name : String!
    var  foodId:String!
    var  picture:String!
    var  praise_content:String!
    var  month_saled:NSInteger!
    var  min_price:Float!
    
    
    
    init(dic:NSDictionary) {
        
        self.name = dic["name"] as! String
        let   anumber =  dic["id"] as!  NSNumber
        let    aid =  anumber.integerValue
        self.foodId =  String.init(format: "%d", aid)
        self.picture = dic["picture"] as!  String
        self.praise_content  = dic["praise_content"] as!  String
        self.month_saled = dic["month_saled"] as!  NSInteger
        self.min_price = dic["min_price"] as! Float
        
        
    }
   
}
