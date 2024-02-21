//
//  InspireSyncWidget.swift
//  InspireSyncWidget
//
//  Created by Nivethikan Neethirasa on 2024-02-18.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀", myString: getMyString())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀", myString: getMyString())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀", myString: getMyString())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

private func getMyString() -> String {
    let defaults = UserDefaults(suiteName:"group.Nivethikan-Neethirasa.InspireSync")
    return defaults?.string(forKey: "myDefaultString") ?? "No String"
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
    let myString: String
}

struct InspireSyncWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.myString)
        }
    }
}

struct InspireSyncWidget: Widget {
    let kind: String = "InspireSyncWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                InspireSyncWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                InspireSyncWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color("WidgetBackground"))
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    InspireSyncWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀", myString: "Hello")
    SimpleEntry(date: .now, emoji: "🤩", myString: "Hi")
}
