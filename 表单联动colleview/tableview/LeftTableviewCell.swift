//
//  LeftTableviewCell.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//


//左边部分    作为导航效果 
class LeftTableviewCell: UITableViewCell {
    var  name:UILabel!
    var   yellview:UIView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        
        self.name = UILabel(frame: CGRectMake(10,10,60,40))
        self.name.font = UIFont.systemFontOfSize(13)
        self.name.textColor = UIColor.blackColor()
        contentView.addSubview(self.name)
        self.name.numberOfLines = 0;
        self.yellview = UIView(frame: CGRectMake(0,0,4,35))
        self.yellview.backgroundColor = UIColor.yellowColor()
        contentView.addSubview(self.yellview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        self.contentView.backgroundColor = selected ? UIColor.whiteColor()  : rgba
        self.highlighted = selected;
        self.name.highlighted = selected;
        self.yellview.hidden = !selected;
    }
    
}
