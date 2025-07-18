//
//  UIApplication+Extensions.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 17/07/25.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
