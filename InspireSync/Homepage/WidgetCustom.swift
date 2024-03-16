//
//  WidgetCustom.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-15.
//

import SwiftUI
import WidgetKit

class TextFieldSettingsViewModel: ObservableObject {
    @Published var textFieldColor: Color = .black {
        didSet {
            saveColor(textFieldColor, forKey: "textFieldColor")
        }
    }
    @Published var textColor: Color = .white {
        didSet {
            saveColor(textColor, forKey: "textColor")
        }
    }

    init() {
        loadSavedColors()
    }

    private func saveColor(_ color: Color, forKey key: String) {
        guard let defaults = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync") else { return }
        do {
            let uiColor = UIColor(color)
            let colorData = try NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
            defaults.set(colorData, forKey: key)
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            print("Failed to save color")
        }
    }

    func loadSavedColors() {
        textFieldColor = loadColor(forKey: "textFieldColor") ?? .black
        textColor = loadColor(forKey: "textColor") ?? .white
    }

     func loadColor(forKey key: String) -> Color? {
        guard let defaults = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync"),
              let colorData = defaults.data(forKey: key),
              let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) else { return nil }
        return Color(uiColor)
    }
}

struct WidgetCustom: View {
        @Environment(\.dismiss) private var dismiss
        @StateObject var viewModel = TextFieldSettingsViewModel()
        @State private var sampleText: String = "Courage is not the absence of fear, but the triumph over it."
    
    

        var body: some View {
            ZStack {
                Color("WashedBlack").edgesIgnoringSafeArea(.all)
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
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color("customTeal"), lineWidth: 5))
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
                            WidgetCenter.shared.reloadAllTimelines()
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
            .onAppear {
                    viewModel.loadSavedColors()
                    }
            .background(Color("WashedBlack").ignoresSafeArea())
        }
    
    
}

/*
 #Preview {
 WidgetCustom as! any View
 }
 */
