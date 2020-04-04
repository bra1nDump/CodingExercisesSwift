// Facebook sample problem on their interview preview video
// 6 min first iteration
// 1 min 20 s proof read - no errors found
// 8 min actual testing - 5 compilation errors
//   * Int -> Float type conversion not implicit
//   * Annotate dangerous var/lets, in our case avarages

func id<A>(input: A) -> A { input }

class Node {
    let value: Float
    var left: Node?
    var right: Node?

    var children: [Node] {
        [left, right].compactMap(id)
    }

    init(value: Float, left: Node? = nil, right: Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

func treeLevelAvarages(root: Node?) -> [Float] {
    guard let root = root else { return [] }
    var currentLevel: [Node] = [root]
    var avarages: [Float] = []
    while !currentLevel.isEmpty {
        avarages.append(currentLevel.map { $0.value }.reduce(0.0, +) / Float(currentLevel.count))
        currentLevel = currentLevel.flatMap { $0.children }
    }
    return avarages
}