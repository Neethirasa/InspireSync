//
//  InspireSyncWidget.swift
//  InspireSyncWidget
//
//  Created by Nivethikan Neethirasa on 2024-02-18.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let myString: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), myString: getMyString())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), myString: getMyString())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(date: Date(), myString: getMyString())
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    private func getMyString() -> String {
        let defaults = UserDefaults(suiteName:"group.Nivethikan-Neethirasa.InspireSync")
        return defaults?.string(forKey: "myDefaultString") ?? "No Quote"
    }
}

struct InspireSyncWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        let textFieldColor = Color(ColorStorageUtil.loadColor(forKey: "textFieldColor") ?? UIColor.black)

        let textColor = Color(ColorStorageUtil.loadColor(forKey: "textColor") ?? UIColor.white)

        VStack {
            Text(entry.myString)
                        //.background(textFieldColor) // Change the background color of the widget
                        .foregroundColor(textColor) // Change the text color
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 18))
                    .padding()
        }
        .widgetBackground(textFieldColor)
        
        // Use textFieldColor and textColor in your widget's view
    }
    
    private func loadColor(forKey key: String) -> Color? {
        let defaults = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")
        if let colorData = defaults?.data(forKey: key),
           let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
            return Color(uiColor)
        }
        return nil
    }
}

struct InspireSyncWidget: Widget {
    let kind: String = "InspireSyncWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            InspireSyncWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        // Optionally set supportedFamilies if needed
    }
}

extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}

#Preview(as: .systemSmall) {
    InspireSyncWidget()
} timeline: {
    SimpleEntry(date: .now, myString: "Hello")
    SimpleEntry(date: .now, myString: "Hi")
}
