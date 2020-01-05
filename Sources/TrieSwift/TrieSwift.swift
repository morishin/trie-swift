import Foundation

public class TrieTree<Key: Hashable, Value: Any> {
    private typealias Node = TrieNode<Key, Value>
    private let rootNode: Node
    private var currentNode: Node
    private var currentKeys: [Key] = []

    public enum State {
        case none
        case accept(keys: [Key], value: Value)

        var value: Value? {
            if case let .accept(_, value) = self {
                return value
            }
            return nil
        }
    }

    public init() {
        let rootNode: Node = .init()
        self.rootNode = rootNode
        self.currentNode = rootNode
    }

    public func insertValue(for keys: [Key], value: Value) {
        var current: Node = rootNode
        keys.forEach { key in
            if let next = current.child(for: key) {
                current = next
            } else {
                let newNode = Node()
                current.children[key] = newNode
                current = newNode
            }
        }
        current.value = value
    }

    public func removeValue(for keys: [Key]) {
        let stack = keys.reduce([(node: rootNode, key: nil as Key?)]) { (result, key) in
            if let next = result.first?.node.child(for: key) {
                return [(node: next, key: key)] + result
            }
            return result
        }
        guard let targetElement = stack.first, targetElement.node.value != nil else {
            assertionFailure("Value not found in trie tree for: keys \(keys)")
            return
        }

        // Remove value of the node for keys
        targetElement.node.value = nil

        // Remove nodes whose all descendents have no value
        if !targetElement.node.isLeaf {
            return
        }
        _ = stack.dropFirst().reduce(targetElement.key) { (removableKey, element) -> Key? in
            if let key = removableKey {
                element.node.children[key] = nil
                let removable = element.node.isLeaf && element.node.value == nil
                return removable ? element.key : nil
            }
            return nil
        }
    }

    public func nextState(key: Key) -> State {
        if let nextNode = currentNode.child(for: key) {
            if let value = nextNode.value {
                currentNode = rootNode
                let state = State.accept(keys: currentKeys, value: value)
                currentKeys = []
                return state
            } else {
                currentNode = nextNode
                currentKeys.append(key)
                return .none
            }
        } else {
            currentNode = rootNode
            currentKeys = []
            return .none
        }
    }
}

class TrieNode<Key: Hashable, Value: Any> {
    var value: Value?
    var children: [Key: TrieNode<Key, Value>]

    var isLeaf: Bool {
        return children.isEmpty
    }

    init(value: Value? = nil, children: [Key: TrieNode<Key, Value>] = [:]) {
        self.value = value
        self.children = children
    }

    func child(for key: Key) -> TrieNode<Key, Value>? {
        return children[key]
    }
}

public extension TrieTree where Key == Character {
    func insertValue(for key: String, value: Value) {
        insertValue(for: Array(key), value: value)
    }

    func removeValue(for key: String) {
        removeValue(for: Array(key))
    }

    // for debug
    func generatePlantUMLString() -> String {
        let fontSize = 48

        func nameForObject(_ object: AnyObject) -> String {
            return "\(String(ObjectIdentifier(object).hashValue, radix: 16, uppercase: false).suffix(6))"
        }

        func rec(result: String, sourceNodeKey: Key?, sourceNode: Node, isFirstChild: Bool) -> String {
            if sourceNode.children.isEmpty {
                if isFirstChild {
                    return result
                } else {
                    return result.split(separator: "\n").last.flatMap(String.init) ?? ""
                }
            }
            return sourceNode.children.enumerated().map { (index, arg) in
                let (key, node) = arg
                let nodeName = nameForObject(node)
                let sourceNodeName = sourceNodeKey == nil ? "[*]" : nameForObject(sourceNode)
                var output = "\(sourceNodeName) --> \(nodeName)\n"
                output.append("\(nodeName): <size:\(fontSize)>\(key)</size>\n")
                if let value = node.value {
                    output.append("note right: <size:\(fontSize)>\(value)</size>\n")
                }
                return rec(result: result.appending(output), sourceNodeKey: key, sourceNode: node, isFirstChild: index == 0)
            }.joined()
        }

        var result = "@startuml\n"
        let rows = rec(result: "", sourceNodeKey: nil, sourceNode: rootNode, isFirstChild: true)
        let uniqueRows = (NSOrderedSet(array: rows.split(separator: "\n")).array as! [String]).joined(separator: "\n")
        result.append(uniqueRows)
        result.append("\n@enduml")
        return result
    }
}
