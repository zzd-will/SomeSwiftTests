//
//  ClientPickerTableView.swift
//  ClientPickerTableView
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 planning. All rights reserved.
//

import UIKit
import SnapKit

protocol ClientPickerTableViewControllerDelegate {
    func clientPickerViewControllerDidCancel(clientPickerViewController: ClientPickerTableViewController) -> Void
    func clientPickerViewController(clientPickerViewController: ClientPickerTableViewController) -> Void
}

struct ClientPickerTableViewControllerUX {
    static let TableHeaderRowHeight = CGFloat(50)
    static let TableHeaderTextFont = UIFont.systemFontOfSize(16)
    static let TableHeaderTextColor = UIColor.grayColor()
    static let TableHeaderTextPaddingLeft = CGFloat(20)
    
    static let DeviceRowTintColor = UIColor(red:0.427, green:0.800, blue:0.102, alpha:1.0)
    static let DeviceRowHeight = CGFloat(50)
    static let DeviceRowTextFont = UIFont.systemFontOfSize(16)
    static let DeviceRowTextPaddingLeft = CGFloat(72)
    static let DeviceRowTextPaddingRight = CGFloat(50)
}

class ClientPickerTableViewController: UITableViewController {
   
    var clientPickerDelegate: ClientPickerTableViewControllerDelegate?
    
    var reloading = true
   
    var selectedClients = NSMutableSet()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "title"
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        tableView.registerClass(ClientPickerTableViewHeaderCell.self, forCellReuseIdentifier: ClientPickerTableViewHeaderCell.CellIdentifier)
        
        tableView.registerClass(ClientPickerTableViewCell.self, forCellReuseIdentifier: ClientPickerTableViewCell.CellIdentifier)
        
        tableView.registerClass(ClientPickerNoClientsTableViewCell.self, forCellReuseIdentifier: ClientPickerNoClientsTableViewCell.CellIdentifier)
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let refreshControl = refreshControl {
            refreshControl.beginRefreshing()
            let height = -(refreshControl.bounds.size.height + (self.navigationController?.navigationBar.bounds.size.height ?? 0))
            self.tableView.contentOffset = CGPointMake(0, height)
        }
        reloadClients()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
  
            return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
            if section == 0 {
                return 1
            } else {
                return 2
            }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if 1 > 0 {
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier(ClientPickerTableViewHeaderCell.CellIdentifier, forIndexPath: indexPath) as! ClientPickerTableViewHeaderCell
            } else {
                let clientCell = tableView.dequeueReusableCellWithIdentifier(ClientPickerTableViewCell.CellIdentifier, forIndexPath: indexPath) as! ClientPickerTableViewCell
                clientCell.nameLabel.text = "text"
                clientCell.clientType = ClientType.Mobile
                clientCell.checked = selectedClients.containsObject(indexPath)
                cell = clientCell
            }
        } else {
            if reloading == false {
                cell = tableView.dequeueReusableCellWithIdentifier(ClientPickerNoClientsTableViewCell.CellIdentifier, forIndexPath: indexPath) as! ClientPickerNoClientsTableViewCell
            } else {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ClientCell")
            }
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if 1 > 0 && indexPath.section == 1 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            if selectedClients.containsObject(indexPath) {
                selectedClients.removeObject(indexPath)
            } else {
                selectedClients.addObject(indexPath)
            }
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            
            navigationItem.rightBarButtonItem?.enabled = (selectedClients.count != 0)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if 1 > 0 {
            if indexPath.section == 0 {
                return ClientPickerTableViewControllerUX.TableHeaderRowHeight
            } else {
                return ClientPickerTableViewControllerUX.DeviceRowHeight
            }
        } else {
            return tableView.frame.height
        }
    }
    
    private func reloadClients() {
        reloading = true
        dispatch_async(dispatch_get_main_queue()) {
                    if 1 == 0 {
                        self.navigationItem.rightBarButtonItem = nil
                    } else {
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Send", tableName: "SendTo", comment: "Navigation bar button to Send the current page to a device"), style: UIBarButtonItemStyle.Done, target: self, action: "send")
                        self.navigationItem.rightBarButtonItem?.enabled = false
                    }
                    self.selectedClients.removeAllObjects()
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
    
    }
    
    func refresh() {
        reloadClients()
    }
    
    func cancel() {
        clientPickerDelegate?.clientPickerViewControllerDidCancel(self)
    }
    
    func send() {
        for indexPath in selectedClients {
                    }
        clientPickerDelegate?.clientPickerViewController(self)
    }
}
class ClientPickerTableViewHeaderCell: UITableViewCell {
    static let CellIdentifier = "ClientPickerTableViewSectionHeader"
    let nameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        nameLabel.font = ClientPickerTableViewControllerUX.TableHeaderTextFont
        nameLabel.text = NSLocalizedString("Available devices:", tableName: "SendTo", comment: "Header for the list of devices table")
        nameLabel.textColor = ClientPickerTableViewControllerUX.TableHeaderTextColor
        
        nameLabel.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(ClientPickerTableViewControllerUX.TableHeaderTextPaddingLeft)
            make.centerY.equalTo(self)
            make.right.equalTo(self)
        }
        
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsetsZero
        separatorInset = UIEdgeInsetsZero
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum ClientType: String {
    case Mobile = "deviceTypeMobile"
    case Desktop = "deviceTypeDesktop"
}

class ClientPickerTableViewCell: UITableViewCell {
    static let CellIdentifier = "ClientPickerTableViewCell"
    
    var nameLabel: UILabel
    var checked: Bool = false {
        didSet {
            self.accessoryType = checked ? UITableViewCellAccessoryType.DisclosureIndicator : UITableViewCellAccessoryType.None
        }
    }
    
    var clientType: ClientType = ClientType.Mobile {
        didSet {
            self.imageView?.image = UIImage(named: clientType.rawValue)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        nameLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        nameLabel.font = ClientPickerTableViewControllerUX.DeviceRowTextFont
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.tintColor = ClientPickerTableViewControllerUX.DeviceRowTintColor
        self.preservesSuperviewLayoutMargins = false
        self.selectionStyle = UITableViewCellSelectionStyle.Default
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(ClientPickerTableViewControllerUX.DeviceRowTextPaddingLeft)
            make.centerY.equalTo(self.snp_centerY)
            make.right.equalTo(self.snp_right).offset(-ClientPickerTableViewControllerUX.DeviceRowTextPaddingRight)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ClientPickerNoClientsTableViewCell: UITableViewCell {
    static let CellIdentifier = "ClientPickerNoClientsTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHelpView(contentView,
            introText: NSLocalizedString("You don't have any other devices connected to this Firefox Account available to sync.", tableName: "SendTo", comment: "Error message shown in the remote tabs panel"),
            showMeText: "")
        separatorInset = UIEdgeInsetsMake(0, 1000, 0, 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}