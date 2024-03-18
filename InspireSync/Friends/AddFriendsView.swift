//
//  AddFriendsView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-18.
//

import SwiftUI

struct AddFriendsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    
    // Dummy data for contacts, replace with your actual data source
    let contacts = ["Rishi", "Dhanu", "Mom", "Dad"]
    

    var body: some View {
        NavigationView {
            List {
                TextField("Search for friends", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .listRowBackground(Color.washedBlack)
                    .padding()


                
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
            .navigationTitle("Add Friends")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                        .font(.custom(
                                "Futura-Medium",
                                size: 18))
                }
            })
            .background(Color.washedBlack.edgesIgnoringSafeArea(.all))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendsView()
    }
}


