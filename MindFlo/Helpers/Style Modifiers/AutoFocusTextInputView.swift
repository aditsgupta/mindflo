//
//  AutoFocusTextInputView.swift
//  MindFlo
//
//  Created by Adit Gupta on 07/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation
import SwiftUI
struct AutoFocusTextInputView: UIViewRepresentable {
    class Coordinator: NSObject, UITextViewDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textViewDidChangeSelection(_ textView: UITextView) {
            text = textView.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<AutoFocusTextInputView>) -> UITextView {
        let textView = UITextView(frame: .zero)
        textView.font = .systemFont(ofSize: 20)
        textView.backgroundColor = UIColor.clear
        textView.delegate = context.coordinator
        return textView
    }

    func makeCoordinator() -> AutoFocusTextInputView.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<AutoFocusTextInputView>) {
        uiView.text = text
        if uiView.window != nil && isFirstResponder && !context.coordinator.didBecomeFirstResponder
        {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

//class PlaceholderTextView: UITextView {
//
//    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray
//    @IBInspectable var placeholderText: String = ""
//
//
//    override var font: UIFont? {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    override var contentInset: UIEdgeInsets {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    override var textAlignment: NSTextAlignment {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    override var text: String? {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    override var attributedText: NSAttributedString? {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setUp()
//    }
//
//    override init(frame: CGRect, textContainer: NSTextContainer?) {
//        super.init(frame: frame, textContainer: textContainer)
//    }
//
//    private func setUp() {
//        NotificationCenter.default.addObserver(self,
//         selector: #selector(self.textChanged(notification:)),
//         name: Notification.Name("UITextViewTextDidChangeNotification"),
//         object: nil)
//    }
//
//    @objc func textChanged(notification: NSNotification) {
//        setNeedsDisplay()
//    }
//
//    func placeholderRectForBounds(bounds: CGRect) -> CGRect {
//        var x = contentInset.left + 4.0
//        var y = contentInset.top  + 9.0
//        let w = frame.size.width - contentInset.left - contentInset.right - 16.0
//        let h = frame.size.height - contentInset.top - contentInset.bottom - 16.0
//
//        if let style = self.typingAttributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle {
//            x += style.headIndent
//            y += style.firstLineHeadIndent
//        }
//        return CGRect(x: x, y: y, width: w, height: h)
//    }
//
//    override func draw(_ rect: CGRect) {
//        if text!.isEmpty && !placeholderText.isEmpty {
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.alignment = textAlignment
//            let attributes: [NSAttributedString.Key: Any] = [
//            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : font!,
//            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : placeholderColor,
//            NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue)  : paragraphStyle]
//
//            placeholderText.draw(in: placeholderRectForBounds(bounds: bounds), withAttributes: attributes)
//        }
//        super.draw(rect)
//    }
//}
