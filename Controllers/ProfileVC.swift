//
//  ProfileVC.swift
//  ReminderApp
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var lblNAme: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var btnLogout: RoundedThemeButton!
    
    //MARK: Custom Method
    
    func setUpView(){
        self.applyStyle()
    }
    
    func applyStyle(){
        if !GFunction.user.email.isEmpty {
            let user = GFunction.user
            self.lblMail.text = user?.email.description
            self.lblNAme.text = user?.name.description
        }
    }
    
    //MARK: Action Method
    
    @IBAction func btnClick(_ sender: UIButton) {
        Alert.shared.showAlert("", actionOkTitle: "Logout", actionCancelTitle: "Cancel", message: "Are you sure you want to logout?") { (yes) in
            if yes {
                UIApplication.shared.setStart()
            }
        }
    }
    
    //MARK: UILifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    
    deinit {
        debugPrint("‼️‼️‼️ deinit : \(self) ‼️‼️‼️")
    }
}
