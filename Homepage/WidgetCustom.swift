//
//  WidgetCustom.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-15.
//

import SwiftUI
import WidgetKit
import UIKit

class TextFieldSettingsViewModel: ObservableObject {
    @Published var textFieldColor: Color = .black {
        didSet { saveColor(textFieldColor, forKey: "textFieldColor") }
    }
    @Published var textColor: Color = .white {
        didSet { saveColor(textColor, forKey: "textColor") }
    }
    @Published var selectedFont: String = "System" {
        didSet { saveFontSelection(fontName: selectedFont) }
    }
    
    @Published var selectedFontSize: CGFloat = 14 {
            didSet { saveFontSizeSelection(fontSize: selectedFontSize) }
        }

    init() {
        loadSavedColors()
        loadSavedFont()
        loadSavedFontSize()
    }
    
    private func saveFontSizeSelection(fontSize: CGFloat) {
            UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")?.set(Double(fontSize), forKey: "selectedFontSize")
        }

        private func loadSavedFontSize() {
            if let savedFontSize = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")?.double(forKey: "selectedFontSize") {
                selectedFontSize = CGFloat(savedFontSize)
            }
        }

    private func saveColor(_ color: Color, forKey key: String) {
        guard let defaults = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync") else { return }
        do {
            let uiColor = UIColor(color)
            let colorData = try NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
            defaults.set(colorData, forKey: key)
        } catch {
            print("Failed to save color")
        }
    }

    private func saveFontSelection(fontName: String) {
        UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")?.set(fontName, forKey: "selectedFont")
    }

    func loadSavedColors() {
        textFieldColor = loadColor(forKey: "textFieldColor") ?? .black
        textColor = loadColor(forKey: "textColor") ?? .white
    }
    
    func loadSavedFont() {
        if let savedFont = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")?.string(forKey: "selectedFont") {
            selectedFont = savedFont
        }
    }

    private func loadColor(forKey key: String) -> Color? {
        guard let defaults = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync"),
              let colorData = defaults.data(forKey: key),
              let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) else { return nil }
        return Color(uiColor)
    }
}

struct WidgetCustom: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = TextFieldSettingsViewModel()
    @State private var sampleText: String = "Success is not measured by what you accomplish, but by the obstacles you overcome."
    
    let fonts = ["Futura-Medium", "San Francisco",
                 "Helvetica Neue",
                 "Arial",
                 "Times New Roman",
                 "Courier New",
                 "Georgia",
                 "Trebuchet MS",
                 "Verdana",
                 "Gill Sans",
                 "Avenir Next",
                     "Baskerville",
                     "Didot",
                     "American Typewriter",
                     "Chalkboard SE"] // Ensure these fonts are available

    var body: some View {
        ZStack {
            Color("WashedBlack").edgesIgnoringSafeArea(.all) // Background for the entire view
            
            VStack {
                Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                
                TextField("Sample", text: $sampleText, axis: .vertical)
                    .multilineTextAlignment(.center)
                    .font(.custom(viewModel.selectedFont, fixedSize: viewModel.selectedFontSize))
                    .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.18)
                    .cornerRadius(10)
                    .padding()
                    .background(viewModel.textFieldColor) // Apply background color
                    .foregroundColor(viewModel.textColor)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 5))

                // Place the Form in a separate ZStack layer with the desired background
                ZStack {
                    Color("WashedBlack").edgesIgnoringSafeArea(.all) // This attempts to set the background for the Form

                    Form {
                        
                        Section() {
                            /*
                            Text("Colors")
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 18))
                                .foregroundColor(.white)
                                .listRowBackground(Color("WashedBlack"))
                             */
                            
                            ColorPicker("Widget Color", selection: $viewModel.textFieldColor)
                                .font(.custom("Futura-Medium", fixedSize: 14))
                                .foregroundColor(.white)
                            
                            ColorPicker("Text Color", selection: $viewModel.textColor)
                                .font(.custom("Futura-Medium", fixedSize: 14))
                                .foregroundColor(.white)
                            
                            Text("Font Size")
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
                                .foregroundColor(.white)
                            Slider(value: $viewModel.selectedFontSize, in: 8...28, step: 1) {
                            }
                            Text("Current size: \(viewModel.selectedFontSize, specifier: "%.0f")")
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
                                .foregroundColor(.white)
                            Text("Font Style")
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
                                .foregroundColor(.white)
                                .listRowBackground(Color("WashedBlack"))
                            Picker("Font", selection: $viewModel.selectedFont) {
                                ForEach(fonts, id: \.self) { font in
                                    Text(font).tag(font)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(height: UIScreen.main.bounds.height * 0.15)
                            .pickerStyle(.wheel)
                            .background(Color("WashedBlack"))
                        }
                        .listRowBackground(Color("WashedBlack")) // Individual row background
         
                    }
                    .onAppear {
                        UITableView.appearance().backgroundColor = UIColor.clear // Attempt to clear UITableView background
                    }
                }
                
                                    
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
                Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                
            }
        }
    }
}


 #Preview {
 WidgetCustom()
 }
