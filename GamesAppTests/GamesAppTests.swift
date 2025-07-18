//
//  GamesAppTests.swift
//  GamesAppTests
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import XCTest
import RealmSwift
@testable import GamesApp

final class GamesAppTests: XCTestCase {
    var realm: Realm!
    var repository: GameRepository!
    
    override func setUpWithError() throws {
        var config = Realm.Configuration()
        config.inMemoryIdentifier = "TestRealm"
        realm = try! Realm(configuration: config)
        repository = GameRepository(realm: realm)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try! realm.write {
            realm.deleteAll()
        }
        repository = nil
        realm = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveAndRetrieveGame() {
        let dto = GameDTO(id: 1,
                          title: "Test Game",
                          thumbnail: "url",
                          shortDescription: "Desc",
                          genre: "Action",
                          platform: "PC Windows",
                          releaseDate: "2024-06-22",
                          publisher: "Blizzard Entertainment")
        repository.save(games: [dto])
        let results = repository.getAllGames()
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.title, "Test Game")
    }

    func testUpdateGame() {
        let dto = GameDTO(id: 2,
                          title: "Old Title",
                          thumbnail: "url",
                          shortDescription: "Old Desc",
                          genre: "RPG",
                          platform: "PC Windows",
                          releaseDate: "2024-06-22",
                          publisher: "Blizzard Entertainment")
        repository.save(games: [dto])
        guard let game = repository.getAllGames().first else {
            XCTFail("No game found")
            return
        }
        repository.updateGame(game,
                              title: "New Title",
                              description: "New Desc")
        let updated = repository.getAllGames().first
        XCTAssertEqual(updated?.title, "New Title")
        XCTAssertEqual(updated?.shortDescription, "New Desc")
    }

    func testDeleteGame() {
        let dto = GameDTO(id: 3,
                          title: "ToDelete",
                          thumbnail: "url",
                          shortDescription: "Desc",
                          genre: "Puzzle",
                          platform: "PC Windows",
                          releaseDate: "2024-06-22",
                          publisher: "Blizzard Entertainment")
        repository.save(games: [dto])
        guard let game = repository.getAllGames().first else {
            XCTFail("No game found")
            return
        }
        repository.deleteGame(game)
        let remaining = repository.getAllGames()
        XCTAssertEqual(remaining.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
