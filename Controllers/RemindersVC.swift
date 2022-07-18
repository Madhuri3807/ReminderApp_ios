//
//  RemindersVC.swift
//  ReminderApp
//
//

import UIKit
class RemindersTVC: UITableViewCell {
    //MARK: Outlet
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var lblDayValue: UILabel!
    @IBOutlet weak var lblMonthAndYearValue: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    //MARK: Class Variable
    
    //MARK: Custom Method
    
    func setUpView(){
        self.applyStyle()
    }
    
    func applyStyle(){
        self.vwBack.layer.cornerRadius = 12
        self.vwBack.shadow()
        
        self.lblDayValue.font = UIFont.customFont(ofType: .bold, withSize: 44)
        self.lblDayValue.textColor = UIColor.hexStringToUIColor(hex: "#6d579f")
        self.lblMonthAndYearValue.font = UIFont.customFont(ofType: .semiBold, withSize: 14)
        self.lblTitle.font = UIFont.customFont(ofType: .bold, withSize: 18)
        self.lblDescription.font = UIFont.customFont(ofType: .regular, withSize: 16)
        self.lblDescription.textColor = UIColor.gray
    }
    
    //MARK: Action Method
    func configCell(data: ReminderModel) {
        self.lblTitle.text = data.title.description
        self.lblDescription.text = data.description.description
        self.lblDayValue.text = data.date.dropLast(8).description
        self.lblMonthAndYearValue.text = GFunction.shared.getDate(date: data.date)?.dateFormattedReminder
    }
    //MARK: Delegates
    
    //MARK: UILifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    deinit {
        debugPrint("‼️‼️‼️ deinit : \(self) ‼️‼️‼️")
    }
    
}

class RemindersVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var tblReminders: UITableView!
    
    //MARK: Class Variable
    var array = [ReminderModel]()
    
    
    //MARK: Custom Method
    
    func setUpView(){
        self.applyStyle()
        
//        self.tblReminders.delegate = self
//        self.tblReminders.dataSource = self
    }
    
    func applyStyle(){
        
    }
    
    //MARK: Action Method
    
    //MARK: Delegates
    
    //MARK: UILifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.getData()
        self.navigationController?.navigationBar.isHidden = true
    }
    deinit {
        debugPrint("‼️‼️‼️ deinit : \(self) ‼️‼️‼️")
    }

}

extension RemindersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemindersTVC") as! RemindersTVC
        cell.configCell(data: self.array[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
    func getData(){
        _ = AppDelegate.shared.db.collection(rReminder).whereField(rEmail, isEqualTo: GFunction.user.email).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.array.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[rTitle] as? String, let email: String = data1[rEmail] as? String, let date: String = data1[rDate] as? String, let description: String = data1[rDescription] as? String {
                        print("Data Count : \(self.array.count)")
                        self.array.append(ReminderModel(docID: data.documentID, email: email, title: name, date: date, description: description))
                    }
                }
                
                self.tblReminders.delegate = self
                self.tblReminders.dataSource = self
                self.tblReminders.reloadData()
            }else{
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
    }
    
}


//Bold Title Lable
class NavTitleLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont.customFont(ofType: .semiBold, withSize: 32)
        self.textColor = UIColor.hexStringToUIColor(hex: "#1F1F1F")
    }
}
