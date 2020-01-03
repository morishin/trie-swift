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
        XCTAssertNil(tree.nextValue(key: "a"))
        XCTAssertNil(tree.nextValue(key: "b"))
        XCTAssertNil(tree.nextValue(key: "c"))
        XCTAssertNil(tree.nextValue(key: "a"))
        XCTAssertNil(tree.nextValue(key: "p"))
        XCTAssertNil(tree.nextValue(key: "p"))
        XCTAssertNil(tree.nextValue(key: "l"))
        XCTAssertEqual(tree.nextValue(key: "e"), "🍎")
        XCTAssertNil(tree.nextValue(key: "e"))
        XCTAssertNil(tree.nextValue(key: "s"))
        XCTAssertNil(tree.nextValue(key: "h"))
        XCTAssertEqual(tree.nextValue(key: "e"), "👩")
        XCTAssertNil(tree.nextValue(key: "e"))
        XCTAssertNil(tree.nextValue(key: "p"))
    }

    func testRemoveValue() {
        let tree = makeTrieTree()
        tree.removeValue(for: "she")
        XCTAssertNil(tree.nextValue(key: "s"))
        XCTAssertNil(tree.nextValue(key: "h"))
        XCTAssertNil(tree.nextValue(key: "e"))
        XCTAssertNil(tree.nextValue(key: "e"))
        XCTAssertEqual(tree.nextValue(key: "p"), "🐑")
        tree.removeValue(for: "sheep")
        XCTAssertNil(tree.nextValue(key: "s"))
        XCTAssertNil(tree.nextValue(key: "h"))
        XCTAssertNil(tree.nextValue(key: "e"))
        XCTAssertNil(tree.nextValue(key: "e"))
        XCTAssertNil(tree.nextValue(key: "p"))
        XCTAssertNil(tree.nextValue(key: "s"))
        XCTAssertNil(tree.nextValue(key: "e"))
        XCTAssertEqual(tree.nextValue(key: "a"), "🌊")
    }

    static var allTests = [
        ("testState", testState),
        ("testRemoveValue", testRemoveValue),
    ]
}
