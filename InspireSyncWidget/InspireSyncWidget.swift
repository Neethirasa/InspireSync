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
        // Retrieve preferences
        let textFieldColor = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")?.color(forKey: "textFieldColor") ?? Color.black
        let textColor = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")?.color(forKey: "textColor") ?? Color.white
        let fontName = UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")?.string(forKey: "selectedFont") ?? "System"
        
        VStack {
            Text(entry.myString)
                .font(fontForName(fontName))
                .padding()
            .foregroundColor(textColor)
        }
        .widgetBackground(textFieldColor)
    }
    
    func fontForName(_ name: String) -> Font {
        switch name {
        case "Helvetica":
            return .custom("Helvetica", size: 16)
        case "Courier":
            return .custom("Courier", size: 16)
        default:
            return .system(size: 16)
        }
    }
}

// Extension to simplify color retrieval from UserDefaults
extension UserDefaults {
    func color(forKey key: String) -> Color? {
        guard let colorData = data(forKey: key) else { return nil }
        do {
            if let uiColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
                return Color(uiColor)
            }
        } catch {
            print("Failed to unarchive UIColor: \(error)")
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
