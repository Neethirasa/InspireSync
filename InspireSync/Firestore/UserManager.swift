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
    
    func userExists(auth: AuthDataResultModel) async throws -> Bool {
            // Get a reference to the user document in Firestore using the user's UID
            let userRef = Firestore.firestore().collection("users").document(auth.uid)
            
            do {
                // Attempt to get the document snapshot
                let documentSnapshot = try await userRef.getDocument()
                
                // Return true if the document exists, false otherwise
                return documentSnapshot.exists
            } catch {
                // If there's an error, print it and return false
                print("Error fetching user document: \(error)")
                return false
            }
        }
    
    func createNewUser(auth: AuthDataResultModel) async throws{
        
        let temp = "nil"
        
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "date_created" : Timestamp(),
            "displayName" : temp as Any
        ]
        
        if let email = auth.email{
            userData["email"] = email
        }
        
        if let photoUrl = auth.photoUrl{
            userData["photo_url"] = photoUrl
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getDisplayName(forUserID userID: String) async throws -> String? {
        // Attempt to get the user document from Firestore using the provided userID
        let userRef = Firestore.firestore().collection("users").document(userID)
        
        do {
            let documentSnapshot = try await userRef.getDocument()
            
            // Check if the document exists and has a displayName field
            if let data = documentSnapshot.data(), let displayName = data["displayName"] as? String {
                // Return the displayName if available
                return displayName
            } else {
                // If the document does not exist or does not have a displayName, return nil
                print("Document does not exist or does not have a displayName.")
                return nil
            }
        } catch {
            // If there's an error fetching the document, throw the error
            print("Error fetching user document: \(error)")
            throw error
        }
    }

    
    func displayNameExists(displayName: String) async throws -> Bool {
        // Create a query to find users with the given displayName
        let query = Firestore.firestore().collection("users").whereField("displayName", isEqualTo: displayName)
        
        do {
            // Fetch the documents matching the query
            let querySnapshot = try await query.getDocuments()
            
            // Return true if any documents are found, indicating that the displayName exists
            return !querySnapshot.isEmpty
        } catch {
            // Throw the error to be handled by the caller
            throw error
        }
    }

    
    func addUsername(name: String) throws {
        guard !name.isEmpty else {
            print("Username is empty. Not updating data.")
            return
        }
        
        let userName: [String:Any] = [
            "displayName" : name
        ]
        let uid = try AuthenticationManager.shared.getAuthenticatedUser().uid
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
    
    func isDisplayNameNil(forUserID userID: String) async throws -> Bool {
        // Check if the userID is "nil" or empty
        guard userID != "nil" && !userID.isEmpty else {
            // If the userID is "nil" or empty, return true
            return true
        }
        
        // If the userID is valid, proceed to fetch the user document
        let userRef = Firestore.firestore().collection("users").document(userID)
        
        do {
            let documentSnapshot = try await userRef.getDocument()
            guard let data = documentSnapshot.data(),
                  let displayName = data["displayName"] as? String else {
                // If displayName key doesn't exist or its value is not a String,
                // consider it as nil
                return true
            }
            return displayName == "nil"
        } catch {
            // Print and rethrow any errors that occur during the process
            print("Error fetching user document: \(error)")
            throw error
        }
    }


    
    
}
