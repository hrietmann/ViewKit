//
//  AttributedText.swift
//  SwiftUIView
//
//  Created by Hans Rietmann on 19/07/2021.
//

import SwiftUI

public struct AttributedText: UIViewRepresentable {
    var attributedText: NSAttributedString

    public init(_ attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }

    public func makeUIView(context: Context) -> UITextView {
        return UITextView()
    }

    public func updateUIView(_ label: UITextView, context: Context) {
        label.attributedText = attributedText
    }
}
