//
//  UserDetailsStruct.swift
//  thoughts
//
//  Created by chibuike on 2024-02-03.
//

import Foundation

struct UserDetailStruct: Identifiable, Codable {
    var id: String  {userID}
    
    let userName, email, firebaseID: String
    let profilePicture: String
    let userID: String
    
   
    
    init(data: [String:Any]) {
        self.userName = data["userName"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.firebaseID = data["firebaseID"] as? String ?? ""
        self.profilePicture = data["profilePicture"] as? String ?? ""
        self.userID = data["userID"] as? String ?? ""
    }
}
