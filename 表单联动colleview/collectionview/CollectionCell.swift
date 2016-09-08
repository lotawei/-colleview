//
//  CollectionCell.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/8.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class CollectionCell: UICollectionViewCell {

    var   subcategory:SubCategoryModel!
    var   imgv:UIImageView = {
      let    img = UIImageView()
        img.contentMode = .ScaleAspectFit
        return  img
    }()
    var   namelab:UILabel = {
        let    nam = UILabel()
        nam.font = UIFont.systemFontOfSize(12)
        nam.textAlignment = .Center
        return  nam
    }()
    override  init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(self.imgv)
        contentView.addSubview(self.namelab)
    }
    func setmodel(sub:SubCategoryModel)  {
        imgv.sd_setImageWithURL(NSURL(string: sub.icon_url), placeholderImage: UIImage(named: "place"))
        namelab.text = sub.name
        
    }
    override func layoutSubviews() {
     imgv.frame =  CGRectMake(2, 2, self.frame.size.width - 8, self.frame.size.height - 8)
       namelab.frame = CGRectMake(2, self.frame.size.width + 8, self.frame.size.width - 4, 20)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
