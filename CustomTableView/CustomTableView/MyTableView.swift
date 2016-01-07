//
//  MyTableView.swift
//  CustomTableView
//
//  Created by mac on 15/12/31.
//  Copyright © 2015年 planning. All rights reserved.
//

import UIKit

class MyTableView: UITableViewController {
    
    private let Identifier = "CellIdentifier"
    private let SectionHeaderIdentifier = "SectionHeaderIdentifier"
    
    override func viewDidLoad() {
        navigationItem.title = "hello"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "done",
            style: UIBarButtonItemStyle.Done,
            target: navigationController, action: "SELdone")
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "back",
            style: UIBarButtonItemStyle.Done,
            target: navigationController, action: "SELback")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "right",
            style: UIBarButtonItemStyle.Done,
            target: navigationController, action: "SELright")
        
        tableView.registerClass(MyTableViewCell.self, forCellReuseIdentifier: Identifier)
        
        tableView.registerClass(MyTableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderIdentifier)
        tableView.tableFooterView = MyTableFooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 128))
//
        tableView.separatorColor = UIColor(red: 255/255, green: 223/255, blue: 243/255, alpha: 0.9)

        tableView.backgroundColor = UIColor(red: 205/255, green: 223/255, blue: 243/255, alpha: 0.9)

    }
    override func viewDidAppear(animated: Bool) {
        
    }
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return 3
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            
            let cell = tableView.dequeueReusableCellWithIdentifier(Identifier,
                forIndexPath: indexPath)
            
            cell.textLabel!.text = "Cell \(indexPath.row)"
            cell.detailTextLabel?.text = String("super.init(cell stypell)")
            
            return cell
            
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(SectionHeaderIdentifier) as! MyTableSectionHeaderView
            let testString = "test"
           
            headerView.titleLabel.text = testString
        
            if section == 0 {
                headerView.showTopBorder = false
            } else {
                headerView.showTopBorder = true
            }
        
            return headerView
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // 可以根据不同的内容设置不同高度
        let height: CGFloat = 100
        return height
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //make account/sign-in and close private tabs rows taller, as per design specs
        if indexPath.section == 0 && indexPath.row == 0 {
            return 64
        }
        
        if #available(iOS 9, *) {
            if indexPath.section == 2 && indexPath.row == 1 {
                return 64
            }
        }
        
        return 44
    }
    
//    override func tableView(tableView: UITableView,
//        titleForFooterInSection section: Int) -> String?{
//            return "Section \(section) Footer"
//    }

}
class MyTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        indentationWidth = 0
        layoutMargins = UIEdgeInsetsZero
        separatorInset = UIEdgeInsetsZero
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MyTableSectionHeaderView: UITableViewHeaderFooterView {
    var showTopBorder: Bool = true {
        didSet {
            topBorder.hidden = !showTopBorder
        }
    }
    
    var showBottomBorder: Bool = true {
        didSet {
            bottomBorder.hidden = !showBottomBorder
        }
    }
    
    
    var titleLabel: UILabel = {
        var headerLabel = UILabel()
        var frame = headerLabel.frame
        frame.origin.x = 15
        frame.origin.y = 25
        headerLabel.frame = frame
        headerLabel.textColor = UIColor(red: 130/255, green: 135/255, blue: 153/255, alpha: 1.0)
        if #available(iOS 8.2, *) {
            headerLabel.font = UIFont.systemFontOfSize(25.0, weight: UIFontWeightMedium)
        } else {
            // Fallback on earlier versions
            headerLabel.font = UIFont.systemFontOfSize(20.0)
        }
        return headerLabel
    }()
    
    private lazy var topBorder: CALayer = {
        let topBorder = CALayer()
        topBorder.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).CGColor
        return topBorder
    }()
    
    private lazy var bottomBorder: CALayer = {
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).CGColor
        return bottomBorder
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 245/255, alpha: 1.0)
        addSubview(titleLabel)
        clipsToBounds = true
        layer.addSublayer(topBorder)
        layer.addSublayer(bottomBorder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomBorder.frame = CGRectMake(0.0, frame.size.height - 0.5, frame.size.width, 0.5)
        topBorder.frame = CGRectMake(0.0, 0.0, frame.size.width, 0.5)
        titleLabel.sizeToFit()
    }
}
class MyTableFooterView: UIView {
    var logo: UIImageView = {
        var image =  UIImage(named: "ramboTux")
        var imageView =  UIImageView(image:image)
        imageView.contentMode = UIViewContentMode.ScaleToFill
        imageView.frame = CGRectMake(0,0,50,50)
        return imageView
    }()
    
    private lazy var topBorder: CALayer = {
        let topBorder = CALayer()
        topBorder.backgroundColor = UIColor(red: 1/255, green: 223/255, blue: 1/255, alpha: 0.9).CGColor
        return topBorder
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.61, green: 0.53, blue: 0.25, alpha: 1)
        layer.addSublayer(topBorder)
        addSubview(logo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topBorder.frame = CGRectMake(0.0, 0.0, frame.size.width, 0.5)
        logo.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    }
}
///////////////////////////////






