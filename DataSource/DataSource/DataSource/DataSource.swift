//
//  DataSource.swift
//  SwiftLogan
//
//  Created by 童世超 on 2017/4/15.
//  Copyright © 2017年 童世超. All rights reserved.
//

import UIKit

class DataSource: NSObject, UITableViewDataSource {

    private var identifier:String = ""
    
    var items:[AnyObject]?
    
    //回调事件
    private var cellBlock:((UITableViewCell, AnyObject, IndexPath)->())?

    //便利初始化器
    convenience init(items:Array<Any>, identifier:String?, cellBlock:@escaping (_ cell:UITableViewCell, _ item:AnyObject, _ indexPath:IndexPath)->()) {
        self.init()
        
        self.identifier = identifier!
        
        self.cellBlock = cellBlock
        
        self.items = items as [AnyObject]
    }
    
    func itemAt(indexpath:IndexPath?) -> AnyObject {
        return items![(indexpath?.row)!] as AnyObject
    }
    
    override init() {
        super.init()
    }

    //MARK: -UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        
        let item = itemAt(indexpath: indexPath)
        
        cellBlock!(cell, item, indexPath)
        
        return cell
    }
}
