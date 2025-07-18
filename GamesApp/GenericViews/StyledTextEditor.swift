//
//  StyledTextEditor.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 17/07/25.
//

import SwiftUI

enum TextEditorSize {
    case small
    case large

    var height: CGFloat {
        switch self {
        case .small: return 50
        case .large: return 110
        }
    }
}

struct StyledTextEditor: View {
    @Binding var text: String
    var size: TextEditorSize = .small
    
    var body: some View {
        TextEditor(text: $text)
            .textEditorStyle(.plain)
            .frame(height: size.height)
            .padding(5)
            .background(Color.secondary.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3))
            )
    }
}
