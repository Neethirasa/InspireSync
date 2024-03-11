//
//  TextView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-07.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)
        textView.layer.cornerRadius = 5
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, UITextViewDelegate {
    var parent: TextView

    init(_ parent: TextView) {
        self.parent = parent
    }

    func textViewDidChange(_ textView: UITextView) {
        parent.text = textView.text
    }
}

/*
 #Preview {
 TextView()
 }
 */
