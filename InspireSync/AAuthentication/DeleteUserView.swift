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
import FirebaseAuth

struct DeleteUserView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showDeleteView: Bool
    @State private var showSignInView: Bool = false
    @State private var deleteView = false
    @State private var showDifferentSignInAlert = false
    @State private var showIncorrectUserAlert = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @StateObject private var viewModelSetting = SettingsViewModel()
    
    var body: some View {
        ZStack{
            Color.washedBlack.ignoresSafeArea()
            VStack {
                HStack(spacing: 0) {}
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.white)
                                Text("Cancel")
                                    .foregroundColor(.white)
                                    .font(.custom("Futura-Medium", fixedSize: 20))
                            }
                        }
                    }
                }
                Spacer().frame(height: UIScreen.main.bounds.height * 0.15)
                Spacer().frame(height: UIScreen.main.bounds.height * 0.06)
                Image("Logo").resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150)
                Image("name").resizable().aspectRatio(contentMode: .fill).frame(width: 250, height: 100)
                Text("Sign in Again to Delete Account").foregroundColor(.red).font(.custom("Futura-Medium", fixedSize: 18))
                
                
                NavigationStack{
                    Button(action: {
                        checkUserBeforeDeletion()
                        attemptDeleteWithApple()
                    }, label: {
                        SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                            .allowsHitTesting(true)
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
                .padding(5)
                
                CustomGoogleSignInButton{
                    checkUserBeforeDeletion()
                    attemptDeleteWithGoogle()
                }
                .padding()
                .offset(y:75)
                
                Spacer().frame(height: UIScreen.main.bounds.height * 0.11)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                // Optionally reset state or navigate away
                self.dismiss()
            })
        }
    }
        
    
    private func checkUserBeforeDeletion() {
            let currentUserId = Auth.auth().currentUser?.uid ?? ""
            let originalUserId = KeychainService.shared.getOriginalUserID() ?? ""
            
            if currentUserId != originalUserId {
                // If the current user ID does not match the original user ID, show an alert and cancel the view
                alertMessage = "The current user does not match the account owner. Account deletion has been cancelled."
                showAlert = true
            } else {
                // Proceed with deletion or further action as the user is verified
                // For example, deleteUserAccount()
            }
        }

    private func attemptDeleteWithGoogle() {
        Task {
            do {
                let isCorrectMethod = try await isCorrectSignInMethod(method: .google)
                guard isCorrectMethod else {
                    alertMessage = "The current user does not match the account owner. Account deletion has been cancelled."
                    showAlert = true
                    return
                }
                
                try await viewModel.signInGoogleReauth()
                await deleteUserAccount()
            } catch {
                alertMessage = "The current user does not match the account owner. Account deletion has been cancelled."
                showAlert = true
            }
        }
    }

    private func attemptDeleteWithApple() {
        Task {
            do {
                let isCorrectMethod = try await isCorrectSignInMethod(method: .apple)
                guard isCorrectMethod else {
                    alertMessage = "The current user does not match the account owner. Account deletion has been cancelled."
                    showAlert = true
                    return
                }
                
                try await viewModel.signInAppleReauth()
                await deleteUserAccount()
            } catch {
                alertMessage = "The current user does not match the account owner. Account deletion has been cancelled."
                showAlert = true
            }
        }
    }

    private func deleteUserAccount() async {
        do {
            // Delete user data from Firestore
            try await Firestore.firestore().collection("users").document(AuthenticationManager.shared.getAuthenticatedUser().uid).delete()
            try await AuthenticationManager.shared.delete()
            dismiss()
        } catch {
            showDifferentSignInAlert = true
        }
    }
    
    private func isCorrectSignInMethod(method: AuthProviderOption) async throws -> Bool {
        let currentProviders = try await AuthenticationManager.shared.getProviders()
        return currentProviders.contains(method)
    }
}



#Preview {
    DeleteUserView(showDeleteView: .constant(true))
}
