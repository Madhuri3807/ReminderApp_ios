//
//  LoginVC.swift
//  ReminderApp

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: PurpleThemeButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    var flag : Bool = true
    
    @IBAction func btnClick(_ sender: UIButton) {
        if sender == btnLogin {
            self.flag = false
            let error = self.validation(email: self.txtEmail.text!.trim(),password: self.txtPassword.text!.trim())

            if error.isEmpty {
                self.loginUser(email: self.txtEmail.text?.trim() ?? "", password: self.txtPassword.text?.trim() ?? "")
            }else{
                Alert.shared.showAlert(message: error, completion: nil)
            }
        }else if sender == btnForgotPassword {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: ForgotPasswordVC.self){
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func validation(email: String, password: String) -> String {
        
        if email.isEmpty {
            return STRING.errorEmail
        }else if !Validation.isValidEmail(email) {
            return STRING.errorValidEmail
        } else if password.isEmpty {
            return STRING.errorPassword
        } else if password.count < 8 {
                return STRING.errorPasswordCount
        } else if !Validation.isValidPassword(password) {
            return STRING.errorValidCreatePassword
        } else {
            return ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


//MARK:- Extension for Login Function
extension LoginVC {
    
    
    func loginUser(email:String,password:String) {
        
        _ = AppDelegate.shared.db.collection(rUser).whereField(rEmail, isEqualTo: email).whereField(rPassword, isEqualTo: password).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            if snapshot.documents.count != 0 {
                let data1 = snapshot.documents[0].data()
                let docId = snapshot.documents[0].documentID
                if let name: String = data1[rName] as? String, let email: String = data1[rEmail] as? String, let password: String = data1[rPassword] as? String {
                    GFunction.user = UserModel(docID: docId, name: name, email: email, password: password)
                }
                GFunction.shared.firebaseRegister(data: email)
                UIApplication.shared.setTab()
                Alert.shared.showAlert(message: "You are logged in with Reminder App credentials", completion: nil)
            }else{
                if !self.flag {
                    Alert.shared.showAlert(message: "Please check your credentials !!!", completion: nil)
                    self.flag = true
                }
            }
        }
        
    }
}
