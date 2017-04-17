//
//  ViewController.swift
//  DataSource
//
//  Created by 童世超 on 2017/4/17.
//  Copyright © 2017年 童世超. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    private var dataSource: DataSource?
    
    let tableCellOneID = "tableCellOneID"
    
    let tableCellTwoID = "tableCellTwoID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    //初始化
    func initialize() {
        setupUI()
    }
    
    //创建UI
    func setupUI() {
        view.addSubview(tableView)
    }

    //MARK: - lazy load tableView
    lazy var tableView:UITableView = {
        let tableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .grouped)
        
        var cellOneData = [AnyObject]()
        
        var cellTwoData = [AnyObject]()
        
        for i in 0..<5 {
            cellOneData.append("我是组一中第\(i)行的数据" as AnyObject)
        }
        
        for i in 0..<5 {
            cellTwoData.append("我和组一长的很像但我是组二" as AnyObject)
        }
        
        
        //分离数据源
        self.dataSource = DataSource(itemsArray: [cellOneData, cellTwoData], identifiers: [self.tableCellOneID,self.tableCellTwoID], cellBlock: { (cell, item, indexPath) in
            
            //TableViewCellOne和TableViewCellTwo就是简单的继承了一下UITableViewCell
            if indexPath.section == 0 {
                cell.textLabel?.text = item as? String
            } else {
                cell.textLabel?.text = item as? String
            }
            
        })
        
        //直接把对象赋值给tableView.dataSource不行，没有保存对象
        tableView.dataSource = self.dataSource
        
        //注册两个cell
        tableView.register(TableViewCellOne.self, forCellReuseIdentifier: self.tableCellOneID)
        
        tableView.register(TableViewCellTwo.self, forCellReuseIdentifier: self.tableCellTwoID)
        
        return tableView
    }()
    


}

