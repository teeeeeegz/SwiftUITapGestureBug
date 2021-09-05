//
//  ContentView.swift
//  TapGestureTest
//
//  Created by Michael Tigas on 1/9/21.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
  @State private var tapCounter = 0
  @State private var uiSegCounter = 0

  var body: some View {
    GroupBox {
      SegmentedPickerView(tapCounter: self.$tapCounter, uiSegCounter: self.$uiSegCounter)
      
      Divider()
        .padding()
      
      DetailView()
      
      Spacer()
    }
    .frame(maxWidth: 500, maxHeight: 500)
   }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDevice("iPad (8th generation)")
  }
}

// MARK: - SegmentedPickerView

struct SegmentedPickerView: View {
  @Binding var tapCounter: Int
  @Binding var uiSegCounter: Int

  var body: some View {
    VStack {
      GroupBox {
        Text("SwiftUI Picker - \(self.tapCounter)")

        Picker("SwiftUI Picker", selection: self.$tapCounter) {
          Text("Tab 1").tag(0)
          Text("Tab 2").tag(1)
          Text("Tab 3").tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
      }
      
      GroupBox {
        Text("UIKit Segmented Control - \(self.uiSegCounter)")

        SegmentedControl(selectedTab: self.$uiSegCounter)
      }
    }
  }
}

// MARK: - SegmentedControl

/**
 Wrapped UISegmentedControl
 */
struct SegmentedControl: UIViewRepresentable {
  @Binding var selectedTab: Int

  func makeUIView(context: Context) -> UISegmentedControl {
    let control = UISegmentedControl(frame: .zero, actions: [
      .init(title: "Tab 1", handler: { _ in self.selectedTab = 0 }),
      .init(title: "Tab 2", handler: { _ in self.selectedTab = 1 }),
      .init(title: "Tab 3", handler: { _ in self.selectedTab = 2 }),
    ])
    
    control.selectedSegmentIndex = 0
    
    return control
  }

  func updateUIView(_ uiView: UISegmentedControl, context: Context) {
    print("Update")
  }
}

// MARK: - DetailView

struct DetailView: View {
  @State private var textViewValue: String = "This is a UITextView"
  @State private var textFieldValue: String = "This is a TextField"

  var body: some View {
    VStack(spacing: 32) {
      GroupBox {
        HStack(spacing: 16) {
          
          /**
           "Clicking" the SwiftUI Button via mouse/trackpad consecutively breaks the tap gesture for the segmented control and text fields.
           "Tapping" the screen does not exhibit this behaviour.
           Somehow future touch gestures are also ignored after the tap gesture is broken, unless the SwiftUI button is tapped consecutively again.
           
           This bug occurs in Xcode 13 B5, compiling to iPadOS 15 B8 and macOS Monterey Beta 6
           
           Help me Obi Wan.
           */
          VStack {
            Button { print("SwiftUI Button 1") } label: { Text("SwiftUI Button 1") }
              .padding()
              .frame(width: 200, height: 50)
      //        .onTapGesture { print("SwiftUI Button 1") }

            Button { print("SwiftUI Button 2") } label: { Text("SwiftUI Button 2") }
              .padding()
              .frame(width: 200, height: 50)
      //        .onTapGesture { print("SwiftUI Button 2") }
          }
          
          Divider()
          
          VStack {
            ButtonView(title: "UIKit Button 1") { print("UIKit Button 1") }
              .frame(width: 200, height: 50)

            ButtonView(title: "UIKit Button 2") { print("UIKit Button 2") }
              .frame(width: 200, height: 50)
          }
        }
      }

      GroupBox {
        VStack(spacing: 32) {
          TextView(text: self.$textViewValue)
            .frame(height: 50)
            .frame(width: 300)
            .background(Color(.secondarySystemBackground))

          TextField("", text: self.$textFieldValue)
            .frame(height: 50)
            .frame(width: 300)
            .background(Color(.secondarySystemBackground))
        }
      }
    }
  }
}

// MARK: - TextView

/**
 Wrapped UITextView
 */
struct TextView: UIViewRepresentable {
  @Binding var text: String

  func makeUIView(context: Context) -> UITextView {
    UITextView()
  }

  func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
  }
}

// MARK: - ButtonView

/**
 Wrapped UIButton
 */
struct ButtonView: UIViewRepresentable {
  let title: String
  var tintColour: UIColor = .systemGreen
  let action: () -> ()
  
  func makeUIView(context: Context) -> UIButton {
    let button = UIButton(primaryAction: UIAction(title: self.title, image: nil, handler: { _ in
      self.action()
    }))
    
    button.tintColor = self.tintColour
    button.isPointerInteractionEnabled = true
    
    return button
  }
  
  func updateUIView(_ uiView: UIButton, context: Context) {
  }
}
