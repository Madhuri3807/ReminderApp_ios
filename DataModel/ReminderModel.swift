//
//  ReminderModel.swift
//  ReminderApp


import Foundation
class ReminderModel {
    var docID: String
    var email: String
    var title: String
    var date:  String
    var description: String
    
    
    init(docID: String,email: String,title:String,date: String, description: String) {
        self.docID = docID
        self.email = email
        self.title = title
        self.date = date
        self.description = description
    }
}

