//
//  ManageFriendRequestsView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-18.
//

import SwiftUI
import FirebaseAuth

struct ManageFriendRequestsView: View {
    @State private var friendRequests: [FriendRequest] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color("WashedBlack").edgesIgnoringSafeArea(.all)
            
            // Check if friend requests are empty to show a message
            if friendRequests.isEmpty {
                Text("You have no friend requests.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Use ScrollView to ensure the background color fills the entire view
                ScrollView {
                    LazyVStack {
                        ForEach(friendRequests) { request in
                            friendRequestRow(for: request)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Friend Requests")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                        .font(.custom("Futura-Medium", size: 18))
                }
            },
            trailing: Button(action: { Task { await refreshFriendRequests() } }) {
                Image(systemName: "arrow.clockwise")
            }
        )
        .onAppear {
            Task {
                await refreshFriendRequests()
            }
        }
        .background(Color("WashedBlack")) // Apply background color to the entire view
    }

    private func friendRequestRow(for request: FriendRequest) -> some View {
        VStack(alignment: .leading) {
            Text(request.fromUserDisplayName ?? "Unknown User")
                .foregroundColor(.white) // Adjust text color for visibility
            
            HStack {
                Button("Accept") {
                    Task {
                        do {
                            try await UserManager.shared.acceptFriendRequest(fromUserId: request.fromUserId, toUserId: Auth.auth().currentUser?.uid ?? "")
                            await refreshFriendRequests()
                        } catch {
                            print("Error accepting friend request: \(error)")
                        }
                    }
                }
                .foregroundColor(.green)
                
                Button("Decline") {
                    Task {
                        do {
                            try await UserManager.shared.declineFriendRequest(fromUserId: request.fromUserId, toUserId: Auth.auth().currentUser?.uid ?? "")
                            await refreshFriendRequests()
                        } catch {
                            print("Failed to decline friend request: \(error)")
                        }
                    }
                }
                .foregroundColor(.red)
                
                Spacer().frame(width: UIScreen.main.bounds.width * 0.5 )
            }
            
            
        }
        .padding()
        .background(Color("WashedBlack")) // Ensure each row has the correct background
        .cornerRadius(10)
    }

    private func refreshFriendRequests() async {
        do {
            self.friendRequests = try await UserManager.shared.fetchIncomingFriendRequests()
        } catch {
            print("Error fetching friend requests: \(error)")
        }
    }
}

// Make sure to replace "FriendRequest" struct definition with your actual FriendRequest model
// Also ensure that UserManager's functions are correctly implemented to fetch, accept, and decline friend requests

struct ManageFriendRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageFriendRequestsView()
    }
}

