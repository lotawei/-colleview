//
//  CollectionViewController.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

public let reuseIdentifercollcell = "CollCell"
public let headreuseIdentifier = "CollHeadView"
public let  categoryIdentifier = "LeftCell"
class CollectionViewController: UIViewController {
    lazy var  collectionView:UICollectionView  = {
        let   alayout = UICollectionViewFlowLayout()
        alayout.scrollDirection = .Vertical
        alayout.minimumLineSpacing = 2  //上下间距
        alayout.minimumInteritemSpacing = 2//左右间距
        let  collec = UICollectionView(frame: CGRectMake(80 + 2, 2+64, screenwidth-80-4, screenheight - 64 - 4), collectionViewLayout: alayout)
        collec.backgroundColor = UIColor.whiteColor()
       
        return  collec
    }()
    var  tableview:UITableView = {
        let   tab = UITableView(frame: CGRectMake(0, 0, 80, screenheight), style: .Plain)
        let  footview = UIView(frame:CGRectMake(0,0,80,1))
        
        tab.tableFooterView = footview
        
        return  tab
    }()
    var  datasource:NSMutableArray = {
       let  da = NSMutableArray(capacity: 0)
        return  da
    }()
    var  colletiondatas:NSMutableArray = {
        let  da = NSMutableArray(capacity: 0)
        return  da
    }()
    
    
    private  var  selectindex:NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectindex = 0
        
        //准备数据
        prepareData()
        view.backgroundColor = UIColor.whiteColor()
               self.tableview.registerClass(LeftTableviewCell.self, forCellReuseIdentifier: categoryIdentifier)
      
        self.tableview.rowHeight = 55;
     
        view.addSubview(self.tableview)
      
        self.collectionView.registerClass(CollectionCell.self,forCellWithReuseIdentifier: reuseIdentifercollcell)
       self.collectionView.registerClass(CollectionHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headreuseIdentifier)
    
        view.addSubview(self.collectionView)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.tableview.selectRowAtIndexPath(NSIndexPath(forRow: selectindex,inSection: 0), animated: true, scrollPosition: .Top)
        
    }
    func prepareData()  {
        let   path = NSBundle.mainBundle().pathForResource("liwushuo", ofType: "json")
        let   data = NSData.init(contentsOfFile: path!)
        do{
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            let   categories = dict["data"]!!["categories"] as! NSArray
            
            
            for dic in categories {
                
                let  catemodel = CollectionModel(dic: dic as! NSDictionary)
                self.datasource.addObject(catemodel)
                let  adata = NSMutableArray(capacity: 0)
                for food in catemodel.subcategories {
                    adata.addObject(food as! SubCategoryModel)
                }
                self.colletiondatas.addObject(adata)
                
                
            }
            
        }catch let  error  as NSError {
            
            print(error)
        }

    }

}
//mark -- 代理
extension  CollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout{
  // =----------------=   tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return   1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   self.datasource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var   cell =   tableView.dequeueReusableCellWithIdentifier(categoryIdentifier) as? LeftTableviewCell
        if cell==nil {
            cell =  LeftTableviewCell(style: .Default, reuseIdentifier: categoryIdentifier)
        }
        let    acoll  =  self.datasource[indexPath.row]  as!  CollectionModel
        cell?.name.text = acoll.name
        
        return  cell!
    }
    //---------------------collection
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let    cell =   collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifercollcell, forIndexPath: indexPath) as!  CollectionCell
        let subcate = self.colletiondatas[indexPath.section][indexPath.row] as!  SubCategoryModel
        cell.setmodel(subcate)
        return  cell
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return  self.datasource.count
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let   collmode = self.datasource[section] as! CollectionModel
        
        return   collmode.subcategories.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return  CGSizeMake((screenwidth - 80 - 4 - 4 )/3,(screenwidth - 80 - 4 - 4 )/3 + 30)
    }
    //设置 分组表头信息展示
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            let   aview = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headreuseIdentifier, forIndexPath: indexPath) as! CollectionHeadView
           let   amode = self.datasource[indexPath.section] as! CollectionModel
           aview.lab.text = amode.name
        aview.fresh(indexPath.section/3  == 0 ? true:false)
        return   aview
    
        
    }
    //设置分区 表头 绝对大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return   CGSizeMake(screenwidth, 25)
    }
    
    //左边联动
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem:  0,inSection: indexPath.row), atScrollPosition: .Top, animated: true)
        selectindex =  indexPath.row
    }
    //右边联动
    func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
         self.tableview.selectRowAtIndexPath(NSIndexPath(forRow:selectindex  ,inSection: 0), animated: true, scrollPosition: .Top)
           selectindex = indexPath.section
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.animateWithDuration(0.5) { 
            cell.alpha = 0.3
            cell.alpha  = 1.0
        }
    }
}

