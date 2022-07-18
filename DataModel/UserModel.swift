//
//  UserModel.swift
//  ReminderApp


import Foundation
class UserModel {
    var docID: String
    var name: String
    var email: String
    var password: String
    var phone: String
    
    
    init(docID: String,name: String,email: String,password:String, phone: String) {
        self.docID = docID
        self.email = email
        self.name = name
        self.password = password
        self.phone = phone
    }
}
