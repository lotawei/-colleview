//
//  CollectionHeadView.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/8.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class CollectionHeadView: UICollectionReusableView {
    var  isfresh:Bool = false
    var   lab : UILabel = {
        let   la = UILabel()
        return  la
    }()
    var   aimge :UIImageView =  UIImageView()
   override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 0.8)
        self.lab.font = UIFont.systemFontOfSize(14)
        self.lab.textAlignment = .Left
        addSubview(self.lab)
    }
    func fresh(fresh:Bool)  {
        if fresh && !isfresh {
            
            aimge.image = UIImage(named: "star")
            addSubview(aimge)
            isfresh = fresh
        }else{
            return
        }
    }
    
    override  func layoutSubviews() {
        self.lab.sizeToFit()
        self.lab.center = CGPointMake(CGRectGetWidth(self.lab.frame)/2.0, CGRectGetHeight(self.lab.frame)/2.0 + 5.0)
        self.aimge.frame = CGRectMake(CGRectGetMaxX(self.lab.frame)+2, 5, 15, 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: CollectionCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.animateWithDuration(0.5) {
            cell.alpha = 0.0
            cell.alpha = 1.0
        }
    }
    
    
}
