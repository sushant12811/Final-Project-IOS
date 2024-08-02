//
//  RestaurantHubWidget.swift
//  RestaurantHubWidget
//
//  Created by sleduap on 2024-08-01.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    let images = ["img_1","img_2","img_3","img_4","img_5","img_6"]
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), str: "img_1")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, str: "img_2")
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of entries that loop through the images array indefinitely.
        let currentDate = Date()
        var currentDateOffset = currentDate

        // Adjust the number of repetitions to fit your needs
        let repetitions = 100
        let intervalSeconds = 5

        for index in 0 ..< images.count * repetitions {
            let entryDate = Calendar.current.date(byAdding: .second, value: intervalSeconds * index, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, str: images[index % images.count])
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let str: String
}

struct RestaurantHubWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("RestaurantHub")
            Image(entry.str)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct RestaurantHubWidget: Widget {
    let kind: String = "RestaurantHubWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            RestaurantHubWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    RestaurantHubWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, str: "img_1")
    SimpleEntry(date: .now, configuration: .starEyes, str: "img_2")
}
