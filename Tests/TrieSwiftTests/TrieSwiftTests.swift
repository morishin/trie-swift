import XCTest
@testable import TrieSwift

final class TrieSwiftTests: XCTestCase {
    private func makeTrieTree() -> TrieTree<Character, String> {
        let tree = TrieTree<Character, String>()
        tree.insertValue(for: "sea", value: "🌊")
        tree.insertValue(for: "seat", value: "💺")
        tree.insertValue(for: "sheep", value: "🐑")
        tree.insertValue(for: "she", value: "👩")
        tree.insertValue(for: "tea", value: "🍵")
        tree.insertValue(for: "triangle", value: "🔺")
        tree.insertValue(for: "tree", value: "🌳")
        tree.insertValue(for: "apple", value: "🍎")
        return tree
    }

    func testState() {
        let tree = makeTrieTree()
        XCTAssertNil(tree.nextState(key: "a").value)
        XCTAssertNil(tree.nextState(key: "b").value)
        XCTAssertNil(tree.nextState(key: "c").value)
        XCTAssertNil(tree.nextState(key: "a").value)
        XCTAssertNil(tree.nextState(key: "p").value)
        XCTAssertNil(tree.nextState(key: "p").value)
        XCTAssertNil(tree.nextState(key: "l").value)
        XCTAssertEqual(tree.nextState(key: "e").value, "🍎")
        XCTAssertNil(tree.nextState(key: "e").value)
        XCTAssertNil(tree.nextState(key: "s").value)
        XCTAssertNil(tree.nextState(key: "h").value)
        XCTAssertEqual(tree.nextState(key: "e").value, "👩")
        XCTAssertNil(tree.nextState(key: "e").value)
        XCTAssertNil(tree.nextState(key: "p").value)
    }

    func testRemoveValue() {
        let tree = makeTrieTree()
        tree.removeValue(for: "she")
        XCTAssertNil(tree.nextState(key: "s").value)
        XCTAssertNil(tree.nextState(key: "h").value)
        XCTAssertNil(tree.nextState(key: "e").value)
        XCTAssertNil(tree.nextState(key: "e").value)
        XCTAssertEqual(tree.nextState(key: "p").value, "🐑")
        tree.removeValue(for: "sheep")
        XCTAssertNil(tree.nextState(key: "s").value)
        XCTAssertNil(tree.nextState(key: "h").value)
        XCTAssertNil(tree.nextState(key: "e").value)
        XCTAssertNil(tree.nextState(key: "e").value)
        XCTAssertNil(tree.nextState(key: "p").value)
        XCTAssertNil(tree.nextState(key: "s").value)
        XCTAssertNil(tree.nextState(key: "e").value)
        XCTAssertEqual(tree.nextState(key: "a").value, "🌊")
    }

    static var allTests = [
        ("testState", testState),
        ("testRemoveValue", testRemoveValue),
    ]
}
