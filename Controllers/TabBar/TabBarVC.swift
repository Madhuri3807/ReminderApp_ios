//
//  TabBarVC.swift
//  ReminderApp
//
//

import UIKit
import STTabbar

class TabBarVC: UITabBarController {

    //MARK: Outlet
    
    //MARK: Class Variable
    
    //MARK: Custom Method
    
    func setUpView(){
        self.applyStyle()
        self.tabBarSetup()
    }
    
    func applyStyle(){
        
    }
    
    func tabBarSetup() {
        if let tabBar = tabBar as? STTabbar {
            print(tabBar)
            tabBar.centerButtonActionHandler = {
                if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "AddReminderVC") as? AddReminderVC {
                    (self.parent as? UINavigationController)?.pushViewController(nextVC, animated: true)
                    
                }
                (self.parent as? UINavigationController)?.navigationBar.isHidden = true
            }
        }
    }
    
    //MARK: Action Method
    
    //MARK: Delegates
    
    //MARK: UILifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    deinit {
        debugPrint("‼️‼️‼️ deinit : \(self) ‼️‼️‼️")
    }

}
