# TrieSwift
![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)
[![SPM](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://github.com/apple/swift-package-manager)

Trie tree implementation in Swift.

## Example

1. Make tree

    ```swift
    let tree = TrieTree<Character, String>()
    tree.insertValue(for: "sea", value: "🌊")
    tree.insertValue(for: "seat", value: "💺")
    tree.insertValue(for: "sheep", value: "🐑")
    tree.insertValue(for: "she", value: "👩")
    tree.insertValue(for: "tea", value: "🍵")
    tree.insertValue(for: "triangle", value: "🔺")
    tree.insertValue(for: "tree", value: "🌳")
    tree.insertValue(for: "apple", value: "🍎")
    ```

1. Tree traversal

    ```swift
    print(tree.nextValue(key: "a")) // => nil
    print(tree.nextValue(key: "p")) // => nil
    print(tree.nextValue(key: "p")) // => nil
    print(tree.nextValue(key: "l")) // => nil
    print(tree.nextValue(key: "e")) // => "🍎"
    ```

## Visualize

`TrieTree` can generate PlantUML format text for debugging.

```swift
print(tree.generatePlantUMLString()) // => "@startuml ... @enduml"
```

The generated text can be rendered like the figure below.

<img src="https://user-images.githubusercontent.com/1413408/71780727-77bdfc80-3009-11ea-8f37-9eb8a6aea816.png" width="640" alt="plantuml">

## License

MIT
