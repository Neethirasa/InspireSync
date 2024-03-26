//
//  tempSettingsScreen.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct tempSettingsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var isCustomWidget = false
    @State private var isShowingBugView = false
    @State private var isShowingPrivacyView = false
    @State private var isShowingTermsService = false
    let authUsername = AuthenticationManager.shared.getDisplayName()
    
    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    accountSection
                    customizationSection
                    feedbackSection
                    helpSection
                    deleteAccountButton
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { // <2>
                        ToolbarItem(placement: .principal) { // <3>
                  
                                Text("Settings").font(.headline)
                        }
                    }
            .navigationBarItems(leading: backButton)
            .background(Color("WashedBlack").edgesIgnoringSafeArea(.all))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var accountSection: some View {
        Section(header: Text("My Account").foregroundColor(.white).font(.headline)) {
            VStack(alignment: .leading, spacing: 0){
                
                
                HStack(spacing: 0){
                    Text("Username")
                    .foregroundColor(Color(hex: "#FFFFFF"))
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 14))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    //Spacer().frame(width: UIScreen.main.bounds.width * 0.51)
                    .overlay(alignment: .trailing) {
                        Text(authUsername)//take quotes off
                            .foregroundColor(Color.gray)
                            .font(.custom("Futura-Medium",fixedSize: 14))
                            .italic()
                        }
                    

                }
                
            }
            .padding(.vertical,10)
            .padding(.horizontal,5)
            .frame(minHeight: 20)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#333333"))
            .cornerRadius(5)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("DarkGray")))
    }
    
    var customizationSection: some View {
        Section(header: Text("Customize").foregroundColor(.white).font(.headline)) {
            VStack(alignment: .leading, spacing: 0){
                
                
                HStack(spacing: 0){
                    Button {
                        isCustomWidget.toggle()
                    } label: {
                        Text("Customize your Widget")
                        .foregroundColor(Color(hex: "#FFFFFF"))
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 14))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        //Spacer().frame(width: UIScreen.main.bounds.width * 0.51)
                        .overlay(alignment: .trailing) {
                            Image("arrow")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                                .contrast(10)
                            }
                    }
                    .sheet(isPresented: $isCustomWidget, content: {
                        WidgetCustom()
                    })

                    

                }
                
            }
            .padding(.vertical,10)
            .padding(.horizontal,5)
            .frame(minHeight: 20)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#333333"))
            .cornerRadius(5)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("DarkGray")))
    }
    
    var feedbackSection: some View {
        Section(header: Text("Send Feedback").foregroundColor(.white).font(.headline)) {
            Button("I spotted a bug") {
                isShowingBugView.toggle()
            }
            .sheet(isPresented: $isShowingBugView) {
                BugView()
            }
            Button("I have a suggestion") {
                // Action
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("DarkGray")))
    }
    
    var helpSection: some View {
        Section(header: Text("Help").foregroundColor(.white).font(.headline)) {
            Button("Privacy Policy") {
                isShowingPrivacyView.toggle()
            }
            .sheet(isPresented: $isShowingPrivacyView) {
                // PrivacyView
            }
            Button("Terms of Service") {
                isShowingTermsService.toggle()
            }
            .sheet(isPresented: $isShowingTermsService) {
                // TermsServiceView
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("DarkGray")))
    }
    
    var deleteAccountButton: some View {
        Button("Delete Account", role: .destructive) {
            // Delete account action
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    var backButton: some View {
        Button(action: { dismiss() }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.white)
        }
    }
}

struct tempSettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        tempSettingsScreen()
    }
}

