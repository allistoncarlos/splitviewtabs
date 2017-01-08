//
//  TabBarController.swift
//  SplitViewTabs
//
//  Created by Alliston Aleixo on 07/01/17.
//  Copyright © 2017 Alliston Aleixo. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UISplitViewControllerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        
        // Configura cada UISplitViewController
        for viewController in self.viewControllers! {
            if (viewController is UISplitViewController) {
                configureSplitView(viewController as! UISplitViewController);
            }
        }
        
        super.viewWillAppear(animated);
    }
    
    // MARK: - Split view
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController  = secondaryViewController                           as? UINavigationController          else { return false }
        
        let topViewController = secondaryAsNavController.topViewController;
        
        if (topViewController as? DetailViewController) != nil {
            guard let detailController   = secondaryAsNavController.topViewController    as? DetailViewController           else { return false; }
            
            if detailController.detailItem == nil {
                // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                return true;
            }
        }
        
        return false;
    }
    
    func configureSplitView(_ splitViewController: UISplitViewController) {
        let splitViewDisplayMode                                                    = UIDevice.current.userInterfaceIdiom == .pad ?
            UISplitViewControllerDisplayMode.allVisible :
            UISplitViewControllerDisplayMode.automatic;
        
        let navigationController                                                    = splitViewController.viewControllers[1] as! UINavigationController;
        splitViewController.preferredDisplayMode                                    = splitViewDisplayMode;
        navigationController.topViewController!.navigationItem.leftBarButtonItem    = splitViewController.displayModeButtonItem;
        splitViewController.delegate                                                = self;
    }
}
