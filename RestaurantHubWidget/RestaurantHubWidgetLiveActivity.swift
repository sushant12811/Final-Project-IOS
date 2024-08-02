//
//  RestaurantHubWidgetLiveActivity.swift
//  RestaurantHubWidget
//
//  Created by sleduap on 2024-08-01.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RestaurantHubWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct RestaurantHubWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RestaurantHubWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RestaurantHubWidgetAttributes {
    fileprivate static var preview: RestaurantHubWidgetAttributes {
        RestaurantHubWidgetAttributes(name: "World")
    }
}

extension RestaurantHubWidgetAttributes.ContentState {
    fileprivate static var smiley: RestaurantHubWidgetAttributes.ContentState {
        RestaurantHubWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: RestaurantHubWidgetAttributes.ContentState {
         RestaurantHubWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: RestaurantHubWidgetAttributes.preview) {
   RestaurantHubWidgetLiveActivity()
} contentStates: {
    RestaurantHubWidgetAttributes.ContentState.smiley
    RestaurantHubWidgetAttributes.ContentState.starEyes
}
