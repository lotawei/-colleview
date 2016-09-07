
//
//  TableViewController.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class TableViewController:UIViewController {
    
    var   selectindex:NSInteger!
    var   isScrolldown:Bool!
    
    var   lefttableview:UITableView = {
        let   rect = CGRectMake(0, 0, 80, screenheight)
        let   lefttableview =  UITableView(frame: rect, style: .Plain)
      
        lefttableview.tableFooterView = UIView()
        lefttableview.showsVerticalScrollIndicator = false
        lefttableview.separatorColor = UIColor.grayColor()
        return    lefttableview
    }()
    lazy var  righttableview : UITableView = {
        let   rect = CGRectMake(80, 64, screenwidth-80, screenheight - 64 )
        let   righttableview =  UITableView(frame: rect, style: .Plain)
        righttableview.separatorStyle = .None
        righttableview.showsVerticalScrollIndicator = false
        
        return    righttableview
    }()
    
    
    //分类数据
    var  categorydata:NSMutableArray = {
        let  cate = NSMutableArray(capacity: 0)
        return  cate
    }()
    //二级 数据
    var   fooddata:NSMutableArray = {
        let   food = NSMutableArray(capacity:0)
        return   food
    }()
    
    
    
    
    override func viewDidLoad() {
        
        //准备好数据
        selectindex = 0
        isScrolldown = true
        preparedata()
        
        lefttableview.rowHeight = 55;
        lefttableview.delegate = self
        righttableview.delegate = self
        righttableview.rowHeight = 80
        lefttableview.dataSource = self
        righttableview.dataSource = self
        lefttableview.tag =  1001
        righttableview.tag=1002
        lefttableview.registerClass(LeftTableviewCell.self, forCellReuseIdentifier: "leftcell")
        righttableview.registerClass(Righttableviewcell.self, forCellReuseIdentifier: "rightcell")
        view.addSubview(lefttableview)
        
        view.addSubview(righttableview)
        lefttableview.selectRowAtIndexPath(NSIndexPath(forRow: 0,inSection: selectindex) ,animated: true, scrollPosition: .Top)
    }
    
    func preparedata()  {
        let   path = NSBundle.mainBundle().pathForResource("meituan", ofType: "json")
        let   data = NSData.init(contentsOfFile: path!)
        do{
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            let   foods = dict["data"]!!["food_spu_tags"] as! NSArray
            
            
            for dic in foods {
                
                let  catemodel = CategoryModel(dic: dic as! NSDictionary)
                self.categorydata.addObject(catemodel)
                let  adata = NSMutableArray(capacity: 0)
                for food in catemodel.spus {
                    adata.addObject(food as! FoodModel)
                }
                self.fooddata.addObject(adata)
                
                
            }
            
        }catch let  error  as NSError {
            
            print(error)
        }
        
        
        
        
        
        
    }
    
    
    
}
extension  TableViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        //是右边的那个分为 多少组
        
        if tableView.tag == 1002 {
            return  self.categorydata.count
        }
        return  1;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1001 {
            
            return  self.categorydata.count
        }
        
        return  self.fooddata[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 1001 {
            var   cell = tableView.dequeueReusableCellWithIdentifier("leftcell") as? LeftTableviewCell
            if cell == nil
            {
                cell =  LeftTableviewCell(style: .Default, reuseIdentifier: "leftcell")
                
                
            }
            let   cate  = self.categorydata[indexPath.row] as?  CategoryModel
            cell?.name.text = cate?.name
            return   cell!
        }
       else   {
            var  cell = tableView.dequeueReusableCellWithIdentifier("rightcell") as?   Righttableviewcell
            if cell == nil {
                
                cell =  Righttableviewcell(style: .Default, reuseIdentifier: "rightcell")
                
            }
            let  foodmode = self.fooddata[indexPath.section][indexPath.row] as! FoodModel
            cell?.setmodel(foodmode)
            return  cell!
        }
    
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 1002 {
            return  25
        }
        return 0
    }
    //设置二级分类的标题 ,这个必须给每个组先给个高度  和上面这个方法联合使用
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView.tag == 1002 {
            let   view = TableHeadView(frame: CGRectMake(0,0,screenwidth,15))
            let   afood = self.categorydata[section] as! CategoryModel
            view.name.text =  afood.name
            //设置星星是几个星 的店 //这里模拟下如果 名字的长度大于三个字我们让他成为三星点
         
        
           
            view.addstar(afood.name.characters.count)
            
            return  view
        }
        return  nil
    }
    //判断拖拽右边的tableview 发现这个方法好使 ，能知道 怎么与左边相应联动呢
    //那就是发现 表头的东西变了那么 左边就应该变化啦
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if ((tableView.tag == 1002) && !isScrolldown && righttableview.dragging)
        {
            selectRowAtIndexPath(section)
        }
    }
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if ((righttableview == tableView) && !isScrolldown && righttableview.dragging)
        {
            selectRowAtIndexPath(section+1)
        }
    }
    func selectRowAtIndexPath(index:NSInteger)  {
        //滑动右边处理滑动左边
        lefttableview.scrollToRowAtIndexPath(NSIndexPath(forRow: index,inSection: 0), atScrollPosition: .Top, animated: true)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         // 处理点击左边  滑动右边
        if tableView.tag == 1001 {
            self.selectindex = indexPath.row
            righttableview.scrollToRowAtIndexPath(NSIndexPath(forRow: 0,inSection: self.selectindex), atScrollPosition: .Top, animated: true)
        }
    }
    //记录右边是上滑动还是下滑动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var   lastoffsety:CGFloat = 0
        let   tab = scrollView  as! UITableView
        if tab.tag == 1002 {
            isScrolldown = lastoffsety < scrollView.contentOffset.y
            lastoffsety = scrollView.contentOffset.y
        }
    }
    
}