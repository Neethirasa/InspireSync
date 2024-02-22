//
//  RootView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-11.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @State private var nullUsername: Bool = false
    
    var body: some View {
        
        ZStack{
            ZStack{
                if !showSignInView{
                    NavigationStack{
                        //SettingsView(showSignInView: $showSignInView)
                        HomeView(showSignInView: $showSignInView)
                    }
                }
            }
            .onAppear{
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                self.showSignInView = authUser == nil
            }
            .fullScreenCover(isPresented: $showSignInView, content: {
                NavigationStack{
                    AuthenticationView(showSignInView: $showSignInView)
                }
            })
        }
        .onAppear{
            let authUsername = try? AuthenticationManager.shared.getAuthenticatedUser().username
            if authUsername == ""{
                self.nullUsername = false
            }
            self.nullUsername = authUsername == nil
        }
        .fullScreenCover(isPresented: $nullUsername, content: {
            NavigationStack{
                ProfileView(nullUsername: $nullUsername)
            }
        })
    }
}



#Preview {
    RootView()
}
