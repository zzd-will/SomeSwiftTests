//
//  InstructionViewController.swift
//  ClientPickerTableView
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 planning. All rights reserved.
//

import Foundation

import UIKit
import SnapKit

struct InstructionsViewControllerUX {
    static let TopPadding = CGFloat(20)
    static let TextFont = UIFont.systemFontOfSize(UIFont.labelFontSize())
    static let TextColor = UIColor(red:0.427, green:0.800, blue:0.102, alpha:1.0)

    static let LinkColor = UIColor.blueColor()
}

protocol InstructionsViewControllerDelegate: class {
    func instructionsViewControllerDidClose(instructionsViewController: InstructionsViewController)
}

private func highlightLink(var s: NSString, withColor color: UIColor) -> NSAttributedString {
    let start = s.rangeOfString("<")
    if start.location == NSNotFound {
        return NSAttributedString(string: s as String)
    }
    
    s = s.stringByReplacingCharactersInRange(start, withString: "")
    let end = s.rangeOfString(">")
    s = s.stringByReplacingCharactersInRange(end, withString: "")
    let a = NSMutableAttributedString(string: s as String)
    let r = NSMakeRange(start.location, end.location-start.location)
    a.addAttribute(NSForegroundColorAttributeName, value: color, range: r)
    return a
}

func setupHelpView(view: UIView, introText: String, showMeText: String) {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "emptySync")
    view.addSubview(imageView)
    imageView.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(view).offset(InstructionsViewControllerUX.TopPadding)
        make.centerX.equalTo(view)
    }
    
    let label1 = UILabel()
    view.addSubview(label1)
    label1.text = introText
    label1.numberOfLines = 0
    label1.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label1.font = InstructionsViewControllerUX.TextFont
    label1.textColor = InstructionsViewControllerUX.TextColor
    label1.textAlignment = NSTextAlignment.Center
    label1.snp_makeConstraints { (make) -> Void in
        make.width.equalTo(250)
        make.top.equalTo(imageView.snp_bottom).offset(InstructionsViewControllerUX.TopPadding)
        make.centerX.equalTo(view)
    }
    
    let label2 = UILabel()
    view.addSubview(label2)
    label2.numberOfLines = 0
    label2.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label2.font = InstructionsViewControllerUX.TextFont
    label2.textColor = InstructionsViewControllerUX.TextColor
    label2.textAlignment = NSTextAlignment.Center
    label2.attributedText = highlightLink(showMeText, withColor: InstructionsViewControllerUX.LinkColor)
    label2.snp_makeConstraints { (make) -> Void in
        make.width.equalTo(250)
        make.top.equalTo(label1.snp_bottom).offset(InstructionsViewControllerUX.TopPadding)
        make.centerX.equalTo(view)
    }
}

class InstructionsViewController: UIViewController {
    weak var delegate: InstructionsViewControllerDelegate?
    
        let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None
        view.backgroundColor = UIColor.whiteColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Close", tableName: "SendTo", comment: "Close button in top navigation bar"), style: UIBarButtonItemStyle.Done, target: self, action: "close")
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItemStyle.Done, target: self, action: "close")

        
        setupHelpView(view,
            introText: NSLocalizedString("You are not signed in to your Firefox Account.", tableName: "SendTo", comment: "See http://mzl.la/1ISlXnU"),
            showMeText: NSLocalizedString("Please open Firefox, go to Settings and sign in to continue.", tableName: "SendTo", comment: "See http://mzl.la/1ISlXnU"))
    }
    
    func close() {
        delegate?.instructionsViewControllerDidClose(self)
    }
    
    func showMeHow() {
        print("Show me how") // TODO Not sure what to do or if to keep this. Waiting for UX feedback.
    }
}
