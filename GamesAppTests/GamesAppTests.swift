//
//  GamesAppTests.swift
//  GamesAppTests
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import XCTest
import SwiftData
@testable import GamesApp

final class GamesAppTests: XCTestCase {
    var modelContainer: ModelContainer!
    var context: ModelContext!
    
    @MainActor
    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: Game.self, configurations: config)
        context = modelContainer.mainContext
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSaveChangesUpdatesGame() async throws {
        let game = Game(id: 1, title: "Old", thumbnail: "", shortDescription: "Old Desc", genre: "Action", platform: "PC", releaseDate: "2022-01-01", publisher: "Dev")
        context.insert(game)
        try context.save()

        let vm = await MainActor.run {
            GameDetailViewModel(game: game, context: context)
        }

        await MainActor.run {
            vm.editedTitle = "New Title"
            vm.editedDescription = "New Desc"
        }

        await vm.applyChanges()

        XCTAssertEqual(game.title, "New Title")
        XCTAssertEqual(game.shortDescription, "New Desc")
    }

    func testDeleteGameRemovesFromContext() async throws {
        let game = Game(id: 2, title: "To Delete", thumbnail: "", shortDescription: "", genre: "RPG", platform: "PC", releaseDate: "", publisher: "")
        context.insert(game)
        try context.save()

        let vm = await MainActor.run {
            GameDetailViewModel(game: game, context: context)
        }

        await vm.delete()

        let fetched = try context.fetch(FetchDescriptor<Game>())
        XCTAssertFalse(fetched.contains { $0.id == game.id })
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
