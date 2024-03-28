//
//  UserManager.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-10.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct DBUser: Codable {
    var userId: String
    var displayName: String
    var normalizedDisplayName: String
    var email: String?
    var dateCreated: Date?
    
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case displayName
        case normalizedDisplayName
        case email
        case dateCreated = "date_created"
    }
    
    // Firestore's Codable support handles the encoding/decoding, so you don't need a custom init/from decoder method unless you're doing something special
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
            "normalizedDisplayName" : temp as Any,
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
        let normalizedDisplayName = displayName.lowercased()
        let query = Firestore.firestore().collection("users").whereField("normalizedDisplayName", isEqualTo: normalizedDisplayName)
        
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

    
    func addUsername(name: String) async throws {
        guard !name.isEmpty else {
            print("Username is empty. Not updating data.")
            return
        }
        let normalizedDisplayName = name.lowercased()
        let userName: [String:Any] = [
            "displayName" : name,
            "normalizedDisplayName": normalizedDisplayName
        ]
        let uid = try AuthenticationManager.shared.getAuthenticatedUser().uid
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        try await userRef.updateData(userName)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let documentReference = Firestore.firestore().collection("users").document(userId)
        let documentSnapshot = try await documentReference.getDocument()
        
        // Decode the documentSnapshot directly into a DBUser instance
        guard let user = try? documentSnapshot.data(as: DBUser.self) else {
            throw NSError(domain: "App", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to decode DBUser"])
        }
        
        return user
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
    
    // Search for users by displayName
        func searchUsers(byDisplayName normalizedDisplayName: String) async throws -> [DBUser] {
            let querySnapshot = try await Firestore.firestore()
                .collection("users")
                .whereField("normalizedDisplayName", isEqualTo: normalizedDisplayName)
                .getDocuments()

            let users = querySnapshot.documents.compactMap { document -> DBUser? in
                try? document.data(as: DBUser.self)
            }
            return users
        }
    
    // Search for users by displayName and return the first userId found
    func searchUsersReturnUid(byDisplayName normalizedDisplayName: String) async throws -> String? {
        let querySnapshot = try await Firestore.firestore()
            .collection("users")
            .whereField("normalizedDisplayName", isEqualTo: normalizedDisplayName)
            .getDocuments()

        // Attempt to find the first document that matches the query and return its userId
        let firstUserId = querySnapshot.documents.compactMap { document -> String? in
            guard let user = try? document.data(as: DBUser.self) else {
                return nil
            }
            return user.userId
        }.first
        
        return firstUserId
    }

    func sendFriendRequest(fromUserId: String, toUserId: String, fromUserDisplayName: String) async throws {
        let friendRequestData: [String: Any] = [
            "fromUserId": fromUserId,
            "toUserId": toUserId,
            "fromUserDisplayName": fromUserDisplayName,
            "status": "pending",
            "timestamp": FieldValue.serverTimestamp()
        ]

        // Set data for the receiver's friend requests collection
        let receiverRequestRef = Firestore.firestore().collection("users").document(toUserId).collection("receivedFriendRequests").document(fromUserId)
        try await receiverRequestRef.setData(friendRequestData)
                // Optionally, track the sent request in the sender's subcollection as well
        let senderRequestRef = Firestore.firestore().collection("users").document(fromUserId).collection("sentFriendRequests").document(toUserId)
        try await senderRequestRef.setData(["status": "pending", "timestamp": FieldValue.serverTimestamp()])
    }
    
    // Checks if there's a pending friend request from `fromUserId` to `toUserId`
        func isFriendRequestPending(fromUserId: String, toUserId: String) async throws -> Bool {
            // Access the collection where friend requests are stored
            let sentRequestRef = Firestore.firestore().collection("users").document(fromUserId).collection("sentFriendRequests").document(toUserId)

            // Attempt to get the document for the friend request
            let documentSnapshot = try await sentRequestRef.getDocument()

            // Check if the document exists and if the status is "pending"
            if let data = documentSnapshot.data(), let status = data["status"] as? String, status == "pending" {
                // If the document exists and status is pending, return true
                return true
            } else {
                // If no document exists or status is not pending, return false
                return false
            }
        }


    func fetchIncomingFriendRequests() async throws -> [FriendRequest] {
            let currentUserId = try AuthenticationManager.shared.getAuthenticatedUser().uid
            
            let querySnapshot = try await Firestore.firestore()
                .collection("users")
                .document(currentUserId)
                .collection("receivedFriendRequests")
                .whereField("status", isEqualTo: "pending")
                .getDocuments()

            let friendRequests = querySnapshot.documents.compactMap { document -> FriendRequest? in
                try? document.data(as: FriendRequest.self)
            }
            return friendRequests
        }

    func acceptFriendRequest(fromUserId: String, toUserId: String) async throws {
        // Update friendRequests subcollection
        let friendRequestRef = Firestore.firestore()
            .collection("users")
            .document(toUserId)
            .collection("receivedFriendRequests")
            .document(fromUserId)
        
        // Add the friend request document
           try await friendRequestRef.setData([
               "fromUserId": fromUserId,
               "status": "pending",
               "timestamp": Timestamp()
           ])
        
        try await friendRequestRef.updateData(["status": "accepted"])
        
        // Add each other to friends subcollection
        let toUserFriendsRef = Firestore.firestore()
            .collection("users")
            .document(toUserId)
            .collection("friends")
            .document(fromUserId)
        try await toUserFriendsRef.setData(["friendUserId": fromUserId])
        
        let fromUserFriendsRef = Firestore.firestore()
            .collection("users")
            .document(fromUserId)
            .collection("friends")
            .document(toUserId)
        try await fromUserFriendsRef.setData(["friendUserId": toUserId])
    }
    
    // Function to check the status of a friend request
        func checkFriendRequestStatus(fromUserId: String, toUserId: String) async throws -> String {
            let requestRef = Firestore.firestore().collection("users").document(toUserId).collection("receivedFriendRequests").document(fromUserId)
            let snapshot = try await requestRef.getDocument()
            return snapshot.data()?["status"] as? String ?? "none"
        }
    
    
    // This method retrieves the current user's display name.
    func getCurrentUserData() async throws -> DBUser? {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return nil }

        return try await getUser(userId: currentUserId)
    }
    
    // Declines a friend request and removes it from both users' collections
    func declineFriendRequest(fromUserId: String, toUserId: String) async throws {
        // Reference to the receiver's 'receivedFriendRequests' document for this friend request
        let receiverRequestRef = Firestore.firestore()
            .collection("users")
            .document(toUserId)
            .collection("receivedFriendRequests")
            .document(fromUserId)
        
        // Reference to the sender's 'sentFriendRequests' document for this friend request
        let senderRequestRef = Firestore.firestore()
            .collection("users")
            .document(fromUserId)
            .collection("sentFriendRequests")
            .document(toUserId)
        
        do {
            // Create a write batch to perform both operations atomically
            let batch = Firestore.firestore().batch()
            
            // Delete the request from the receiver's 'receivedFriendRequests' collection
            batch.deleteDocument(receiverRequestRef)
            
            // Delete the request from the sender's 'sentFriendRequests' collection
            batch.deleteDocument(senderRequestRef)
            
            // Commit the batch
            try await batch.commit()
        } catch let error {
            // Handle any errors that occur during the batch commit
            print("Error declining friend request: \(error)")
            throw error
        }
    }



}



