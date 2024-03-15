//
//  WidgetCustom.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-15.
//

import SwiftUI

class TextFieldSettingsViewModel: ObservableObject {
    @Published var textFieldColor: Color = .black
    @Published var textColor: Color = .white
}

struct WidgetCustom: View {
        @Environment(\.dismiss) private var dismiss
        @StateObject var viewModel = TextFieldSettingsViewModel()
        @State private var sampleText: String = "Courage is not the absence of fear, but the triumph over it."
    
    @State var widgetColor: Color = .black
    @State var widgetTextColor: Color = .white

        var body: some View {
            ZStack {
                Color.washedBlack.edgesIgnoringSafeArea(.all)
                HStack(spacing: 0){
                    
                }
                .navigationBarBackButtonHidden(false)
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
                                            Text("Settings")
                                                .foregroundColor(.white)
                                                .font(.custom(
                                                        "Futura-Medium",
                                                        fixedSize: 20))
                                        }
                                    }
                                }
                            }
                
                VStack {
                    TextField("Sample Text", text: $sampleText, axis: .vertical)
                        .font(.custom("Futura-Medium", fixedSize: 18))
                        .frame(width: UIScreen.main.bounds.width * 0.76 , height: UIScreen.main.bounds.height * 0.18)
                        .cornerRadius(.infinity)
                        .lineLimit(4)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                        .background(viewModel.textFieldColor)
                        .foregroundColor(viewModel.textColor)
                    
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.1)
                    
                    HStack {
                        VStack{
                            ColorPicker("Choose Widget Color", selection: $viewModel.textFieldColor)
                                .font(.custom("Futura-Medium", fixedSize: 18))
                                .foregroundColor(.white)
                            
                            Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                            
                            ColorPicker("Choose Text Color", selection: $viewModel.textColor)
                                .font(.custom("Futura-Medium", fixedSize: 18))
                                .foregroundColor(.white)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.76)
                    }
                }
                
                VStack{
                    
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.7)
                    
                    HStack{
                        Button(role: .destructive){
                          dismiss()
                        }label: {
                        Text("Cancel")
                      }
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                    Spacer().frame(width: UIScreen.main.bounds.width * 0.45)
                        
                        Button(){
    
                            dismiss()
                            
                        }label: {
                        Text("Done")
                      }
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                    }

                }
                
            }
            .background(Color.washedBlack.ignoresSafeArea())
        }
}

#Preview {
    WidgetCustom(widgetColor: .black, widgetTextColor: .white)
}
