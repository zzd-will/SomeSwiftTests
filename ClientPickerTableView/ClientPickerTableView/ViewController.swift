//
//  ViewController.swift
//  ClientPickerTableView
//
//  Created by mac on 16/1/13.
//  Copyright © 2016年 planning. All rights reserved.
//

import UIKit



class ViewController: UIViewController, ClientPickerTableViewControllerDelegate, InstructionsViewControllerDelegate {
    
    let transition = PopAnimator()
    @IBAction func Client(sender: AnyObject) {
        
        let instructionsViewController = InstructionsViewController()
        instructionsViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: instructionsViewController)
        navigationController.transitioningDelegate = self
        presentViewController(navigationController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func finish() {
        self.extensionContext!.completeRequestReturningItems(nil, completionHandler: nil)
    }
    func clientPickerViewController(clientPickerViewController: ClientPickerTableViewController) {
        // TODO: hook up Send Tab via Sync.
        // profile?.clients.sendItem(self.sharedItem!, toClients: clients)
        finish()
    }
    
    func clientPickerViewControllerDidCancel(clientPickerViewController: ClientPickerTableViewController) {
        finish()
    }
    
    func instructionsViewControllerDidClose(instructionsViewController: InstructionsViewController) {
//        finish()
//            presentViewController(navigationController, animated: false, completion: nil)
        instructionsViewController.removeFromParentViewController()
        
        dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

}
extension ViewController:UIViewControllerTransitioningDelegate{
    
    //Present的时候 使用自定义的动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
    
    //使用默认的动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
