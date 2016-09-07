
//
//  Righttableviewcell.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class Righttableviewcell: UITableViewCell {
    var   model : FoodModel!
    
    lazy var  imgagev:UIImageView = {
        let  iamgeview = UIImageView()
        iamgeview.sizeToFit()
        return   iamgeview
    }()
    lazy var  namelable:UILabel = {
        let  namelable = UILabel()
        return  namelable
    }()
    lazy  var   pricelable:UILabel = {
        let   pricelable  = UILabel()
        
        pricelable.textColor = UIColor.redColor()
        pricelable.font = UIFont.systemFontOfSize(13)
        return  pricelable
    }()
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?,data:FoodModel)
    {
        self.init(style: style, reuseIdentifier:reuseIdentifier)
        setmodel(data)
    }
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgagev)
        contentView.addSubview(pricelable)
        contentView.addSubview(namelable)
    }
    func setmodel(data:FoodModel)  {
        self.imgagev.sd_setImageWithURL(NSURL(string: data.picture), placeholderImage: UIImage(named: "place"))
        self.namelable.text = data.name
        self.pricelable.text = String.init(format: "$%.2f", data.min_price)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        self.imgagev.frame = CGRectMake(15, 15, 50, 50)
        self.namelable.frame = CGRectMake(80, 10, 200, 30)
        self.pricelable.frame = CGRectMake(80, 45, 200, 30)
    }
    
    
}
