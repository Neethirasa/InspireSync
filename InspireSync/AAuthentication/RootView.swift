//
//  RootView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-11.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
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
}

#Preview {
    RootView()
}
