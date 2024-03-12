//
//  ProfileView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-15.
//

import SwiftUI
import Combine

@MainActor
final class ProfileViewModel: ObservableObject{
    
    @Published private(set) var user: DBUser? = nil

    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func addUserName() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        try await UserManager.shared.updateUserName(auth: authDataResult)
    }
}

struct ProfileView: View {
    @State private var username: String = ""
    @Binding var nullUsername: Bool
    @State private var showSignInView: Bool = false
    @StateObject private var viewModel = ProfileViewModel()
    
    
    
    let textLimit = 10 //Your limit
    var body: some View {
        ZStack{
            Color.washedBlack.ignoresSafeArea()
            VStack{
                VStack{
                    Text("Create an Account")
                        .foregroundStyle(.white)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 40))
                        .padding()
                }
                Spacer().frame(height:UIScreen.main.bounds.height * 0.05)
                
                VStack{
                    HStack{
                        Text("Username")
                            .foregroundStyle(.white)
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))
                        Spacer().frame(width: UIScreen.main.bounds.width * 0.45)
                    }
                    
                    TextField("Enter your username", text: $username) // <1>, <2>
                    .frame(width: UIScreen.main.bounds.width * 0.6 , height: UIScreen.main.bounds.height * 0.02)
                    .font(.custom("Futura-Medium", fixedSize: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 2))
                    .onReceive(Just($username)) { _ in limitText(textLimit)
                }
                    
                }
                
                Spacer().frame(height: 30)
                VStack{
                    Button(){
                        if !username.isEmpty && !username.trimmingCharacters(in: .whitespaces).isEmpty{
                            nullUsername = false
                            AuthenticationManager.shared.updateDisplayName(displayName: username)
                            do {
                                        // Call the throwing function here
                                try UserManager.shared.addUsername(name: username)
                                        // Return your view content
                                    } catch {
                                        // Handle the error here
                                        print("Error signing out: %@", error)
                                    }
                            
                        }
                        
                    }label: {
                    Text("Create Account")
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))
                            .foregroundColor(.white)
                            .padding()
                  }
                    .background(.customTeal)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 2))
                    .cornerRadius(10)
                }
                
            }
            
            
        }
        .background(.washedBlack)
        .scrollContentBackground(.hidden)
    
    }
    
    //Function to keep text length in limits
        func limitText(_ upper: Int) {
            if username.count > upper {
                username = String(username.prefix(upper))
            }
        }
}

#Preview {
    ProfileView(nullUsername: .constant(false))
}
