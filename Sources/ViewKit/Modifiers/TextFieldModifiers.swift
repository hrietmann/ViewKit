//
//  File.swift
//  
//
//  Created by Hans Rietmann on 23/06/2021.
//

#if !os(macOS)
import SwiftUI


extension TextField {
    public func placeholder(_ placeholder: String) -> TextField {
        var view = self
        view.placeholder = placeholder
        return view
    }
    
    public func keyboardType(_ type: UIKeyboardType) -> TextField {
        var view = self
        view.keyboardType = type
        return view
    }
    
    public func autocapitalization(_ cap: UITextAutocapitalizationType) -> TextField {
        var view = self
        view.autocapitalization = cap
        return view
    }
    
    public func autocorrection(_ autocorrection: UITextAutocorrectionType) -> TextField {
        var view = self
        view.autocorrection = autocorrection
        return view
    }
    
    public func clearButtonMode(_ mode: UITextField.ViewMode) -> TextField {
        var view = self
        view.clearButtonMode = mode
        return view
    }
    
    public func secureEntry(_ secureEntry: Bool) -> TextField {
        var view = self
        view.secureEntry = secureEntry
        return view
    }
    
    public func keyboardAppearance(_ appearance: UIKeyboardAppearance) -> TextField {
        var view = self
        view.keyboardAppearance = appearance
        return view
    }
    
    public func returnKey(_ key: UIReturnKeyType) -> TextField {
        var view = self
        view.returnKey = key
        return view
    }
    
    public func onReturn(_ completion: @escaping () -> ()) -> TextField {
        var view = self
        view.onReturn = completion
        return view
    }
    
    public func onClear(_ completion: @escaping () -> ()) -> TextField {
        var view = self
        view.onClear = completion
        return view
    }
}
#endif
