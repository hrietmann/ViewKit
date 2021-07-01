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
        @Binding var editing: Bool
        var onReturn: () -> () = {}

        init(text: Binding<String>, editing: Binding<Bool>) {
            _text = text
            _editing = editing
        }
        
        
        // 1 — Keyboard appearing
        public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            /**
             Printed when :
             • keyboard appear, before "textFieldDidBeginEditing"
             */
            return true
        }
        
        // 2 — Keyboard appeared
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            /**
             Printed when :
             • keyboard appears, after "textFieldShouldBeginEditing"
             */
            editing = true
        }
        
        // 3 — Text changing
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            /**
             Printed when :
             • there is a text change (character added/removed), before "textFieldDidChangeSelection"
             */
            return true
        }
        
        // 4 — Text changed
        public func textFieldDidChangeSelection(_ textField: UITextField) {
            /**
             Printed when :
             • there is a text change (character added/removed), after "textField shouldChangeCharactersIn"
             • selection of the text changes
             • after textFieldShouldClear, once before the clearing is effective
             • after textFieldShouldClear, once more after the clearing is effective
             */
            text = textField.text ?? ""
        }
        
        // 5 — Clearing the text
        public func textFieldShouldClear(_ textField: UITextField) -> Bool {
            /**
             Printed when :
             • the clear button is pressed, before "textFieldDidChangeSelection" is called for the text change
             */
            return textField.clearButtonMode != .never
        }
        
        // 6 - Pressing the return key
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            /**
             Printed when :
             • pressing the return key, before "textFieldShouldEndEditing"
             */
            textField.resignFirstResponder()
            onReturn()
            return true
        }
        
        // 7 - Dismissing Keyboard
        public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            /**
             Printed when :
             • dismissing the keyboard, after "textFieldShouldReturn" (if return key is pressed) and before "textFieldDidEndEditing"
             */
            return true
        }
        
        // 8 - Keyboard dismissed
        public func textFieldDidEndEditing(_ textField: UITextField) {
            /**
             Printed when :
             • dismissing the keyboard, after "textFieldShouldEndEditing"
             */
            editing = false
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
    var onReturn: () -> () = {}
    
    
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
        return Coordinator(text: $text, editing: $editing)
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
        if editing  {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
        context.coordinator.onReturn = onReturn
    }
}



struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        TextField(text: .constant(""), editing: .constant(false))
            .placeholder("ldfdf")
    }
}
#endif
