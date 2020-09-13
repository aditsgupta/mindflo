//
//  AutoFocusTextField.swift
//  MindFlo
//
//  Created by Adit Gupta on 07/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import SwiftUI
struct AutoFocusTextFieldView: UIViewRepresentable {
     class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textView: UITextField) {
            text = textView.text ?? ""
        }
    }
    
    @Binding var text: String
    var isFirstResponder: Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<AutoFocusTextFieldView>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = UIColor.clear
        textField.delegate = context.coordinator
        return textField
    }
    
    func makeCoordinator() -> AutoFocusTextFieldView.Coordinator {
        return Coordinator(text: $text)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<AutoFocusTextFieldView>) {
         uiView.text = text
        if uiView.window != nil && isFirstResponder && !context.coordinator.didBecomeFirstResponder
        {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}


