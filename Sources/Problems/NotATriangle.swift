import Foundation

// https://www.codechef.com/problems/NOTATRI
// 20 min

func notATriangle(sticks: [Int]) -> Int {
    var totalCount = 0
    for stick in sticks {
        var badPairs = 0
        for i in 0..<sticks.count {
            let a = sticks[i]
            for j in i+1..<sticks.count {
                let b = sticks[j]
                if a + b < stick { badPairs += 1 }
            }
        }
        totalCount += badPairs
    }
    return totalCount
}

// + 15 min
// really not much improvments
func notATriangleFast(sticks: [Int]) -> Int {
    let sticks = sticks.sorted().reversed()
    var totalCount = 0
    for (i, c) in sticks.enumerated() {
        var badPairs = 0
        for (j, a) in sticks.dropFirst(i + 1).enumerated() {
            badPairs +=
                sticks
                .dropFirst(i + j + 2)
                .drop(while: { b in c <= a + b })
                .count
        }
        totalCount += badPairs
    }
    return totalCount
}

// + 1 hr 15 min

extension RandomAccessCollection where Self.Index == Int {
    /// required that if predicate of [i] == false,
    /// for all j > i [j] == false
    func binarySearchIndex(predicate: (Element) -> Bool) -> Int? {
        print("binarySearchIndex", self)
        print(self.map(predicate))
        guard !isEmpty else { return nil }
        guard count != 1 else {
            return predicate(first!) ? 0 : nil
        }
        let center = count / 2
        print("center", center)
        print("right", count/2+1..<count)
        print("left", 0..<count/2)
        return
            predicate(self[center])
            ?
                self[count/2+1..<count].binarySearchIndex(predicate: predicate)
                .map { 1 + center + $0 }
                .default(value: center)
            :
                self[0..<count/2].binarySearchIndex(predicate: predicate)
    }
}

extension Optional {
    func `default`(value: Wrapped) -> Wrapped {
        switch self {
        case nil: return value
        case .some(let value): return value
        }
    }
}

// strange index out of bounds error happens. Need to use lldb
func notATriangleBinarySearch(sticks: [Int]) -> Int {
    let sticks = Array(sticks.sorted().reversed())
    var totalCount = 0
    for (i, c) in sticks.enumerated() {
        var badPairs = 0
        for (j, a) in sticks.dropFirst(i + 1).enumerated() {       
            print("i", i, "j", j)
            let candidates = sticks.dropFirst(i + j + 2)
            print("start", candidates)
            let dontSatisfy =
                candidates
                .binarySearchIndex(predicate: { b in c <= a + b })
                .map { $0 + 1 } // index -> count
                .default(value: candidates.count)
            print("end")
            badPairs += candidates.count - dontSatisfy
            print("dont satisfy:", dontSatisfy)
        }
        totalCount += badPairs
    }
    return totalCount
}