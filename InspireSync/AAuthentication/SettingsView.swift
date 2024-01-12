//
//  SettingsView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-11.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject{
    
    
    func logOut() throws{
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSingInView: Bool
    
    var body: some View {
        List {
            Button("Log out"){
                do{
                    try viewModel.logOut()
                    showSingInView = true
                }catch{
                    print(error)
                }
                
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(showSingInView: .constant(false))
        }
    }
}
