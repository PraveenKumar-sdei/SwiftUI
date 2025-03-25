//
//  ContentView.swift
//  CustomCommonNavigation
//
//  Created by Praveen Nirwal on 20/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScreenHeader(uiModel: ScreenHeaderModel(leftIcon: NavigationBarLabelButton(title: "",
                                                                                   type: .onlyIcon),
                                                rightIcon: nil),
                     onEvents: { event in
            
        },
                     content: {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }

        })
    }
}

#Preview {
    ContentView()
}
