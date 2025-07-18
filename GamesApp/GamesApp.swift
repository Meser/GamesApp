
import SwiftUI
import SwiftData

@main
struct GamesApp: App {
    var body: some Scene {
        WindowGroup {
            let container = try! ModelContainer(for: Game.self)
            let context = ModelContext(container)
            StartupView(context: context)
        }
        .modelContainer(for: Game.self)
    }
}
