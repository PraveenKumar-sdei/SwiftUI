//
//  ScreenHeader.swift
//  CustomCommonNavigation
//
//  Created by Praveen Nirwal on 20/03/25.
//

import SwiftUI

public enum NavigationButtonType {
    case onlyIcon
    case withLabel
}

public struct NavigationBarLabelButton {
    let title: String
    let type: NavigationButtonType
    
    public init(title: String,
                type: NavigationButtonType) {
        self.title = title
        self.type = type
    }
}

public struct ScreenHeaderModel {
    let leftIcon: NavigationBarLabelButton?
    let rightIcon: NavigationBarLabelButton?
    
    public init(leftIcon: NavigationBarLabelButton?, rightIcon: NavigationBarLabelButton?) {
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
    }
}

public enum NavigationActionEvents {
    case leftTapped
    case rightTapped
}

public typealias onNavigationActionEvents = (NavigationActionEvents) -> Void

public struct ScreenHeader<Content: View>: View {
    let uiModel: ScreenHeaderModel
    let onEvents: onNavigationActionEvents?
    @ViewBuilder private var content: Content
    
    init(uiModel: ScreenHeaderModel,
         onEvents: onNavigationActionEvents?,
         @ViewBuilder content: () -> Content) {
        self.uiModel = uiModel
        self.onEvents = onEvents
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            VStack {
                NavigationBar(uiModel: uiModel,
                              onEvents: onEvents)
                content
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        
    }
}

struct NavigationBar: View {
    let uiModel: ScreenHeaderModel
    let onEvents: onNavigationActionEvents?
    
    var body: some View {
        HStack {
            if uiModel.leftIcon != nil {
                leftSideView(buttonTapped: {
                    onEvents?(.leftTapped)
                })
            }
            Spacer()
            if uiModel.rightIcon != nil {
                rightSideView(buttonTapped: {
                    onEvents?(.rightTapped)
                })
            }
            
        }
        .frame(height: 60)
    }
    
    /// Create left side navigation bar view
    @ViewBuilder
    private func leftSideView(buttonTapped: @escaping () -> Void) -> some View {
        Button(action: {
            buttonTapped()
        }, label: {
            if uiModel.leftIcon?.type == .onlyIcon {
                Image(systemName: "arrowshape.backward.fill")
                    .frame(width: 40, height: 40, alignment: .leading)
            } else {
                Text(uiModel.leftIcon?.title ?? "")
                    .frame(height: 40)
            }
        })
        
    }
    
    /// Create right side navigation bar view
    @ViewBuilder
    private func rightSideView(buttonTapped: @escaping () -> Void) -> some View {
        Button(action: {
            buttonTapped()
        }, label: {
            if uiModel.rightIcon?.type == .onlyIcon {
                Image(systemName: "star.fill")
            } else {
                Text(uiModel.rightIcon?.title ?? "")
            }
        })
        
    }
}

#Preview {
    ScreenHeader(uiModel: ScreenHeaderModel(leftIcon: NavigationBarLabelButton(title: "Back",
                                                                               type: .onlyIcon),
                                            rightIcon: NavigationBarLabelButton(title: "Close",
                                                                                type: .withLabel)),
                 onEvents: { event in
    },
                 content: {
        VStack{
            Text("Hey")
        }
    })
}
