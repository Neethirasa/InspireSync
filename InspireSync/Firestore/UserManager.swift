//
//  UserManager.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-10.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser{
    let userId: String
    let displayName: String
    let email: String?
    let dateCreated: Date?
    
}


final class UserManager{
    
    
    static let shared = UserManager()
    private init() {}
    
    func createNewUser(auth: AuthDataResultModel) async throws{
        
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "date_created" : Timestamp(),
            "displayName" : auth.displayName as Any
        ]
        
        if let email = auth.email{
            userData["email"] = email
        }
        
        if let photoUrl = auth.photoUrl{
            userData["photo_url"] = photoUrl
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func updateUserName(auth: AuthDataResultModel) async throws{
        var userName: [String:Any] = [
            "displayName" : auth.displayName as Any
        ]
        let userRef = Firestore.firestore().collection("users").document(auth.uid)
        
        userRef.updateData(userName) { error in
            if let error = error {
                print("Failed to update data: \(error.localizedDescription)")
            } else {
                print("Data updated successfully!")
            }
        }
    }
    
    func addUsername(name: String) throws{
        var userName: [String:Any] = [
            "displayName" : name
        ]
        var uid = try AuthenticationManager.shared.getAuthenticatedUser().uid
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        userRef.updateData(userName) { error in
            if let error = error {
                print("Failed to update data: \(error.localizedDescription)")
            } else {
                print("Data updated successfully!")
            }
        }
    }
    
    func getUser(userId: String) async throws -> DBUser{
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String, let displayName = data["displayName"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let email = data["email"] as? String
        let dateCreated = data["date_created"] as? Date
        
        return DBUser(userId: userId, displayName: displayName, email: email, dateCreated: dateCreated)
        
    }
    
    
}
