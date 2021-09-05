//
//  TapGestureTestApp.swift
//  TapGestureTest
//
//  Created by Michael Tigas on 1/9/21.
//

import SwiftUI

/**
 "Clicking" the SwiftUI Button via mouse/trackpad consecutively breaks the tap gesture for the segmented control and text fields.
 "Tapping" the screen does not exhibit this behaviour.
 Somehow future touch gestures are also ignored after the tap gesture is broken, unless the SwiftUI button is tapped consecutively again.
 
 This bug occurs in Xcode 13 B5, compiling to iPadOS 15 B8 and macOS Monterey Beta 6
 
 Help me Obi Wan.
 */

@main
struct TapGestureTestApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
