// TODO: move this to Prelude library

typealias Solver = (String) -> Void
func run(solver: Solver) {
    let tests = Int(readLine()!)!
    (0..<tests)
    .map { _ in readLine()! }
    .forEach(solver)
}

class CodeCrazyMinions {
    func solve(input: String) -> String {
        guard input != "" else { return "YES" }
        let output = 
            input.map {
                $0.asciiValue! - 
                ("a" as Character).asciiValue!
            }
            .map(Int.init)
        let count = incCount(memory: output[0], output: output)
        // count + input.count + 1 <= 11 * input.count (print instructions)
        // ~ count + 1 <= 10 * input.count
        print("count: \(count)")
        return count + 1 <= 10 * input.count ? "YES" : "NO"
    }

    func incCount(memory: Int, output: [Int]) -> Int {
        guard let next = output.first else { return 0 }
        let tail = Array(output.dropFirst())
        return 
            (memory <= next ?
            next - memory
            : 26 - memory + next)
            + incCount(memory: next, output: tail)
    }
}
