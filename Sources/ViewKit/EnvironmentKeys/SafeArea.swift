//
//  File.swift
//  
//
//  Created by Hans Rietmann on 30/06/2021.
//

#if !os(macOS)
import Foundation
import SwiftUI




private struct SafeAreaInsetsKey: EnvironmentKey {
    internal static var appInsets: EdgeInsets? = nil
    public static var defaultValue: EdgeInsets {
        guard let insets = appInsets else {
            NotificationCenter.default.addObserver(forName: UIApplication.didFinishLaunchingNotification,
                                                   object: nil,
                                                   queue: .main) { notification in
                guard let app = notification.object as? UIApplication else { return }
                appInsets = app.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.insets
            }
            return .zero
        }
        return insets
    }
}

extension EnvironmentValues {
    
    public var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

extension UIEdgeInsets {
    
    public var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

extension EdgeInsets {
    
    public static let zero = UIEdgeInsets.zero.insets
    public var insets: UIEdgeInsets {
        UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
    }
}



fileprivate struct MyView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        Text("Ciao")
            .padding(safeAreaInsets)
            .background(Color.red)
    }
}


fileprivate struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
#endif
