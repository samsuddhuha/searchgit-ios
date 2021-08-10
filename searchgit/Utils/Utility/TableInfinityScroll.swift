//
//  TableInfinityScroll.swift
//  searchgit
//
//  Created by Samsud Dhuha on 10/08/21.
//

import Foundation
import UIKit

open class TableInfinityScroll: NSObject {
    var table: UITableView!
    var footerView: UIView!
    var indicatorColor: UIColor?
    var action: () -> ()
    
    var isLoad = false
    
    init(table: UITableView, action: @escaping ()->()) {
        self.table = table
        self.action = action
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - table.frame.size.height
        
        if actualPosition > contentHeight{
            if !isLoad {
                addViewIndicator()
            }
        }
        
    }
    
    func addViewIndicator(){
        self.isLoad = true
        
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: table.frame.width, height: 50))
        
        let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicatorView.color = indicatorColor ?? UIColor.gray
        indicatorView.center = footerView.center
        indicatorView.startAnimating()
        
        footerView.addSubview(indicatorView)
        table.tableFooterView = footerView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.action()
        }
    }
    
    func finishInfiniteScroll(){
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: table.frame.width, height: 0))
        table.tableFooterView = footerView
        table.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoad = false
        }
    }
}
