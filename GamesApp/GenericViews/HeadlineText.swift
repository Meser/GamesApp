//
//  HeadlineText.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 17/07/25.
//

import SwiftUI

struct HeadlineText: View {
    private let content: Text
    init(localizedText: LocalizedStringKey) {
        self.content = Text(localizedText)
    }
    
    init(_ text: String) {
        self.content = Text(text)
    }
    
    var body: some View {
        content.font(.headline)
    }
}
