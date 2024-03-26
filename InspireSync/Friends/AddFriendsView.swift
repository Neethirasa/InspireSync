//
//  AddFriendsView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-18.
//

import SwiftUI
import FirebaseAuth

struct AddFriendsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    @State private var searchQuery = ""
    @State private var searchResults: [DBUser] = []
    @State private var currentUserDisplayName: String?
    @State private var showManageRequests: Bool = false
    
    // Dummy data for contacts, replace with your actual data source
    let contacts = ["Rishi", "Dhanu", "Mom", "Dad"]
    

    var body: some View {
        
        NavigationView {
            
            List {
                
                /*
                Text("Add Friends")
                    .font(.custom("Futura-Medium", fixedSize: 20))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .listRowBackground(Color.washedBlack)
                */
                
                TextField("Search by display name, case sensitive", text: $searchQuery, onCommit: {
                    Task {
                        do {
                            // Get the current user's data to exclude from search results
                            guard let currentUserData = try await UserManager.shared.getCurrentUserData() else { return }
                            
                            // Check if the search query matches the current user's display name
                            if searchQuery == currentUserData.displayName {
                                print("Cannot search for your own display name.")
                                self.searchResults = []
                                return
                            }
                            
                            // Perform the search
                            self.searchResults = try await UserManager.shared.searchUsers(byDisplayName: searchQuery)
                        } catch {
                            print("An error occurred: \(error)")
                        }
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .listRowBackground(Color.washedBlack)

                List(searchResults, id: \.userId) { user in
                    HStack {
                        Text(user.displayName)
                            .font(.custom("Futura-Medium", fixedSize: 16))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        
                        // Make the button a separate view to enhance tapability
                        AddFriendButton(user: user)
                        
                        /*
                        Button("Add Friend") {
                            Task {
                                guard let currentUserId = Auth.auth().currentUser?.uid else { return }
                                do {
                                    try await UserManager.shared.sendFriendRequest(fromUserId: currentUserId, toUserId: user.userId)
                                    // Handle success (e.g., show a confirmation message)
                                } catch {
                                    // Handle failure (e.g., show an error message)
                                }
                                
                                print(currentUserId)
                                print(user.userId)
                            }
                         
                        }
                        .padding(.horizontal, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        */
                    }
                    .listRowBackground(Color.washedBlack)
                }
                .listRowBackground(Color.washedBlack)
                .frame(height: UIScreen.main.bounds.height * 0.05)
                .listStyle(PlainListStyle())
                .background(Color.washedBlack)
                
                /*
                TextField("Search for friends", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .listRowBackground(Color.washedBlack)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 4))
                    .padding()

                    */
                
                Button(action: {
                    
                }, label: {
                    Text("Add from Contacts")
                        .foregroundStyle(.white)
                        .font(.custom(
                                "Futura-Medium",
                                size: 18))
                        .bold()
                })
                .padding(.vertical,5)
                .accentColor(.white)
                .listRowBackground(Color.washedBlack)


                ForEach(contacts, id: \.self) { contact in
                    Text(contact)
                        .foregroundStyle(.white)
                        .font(.custom(
                                "Futura-Medium",
                                size: 18))
                }
                .listRowBackground(Color.washedBlack)

            }
            
            .listStyle(PlainListStyle())
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar { // <2>
                                    ToolbarItem(placement: .principal) { // <3>
                              
                                            Text("Add Friends").font(.custom(
                                                "Futura-Medium",
                                                fixedSize: 18))
                                    }
                                }
                        .navigationBarItems(
                            leading: Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Home")
                                        .font(.custom("Futura-Medium", size: 18))
                                }
                            }
                            
                        )
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: { 
                                    showManageRequests.toggle()
                                }) {
                                    VStack {
                                        //Text("Requests")
                                        Image(systemName: "ellipsis.circle")
                                        
                                    }
                                }
                                .fullScreenCover(isPresented: $showManageRequests, content: {
                                    NavigationStack{
                                        ManageFriendRequestsView()
                                        
                                    }
                                })
                            }
                        }
            
            
                        .background(Color.washedBlack.edgesIgnoringSafeArea(.all))
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                }
}

struct AddFriendButton: View {
    var user: DBUser
    
    var body: some View {
        Button(action: {
            Task {
                guard let currentUserId = Auth.auth().currentUser?.uid else { return }
                do {
                    try await UserManager.shared.sendFriendRequest(fromUserId: currentUserId, toUserId: user.userId, fromUserDisplayName: AuthenticationManager.shared.getDisplayName())
                    print("Friend request sent to \(user.displayName)")
                } catch {
                    print("Failed to send friend request: \(error)")
                }
            }
        }) {
            Text("Add Friend")
                .padding(.horizontal, 10)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to enhance tapability within List
    }
}


struct AddFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendsView()
    }
}


