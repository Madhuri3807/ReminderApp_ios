//
//  AddReminderVC.swift
//  ReminderApp
//
//

import UIKit
import MaterialComponents


class AddReminderVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtTitle: UIView!

    @IBOutlet weak var txtNotes: UIView!
    
    //MARK: Class Variable
    var selectedDate = ""
    var textField = MDCOutlinedTextField()
    var textArea = MDCOutlinedTextArea()
    
    
    //MARK: Custom Method
    
    func setUpView(){
        self.applyStyle()
    }
    
    func applyStyle(){
        let estimatedFrame = self.txtTitle.bounds
        self.textField = MDCOutlinedTextField(frame: estimatedFrame)
        self.textField.label.text = "Title"
        self.textField.placeholder = "Enter title"
        self.textField.setFloatingLabelColor(UIColor.hexStringToUIColor(hex: "#735fa6"), for: .editing)
        self.textField.sizeToFit()
        txtTitle.addSubview(self.textField)
        
        let estimatedFrameTV = self.txtNotes.bounds
        self.textArea = MDCOutlinedTextArea(frame: estimatedFrameTV)
        self.textArea.setFloatingLabel(UIColor.hexStringToUIColor(hex: "#735fa6"), for: .editing)
        self.textArea.placeholder = "Enter notes"
        self.textArea.label.text = "Notes"
        self.textArea.textView.text = ""
        self.textArea.sizeToFit()
        txtNotes.addSubview(self.textArea)
    }
    
    func validation(date: String, title: String, description: String) -> String {
        if date.isEmpty {
            return "Please select reminder date"
        }else if title.isEmpty {
            return "Please enter title"
        }else if description.isEmpty {
            return "Please enter description"
        }
        return ""
    }
    
    //MARK: Action Method
    
    @IBAction func btnSelectDateTapped(_ sender: Any) {
        let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "SelectDateVC") as! SelectDateVC
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.selectionCompletion = { selectedDate in
            self.selectedDate =  selectedDate.strChangeDateFormat(fromDateFormat: DateTimeFormater.yyyymmdd.rawValue, toDateFormat: DateTimeFormater.ddmmyyyyWithoutSpace.rawValue, type: .noconversion) ?? ""
            self.lblDate.text = selectedDate
        }
        self.present(nextVC, animated: true)
    }
    
    @IBAction func btnBackTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddReminderTapped(sender: UIButton) {
        let error = self.validation(date: self.selectedDate, title: self.textField.text ?? "", description: self.textArea.description)
        
        if error.isEmpty {
            self.addReminder(date: self.selectedDate, title: self.textField.text ?? "", description: self.textArea.textView.text, email: GFunction.user.email)
        }else{
            Alert.shared.showAlert(message: error, completion: nil)
        }
    }
    
    //MARK: Delegates
    
    //MARK: UILifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    deinit {
        debugPrint("‼️‼️‼️ deinit : \(self) ‼️‼️‼️")
    }
    
    
    func addReminder(date: String, title: String, description: String,email:String) {
        var ref : DocumentReference? = nil
        ref = AppDelegate.shared.db.collection(rReminder).addDocument(data:
                                                                    [
                                                                        rEmail: email,
                                                                        rTitle: title,
                                                                        rDescription : description,
                                                                        rDate: date
                                                                    ])
        {  err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
