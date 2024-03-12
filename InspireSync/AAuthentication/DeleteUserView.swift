//
//  DeleteUserView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-04.
//

import SwiftUI
import UIKit
import AuthenticationServices
import CryptoKit
import GoogleSignIn
import GoogleSignInSwift
import FirebaseFirestore
import FirebaseFirestoreSwift


struct DeleteUserView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showDeleteView: Bool
    @State private var showSignInView: Bool = false
    
    @State private var deleteView = false
    
    @StateObject private var viewModelSetting = SettingsViewModel()
    
    
    var body: some View {
        
        
        ZStack{
            
            Color.washedBlack.ignoresSafeArea()
            
            
            VStack() {
                
                
                
                VStack{
                    HStack(spacing: 0){
                        
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
                                                Text("Cancel")
                                                    .foregroundColor(.white)
                                                    .font(.custom(
                                                            "Futura-Medium",
                                                            fixedSize: 20))
                                            }
                                        }
                                    }
                                }
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.15)
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    
                    Text("InspireSync")
                        .padding()
                        .foregroundColor(.newPrimaryColor)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 47))
                    
                    Text("Sign in Again to Delete Account")
                        .foregroundColor(.red)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 18))
                    
                    
                        .safeAreaInset(edge: VerticalEdge.bottom){
                        
                        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
                            Task{
                                do {
                                    try await viewModel.signInGoogle()
                                    showDeleteView = false
                                    // Delete user data from Firestore
                                    try await Firestore.firestore().collection("users").document(AuthenticationManager.shared.getAuthenticatedUser().uid).delete()
                                    
                                    try await viewModelSetting.deleteAccount()
                                    // Present the RootView
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                        let window = windowScene.windows.first {
                                                    window.rootViewController = UIHostingController(rootView: RootView())
                                                }
                                } catch {
                                    print(error)
                                }
                            }
                        }
                        
                        .padding()
                        .offset(y:75)
                        
                    }
                    
                    /*
                     NavigationStack{
                         Button(action: {
                             settingsView.toggle()
                         }, label: {
                             Text("Settings")
                                 .font(.custom(
                                     "Futura-Medium",
                                     fixedSize: 20))
                                 .foregroundColor(.white)
                         })
                         .fullScreenCover(isPresented: $settingsView, content: {
                             NavigationStack{
                                 SettingsScreen()
                             }
                         })
                     }
                     */
                    .safeAreaInset(edge: VerticalEdge.bottom, content: {
                        NavigationStack{
                            Button(action: {
                                Task{
                                    do {
                                        try await viewModel.signInApple()
                                        showDeleteView = false
                                        // Delete user data from Firestore
                                        try await Firestore.firestore().collection("users").document(AuthenticationManager.shared.getAuthenticatedUser().uid).delete()
                                        try await viewModelSetting.deleteAccount()
                                        
                                        deleteView.toggle()
                                        // Present the RootView
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                            let window = windowScene.windows.first {
                                                        window.rootViewController = UIHostingController(rootView: RootView())
                                                    }
                                        
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
                            .fullScreenCover(isPresented: $deleteView, content: {
                                NavigationStack{
                                    RootView()
                                }
                            })
                        }
                    })
                    .padding()
                    .navigationTitle("")
                    
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                }
                
                
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
            //.padding(UIScreen.main.bounds.height * 0.01)
        }        
        
    }
}


#Preview {
    DeleteUserView(showDeleteView: .constant(true))
}
