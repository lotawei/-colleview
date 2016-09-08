//
//  TableHeadView.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//
/// 可以在这里对分区表头 使劲玩耍
import UIKit

class TableHeadView: UIView {
    var   name:UILabel!
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = rgba
        self.name = UILabel(frame: CGRectMake(15,0,100,25))
        self.name.textAlignment = .Left
        self.name.font = UIFont.systemFontOfSize(13)
//        self.aimeg = UIImageView(frame: CGRectMake(200, 0, 20, 20))
//        self.aimeg.image  = UIImage(named: "star")
        
//        addSubview(aimeg)
        addSubview(name)
        
        
    }
    func addstar(star:NSInteger)
    {
        var   co = star<=0 ? 2 : star
        co = star>4 ? 4:star
        let   begin = CGRectGetMaxX(self.name.frame) + 30
        let  padding:CGFloat = 3
        let  w:CGFloat = 20.0
        let  h:CGFloat = 20.0
        for i in 0..<co {
            
            let  aimage = UIImageView()
            aimage.image = UIImage(named: "star")
            aimage.frame = CGRectMake(begin+(w+padding) * CGFloat( i), 0, w, h)
            addSubview(aimage)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
