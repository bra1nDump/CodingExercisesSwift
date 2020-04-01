func pow(_ base: Int, _ power: Int) -> Int {
    var power = power
    var result: Int = 1
    while (power != 0) {
        result *= base
        power -= 1
    }
    return result
}

func factorial(_ k: Int) -> Int {
    if (k == 0 || k == 1) {
        return 1
    }
    return k * factorial(k - 1)
}

extension String {
    func words() -> [Substring] {
    #if swift(>=5)
        return self.split(separator: " ")
        // For CodeChef - runs swift 3
    #else
        return line.characters
            .split { $0 == " " }
            .map(String.init)
    #endif
    }
}

class MarblesMath {
    func solve(marbles: Int, colors: Int) -> Int {
        // ensure there is at least one marble of each color
        let marbles = marbles - colors
        let variations = pow(marbles + 1, colors - 1)
        let redunduntFactor = factorial(marbles + 1)
        print("marbles:", marbles, "colors:", colors)
        print(
            "variations:", variations,
            "redundunt:", redunduntFactor)
        return variations / redunduntFactor
    }
}

class MarblesBruteForce {
    static var cache = [String: Int]()

    func solve(marbles: Int, colors: Int) -> Int {
        return _solve(marbles: marbles - colors, colors: colors)
    }

    func _solve(marbles: Int, colors: Int) -> Int {
        let key = "\(marbles),\(colors)"
        if (MarblesBruteForce.cache[key] != nil) {
            return MarblesBruteForce.cache[key]!
        } else if (marbles == 0) {
            return 1
        } else if (colors == 1) {
            return 1
        } else {
            return (0...marbles)
                .map { (marbles) in 
                    _solve(marbles: marbles, colors: colors - 1) 
                }
                .reduce(0, +)
        }
    }
}

public func marblesRun() {
    var lines: [String] = []
    while true {
        guard let line = readLine() else { break }
        lines.append(line)
    }

    for line in lines.dropFirst() {
        let line = line.split(separator: " ")
        let marbles = Int(line[0])!
        let colors = Int(line[1])!
        print(MarblesMath().solve(marbles: marbles, colors: colors))
    }
}
