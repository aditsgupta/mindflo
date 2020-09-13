//
//  NavigateModifier.swift
//  MindFlo
//
//  Created by Adit Gupta on 07/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import SwiftUI
extension View {
    
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<SomeView: View>(to view: SomeView, when binding: Binding<Bool>) -> some View {
        modifier(NavigateModifier(destination: view, binding: binding))
    }
}


// MARK: - NavigateModifier
fileprivate struct NavigateModifier<SomeView: View>: ViewModifier {
    
    // MARK: Private properties
    fileprivate let destination: SomeView
    @Binding fileprivate var binding: Bool
    
    
    // MARK: - View body
    fileprivate func body(content: Content) -> some View {
        NavigationView {
            ZStack {
                Color(.clear)
                    .edgesIgnoringSafeArea(.all)
                content
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                NavigationLink(destination: destination
                    .navigationBarTitle("")
                    .navigationBarHidden(true),
                               isActive: $binding) {
                                EmptyView()
                }
            }
        }
    }
}
