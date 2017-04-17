//
//  DataSource.swift
//  SwiftLogan
//
//  Created by 童世超 on 2017/4/15.
//  Copyright © 2017年 童世超. All rights reserved.
//

import UIKit

class DataSource: NSObject, UITableViewDataSource {
    
    //单个标识
    private var identifier:String = ""
    
    //标识集合
    private var identifierArray:[String]?
    
    //包含每个组
    var itemsArray:[[AnyObject]]?
    
    //只包含一组
    var items:[AnyObject]?
    
    //回调事件
    private var cellBlock:((UITableViewCell, AnyObject, IndexPath)->())?
    
    //便利初始化器 单个Section
    convenience init(items:[AnyObject], identifier:String?, cellBlock:@escaping (_ cell:UITableViewCell, _ item:AnyObject, _ indexPath:IndexPath)->()) {
        //        self.init()
        self.init(itemsArray: [items], identifiers: [identifier!], cellBlock: cellBlock)
        
        self.identifier = identifier!
        
        self.cellBlock = cellBlock
        
        self.items = items
    }
    
    //便利初始化器 多个Section ,兼容初始化单个Section的初始化器
    convenience init(itemsArray:[[AnyObject]], identifiers:[String]?, cellBlock:@escaping (_ cell:UITableViewCell, _ item:AnyObject, _ indexPath:IndexPath)->()) {
        self.init()
        
        self.identifierArray = identifiers
        
        self.cellBlock = cellBlock
        
        self.itemsArray = itemsArray
    }
    
    func itemAt(indexpath:IndexPath?) -> AnyObject {
        
        return itemsArray![indexpath!.section][indexpath!.row] as AnyObject

    }
    
    override init() {
        super.init()
    }
    
    //MARK: -UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemsArray!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemsArray![section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifierArray![indexPath.section] )!
        
        let item = itemAt(indexpath: indexPath)
        
        cellBlock!(cell, item, indexPath)
        
        return cell

    }
}
