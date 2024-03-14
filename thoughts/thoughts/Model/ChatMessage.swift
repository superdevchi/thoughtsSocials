//
//  ChatMessage.swift
//  thoughts
//
//  Created by chibuike on 2024-03-04.
//

import Foundation

struct ChatMessage: Identifiable, Codable {
    
    var id: String { documentId }
    
    let documentId: String
    let FROMID, TOID, MESSAGE: String
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.FROMID = data["FROMID"] as? String ?? ""
        self.TOID = data["TOID"] as? String ?? ""
        self.MESSAGE = data["MESSAGE"] as? String ?? ""
        
    }
}

