//
//  testView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-02-25.
//

import SwiftUI

struct SideView: View {
    @State private var isSideBarOpened = false
    
    var body: some View {
        ZStack{
            NavigationView{
                HomeView()
                    .toolbar {
                        VStack{
                            Button {
                                isSideBarOpened.toggle()
                            } label: {
                                Image("menuIcon")
                                    .font(.system(size: 40))
                                    .foregroundColor(.customTeal)
                            }
                        }
                        .listStyle(.inset)
                        
                        Spacer().frame(width: 300)
                        }
                                      //.navigationTitle("Home")
                                      //.navigationBarTitleDisplayMode(.inline)
            }
            SideBarStack(isSidebarVisible: $isSideBarOpened)
        }
    }
}

#Preview {
    SideView()
}
