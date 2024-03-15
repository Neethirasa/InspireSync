//
//  ContentView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-11.
//

import SwiftUI
import UIKit
import AuthenticationServices
import CryptoKit
import GoogleSignIn
import GoogleSignInSwift
import KeychainSwift
import FirebaseAuth

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    let signInAppleHelper = SignInAppleHelper()
    static let shared = AuthenticationViewModel()
    private let keychain = KeychainSwift()
        
    init() { }
    
    
    func signInApple() async throws {
        
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        
        // Check if the user already exists
                let userExists = try await UserManager.shared.userExists(auth: authDataResult)
                
                // If the user doesn't exist, create a new user
                if !userExists {
                    try await UserManager.shared.createNewUser(auth: authDataResult)
                    // Call this right after a successful sign-in
                    KeychainService.shared.storeOriginalUserID(Auth.auth().currentUser?.uid ?? "")
                }
            
    }
    
    func signInAppleReauth() async throws {
        
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
            
    }
    
    
    func signInGoogle() async throws {
        
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        
        // Check if the user already exists
                let userExists = try await UserManager.shared.userExists(auth: authDataResult)
                
                // If the user doesn't exist, create a new user
                if !userExists {
                    try await UserManager.shared.createNewUser(auth: authDataResult)
                    // Call this right after a successful sign-in
                    KeychainService.shared.storeOriginalUserID(Auth.auth().currentUser?.uid ?? "")
                }
            
    }
    
    func signInGoogleReauth() async throws {
        
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
            
    }
    
}
  

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    
    var body: some View {
        
        
        ZStack{
            
            Color.washedBlack.ignoresSafeArea()
            
            VStack() {
                Spacer().frame(height: UIScreen.main.bounds.height * 0.06)
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Image("name")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 100)

                
                
                
                
                /*
                 NavigationLink{
                 SignInEmailView(showSignInView: $showSignInView)
                 } label: {
                 Text("Sign In With Email")
                 .font(.headline)
                 .foregroundColor(.white)
                 .frame(height: 55)
                 .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                 .background(Color.blue)
                 .cornerRadius(10)
                 
                 }
                 */
                
            }
            .padding(20)
            .safeAreaInset(edge: VerticalEdge.bottom){
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
                    Task{
                        do {
                            try await viewModel.signInGoogle()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                }
                
                .padding()
                .offset(y:75)
                
            }
            
            .safeAreaInset(edge: VerticalEdge.bottom, content: {
                Button(action: {
                    Task{
                        do {
                            try await viewModel.signInApple()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                }, label: {
                    SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                        .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                })
                .frame(height: UIScreen.main.bounds.height * 0.055)
                .frame(width: UIScreen.main.bounds.width * 0.85)
                .offset(y:75)
            })
            .padding()
            .navigationTitle("")
        }
        
    }
    
    
    
    
    
    
    
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }
        
    }
}

extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let newPrimaryColor = Color("lightBlue")
    
    static let newBlack = Color("WashedBlack")
    
    static let newBlueColor = Color("DarkBlue")
    
    static let newTealColor = Color("customTeal")
    
    static let newSettingsColor = Color("SettingsColor")
    
}
