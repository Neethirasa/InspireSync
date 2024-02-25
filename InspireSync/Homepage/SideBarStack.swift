//
//  SideBarStack.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-02-25.
//

import SwiftUI

struct SideBarStack: View {
    
    @Binding var isSidebarVisible: Bool
        var sideBarWidth = UIScreen.main.bounds.size.width * 0.5
        var bgColor: Color =
              Color(.init(
                      red: 52 / 255,
                      green: 70 / 255,
                      blue: 182 / 255,
                      alpha: 1))

        var body: some View {
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(.black.opacity(0.6))
                .opacity(isSidebarVisible ? 1 : 0)
                .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
                content
            }
            .edgesIgnoringSafeArea(.all)
        }

    var secondaryColor: Color =
                  Color(.init(
                    red: 100 / 255,
                    green: 174 / 255,
                    blue: 255 / 255,
                    alpha: 1))

    var content: some View {
        HStack(alignment: .top) {
            
            ZStack{
                
                VStack{
                    Spacer().frame(height: 50)
                    List {
                        
                        Button("Help"){
                            
                        }.listRowBackground(Color.washedBlack)
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))
                        
                        Button("About Us"){
                            
                        }.listRowBackground(Color.washedBlack)
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))

                    }
                    
                }
                
            }
            .frame(width: sideBarWidth)
            .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)

            Spacer()
        }
    }
/*
    var MenuChevron: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(bgColor)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: isSidebarVisible ? -18 : -10)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
            Image(systemName: "chevron.right")
                .foregroundColor(secondaryColor)
                .rotationEffect(
                  isSidebarVisible ?
                    Angle(degrees: 180) : Angle(degrees: 0))
                .offset(x: isSidebarVisible ? -4 : 8)
                .foregroundColor(.blue)
        }
        .offset(x: sideBarWidth / 2, y: 80)
        .animation(.default, value: isSidebarVisible)
    }
    */
    
}

#Preview {
    SideBarStack(isSidebarVisible: .constant(false))
}
