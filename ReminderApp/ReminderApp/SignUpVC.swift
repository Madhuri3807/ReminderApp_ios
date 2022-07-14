//
//  SignUpVC.swift
//  ReminderApp


import UIKit

class SignUpVC: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: PurpleThemeButton!
    
    var flag: Bool = true
    
    @IBAction func btnClick(_ sender:  UIButton){
        
        self.flag = false
        let error = self.validation(name: self.txtName.text?.trim() ?? "", email: self.txtEmail.text?.trim() ?? "", password: self.txtPassword.text?.trim() ?? "", confirmPass: self.txtConfirmPassword.text?.trim() ?? "")
        
        if error.isEmpty {
            self.getExistingUser(name: self.txtName.text ?? "", email: self.txtEmail.text ?? "", password: self.txtPassword.text ?? "")
        }else{
            Alert.shared.showAlert(message: error, completion: nil)
        }
    }
    
    
    private func validation(name: String, email: String, password: String, confirmPass: String) -> String {
        
        if name.isEmpty {
            return STRING.errorEnterName
            
        } else if email.isEmpty {
            return STRING.errorEmail
            
        } else if !Validation.isValidEmail(email) {
            return STRING.errorValidEmail
            
        } else if password.isEmpty {
            return STRING.errorPassword
            
        } else if password.count < 8 {
            return STRING.errorPasswordCount
            
        } else if !Validation.isValidPassword(password) {
            return STRING.errorValidCreatePassword
            
        } else if confirmPass.isEmpty {
            return STRING.errorConfirmPassword
            
        } else if password != confirmPass {
            return STRING.errorPasswordMismatch
            
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
// extension  SignUpVC {

//     func createAccount(name: String, email: String, password: String) {
//         var ref : DocumentReference? = nil
//         ref = AppDelegate.shared.db.collection(rUser).addDocument(data:
//             [
//               rEmail: email,
//               rName: name,
//               rPassword : password,
//             ])
//         {  err in
//             if let err = err {
//                 print("Error adding document: \(err)")
//             } else {
//                 print("Document added with ID: \(ref!.documentID)")
//                 GFunction.shared.firebaseRegister(data: email)
//                 GFunction.user = UserModel(docID: docID, name: name, email: email, password: password)
//                 UIApplication.shared.setTab()
//                 Alert.shared.showAlert(message: "Welcome to Reminder App Family !!!", completion: nil)
//                 self.flag = true
//             }
//         }
//     }

//     func getExistingUser(name: String, email: String, password: String) {

//         _ = AppDelegate.shared.db.collection(rUser).whereField(rEmail, isEqualTo: email).addSnapshotListener{ querySnapshot, error in

//             guard let snapshot = querySnapshot else {
//                 print("Error fetching snapshots: \(error!)")
//                 return
//             }

//             if snapshot.documents.count == 0 {
//                 self.createAccount(name: name, email: email, password: password)
//                 self.flag = true
//             }else{
//                 if !self.flag {
//                     Alert.shared.showAlert(message: "Email is already used... try with another one !!!", completion: nil)
//                     self.flag = true
//                 }
//             }
//         }
//     }
// }
