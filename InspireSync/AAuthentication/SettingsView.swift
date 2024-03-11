//
//  SettingsView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-11.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject{
    
    @Published var authProviders: [AuthProviderOption] = []
    
    
    func  loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders(){
            authProviders = providers
        }
    }
    
    func signOut() throws{
        AuthenticationManager.shared.signOut()
        
    }
    
    func deleteAccount() async throws{
        
        try await AuthenticationManager.shared.delete()
    }
    
    func resetPassword() async throws{
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws{
        let email = "hello123@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws{
        let password = "Hello123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    
    
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    //@Binding var showSignInView: Bool
    
    @State private var settingsView = false
    @State private var showSignInView = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack{
            Color.washedBlack.ignoresSafeArea()
            
            HStack{
                
                /*
                VStack{
                    
                    Spacer().frame(height: 25)
                    Text("Settings")
                        .font(.system(size: 30, weight: .heavy))
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 30))
                        .foregroundStyle(.white)
                    Spacer()
                     
                }
                 */
                     
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    //print("Settings")
                                    // 2
                                    dismiss()

                                } label: {
                                    HStack {
                                        Image(systemName: "chevron.backward")
                                            .foregroundColor(.white)
                                        Text("Settings")
                                            .foregroundColor(.white)
                                            .font(.custom(
                                                    "Futura-Medium",
                                                    fixedSize: 20))
                                    }
                                }
                            }
                        }
          
            
            VStack{
                //Spacer().frame(height: 50)
                List {
                    
                    Text("My Account")
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                    
                    
                    
                    
                    Button("Add Friend"){
                        
                    }.listRowBackground(Color.washedBlack)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                    
                    Button("Accept Requests"){
                        
                    }.listRowBackground(Color.washedBlack)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))

                    
                    Button("Block"){
                        
                    }.listRowBackground(Color.washedBlack)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))

                    
                    Button("Change Username"){
                        
                    }.listRowBackground(Color.washedBlack)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                    
                    
                    if viewModel.authProviders.contains(.email){
                        emailSection
                    }
                  
                }
                
                Button(role: .destructive){
                    Task{
                        do{
                            try viewModel.signOut()
                            showSignInView = true
                            
                        }catch{
                            print(error)
                        }
                    }
                }label: {
                Text("Delete Account")
              }
                
                .listRowBackground(Color.washedBlack)
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 20))
                
                Spacer().frame(height: 15)
                
                Button(role: .destructive){
                    Task{
                        do{
                            settingsView.toggle()
                            showSignInView = true
                            try viewModel.signOut()
                            
                        }catch{
                            print(error)
                        }
                    }
                    
                }label: {
                    Text("Log Out")
                  }
                .listRowBackground(Color.washedBlack)
                .font(.custom(
                        "Futura-Medium",
                        fixedSize: 20))
                
                .onAppear{
                    viewModel.loadAuthProviders()
                }
                .navigationBarTitle("")
                .fullScreenCover(isPresented: $showSignInView, content: {
                    NavigationStack{
                        AuthenticationView(showSignInView: $showSignInView)
                    }
                })
                Spacer().frame(height: 15)
                
            }
            
        }
        .background(.washedBlack)
        .scrollContentBackground(.hidden)
        }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}

extension SettingsView {
    
    private var emailSection: some View{
        
        Section {
            Button("Reset Password"){
                Task{
                    do{
                        try await viewModel.resetPassword()
                        print("PASSWORD RESET Successfully!")
                    }catch{
                        print(error)
                    }
                }
            }
            
        
        Button("Update Password"){
            Task{
                do{
                    try await viewModel.updatePassword()
                    print("PASSWORD UPDATED Successfully!")
                }catch{
                    print(error)
                }
            }
            
        }
        
        Button("Update Email"){
            Task{
                do{
                    try await viewModel.updateEmail()
                    print("EMAIL UPDATED Successfully!")
                }catch{
                    print(error)
                }
            }
        }
        } header: {
            Text("Email Functions")
        }

    }
}
