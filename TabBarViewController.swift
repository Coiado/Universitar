//
//  TabBarViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 1/14/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if self.tabBar.selectedItem?.title == "Configuração"{
            let currentUser = PFUser.currentUser()?.objectId
            if currentUser == nil{
                self.popoverPresentationController
                let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! LoginViewController
                self.presentViewController(vc, animated: true, completion:nil)
            }
        }
        
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
