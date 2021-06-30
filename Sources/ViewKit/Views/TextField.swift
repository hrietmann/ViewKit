//
//  SwiftUIView.swift
//  
//
//  Created by Hans Rietmann on 22/06/2021.
//

#if !os(macOS)
import SwiftUI



public struct TextField: UIViewRepresentable {

    public class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    @Binding var editing: Bool
    var placeholder = "Placeholder"
    var keyboardType = UIKeyboardType.default
    var autocapitalization = UITextAutocapitalizationType.sentences
    var autocorrection = UITextAutocorrectionType.default
    var clearButtonMode = UITextField.ViewMode.whileEditing
    var secureEntry = false
    var keyboardAppearance = UIKeyboardAppearance.default
    var returnKey = UIReturnKeyType.default
    
    
    public init(text: Binding<String>, editing: Binding<Bool>) {
        _text = text
        _editing = editing
    }

    public func makeUIView(context: UIViewRepresentableContext<TextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = autocapitalization
        textField.autocorrectionType = autocorrection
        textField.clearButtonMode = clearButtonMode
        textField.isSecureTextEntry = secureEntry
        textField.keyboardAppearance = keyboardAppearance
        textField.returnKeyType = returnKey
        return textField
    }

    public func makeCoordinator() -> TextField.Coordinator {
        return Coordinator(text: $text)
    }

    public func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextField>) {
        uiView.text = text
        uiView.placeholder = placeholder
        uiView.keyboardType = keyboardType
        uiView.autocapitalizationType = autocapitalization
        uiView.autocorrectionType = autocorrection
        uiView.clearButtonMode = clearButtonMode
        uiView.isSecureTextEntry = secureEntry
        uiView.keyboardAppearance = keyboardAppearance
        uiView.returnKeyType = returnKey
        if editing && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}



struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        TextField(text: .constant(""), editing: .constant(false))
            .placeholder("ldfdf")
    }
}
#endif
