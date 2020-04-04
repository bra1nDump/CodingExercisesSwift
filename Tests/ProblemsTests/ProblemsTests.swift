import XCTest
@testable import Problems

    // TODO: refactor to use this
extension Array {
    func outputsMatch<Input, Output>(runner: (Input) -> Output)
        where Element == (Input, Output), Output: Equatable {
            self.forEach { XCTAssertEqual(runner($0), $1) }
    }

    func outputsMatch<Arg1, Arg2, Output>(runner: (Arg1, Arg2) -> Output)
        where Element == (Arg1, Arg2, Output), Output: Equatable {
            self.forEach { XCTAssertEqual(runner($0, $1), $2) }
    }

    func outputsMatch<Arg1, Arg2, Arg3, Output>(runner: (Arg1, Arg2, Arg3) -> Output)
        where Element == (Arg1, Arg2, Arg3, Output), Output: Equatable {
            self.forEach { XCTAssertEqual(runner($0, $1, $2), $3) }
    }
}



final class ProblemsTests: XCTestCase {
    func testPow() {
        XCTAssertEqual(pow(1, 0), 1)
        XCTAssertEqual(pow(3, 2), 9)
    }

    func testMarbles() {
        XCTAssertEqual(MarblesMath().solve(marbles: 10, colors: 10), 1)
        XCTAssertEqual(MarblesMath().solve(marbles: 10, colors: 9), 9)
        XCTAssertEqual(MarblesMath().solve(marbles: 4, colors: 3), 6)
        XCTAssertEqual(MarblesMath().solve(marbles: 6, colors: 4), 10)
        //XCTAssertEqual(MarblesMath().solve(marbles: 30, colors: 7), 475020)
    }

    func testNextPalindromeHelpers() {
        // helpers
        [
            ("0", true),
            ("11", true),
            ("121", true),
            ("12", false),
        ]
        .forEach({ XCTAssertEqual(isPalindrome($0), $1) })

        XCTAssert(increment(character: "0") == "1")
    }

    func testNextSimplePalindrome() {
        [
            // simple edge cases
            ("0", "1"),
            ("1", "2"),

            ("123321", "124421"),
            ("139931", "140041"),
        ]
        .forEach({ XCTAssertEqual(makeSimplePalindrome(Array($0)), Array($1)) })
    }

    func testSplit() {
        [
            ("1", ("", "1", "")),
            ("11", ("1", nil, "1")),
            ("111", ("1", "1", "1")),
            ("1111", ("11", nil, "11")),
        ]
        .forEach { XCTAssert(split(digits: $0) == $1) }
    }

    func testIncrementAt() {
        [
            (0, "11", "22"),
            (0, "111", "202"),
            (1, "11111", "12021"),
        ]
        .forEach({ XCTAssertEqual(increment(at: $0, digits: $1), $2) })
    }

    func testNextPalindrome() {
        [
            // simple edge cases
            ("0", "1"),
            ("1", "2"),
            ("9", "11"),
            ("99", "101"),
            // incremented center area, right side
            ("8429", 
             "8448"),
            // incremented center area, both sides
            ("8229", 
             "8338"),
            // cant increment center, incremented flag element, zeroed center
            ("8999", 
             "9009"),

            ("181", "191"),
            ("1991", "2002"),
            ("1341", "1441"),
        ]
        .forEach({ XCTAssertEqual(nextPalindrome($0), $1) })
    }

    // code crazy millions

    func testCodeCrazyMinions() {
        XCTAssertEqual(CodeCrazyMinions().solve(input: "helloworld"), "NO")
        XCTAssertEqual(CodeCrazyMinions().solve(input: "mississippi"), "YES")
    }

    func testFitToPlay() {
        [
            ([3, 7, 1, 4, 2, 4], "4"),
            ([5, 4, 3, 2, 1], "UNFIT"),
            ([4, 3, 2, 2, 3], "1"),
        ]
        .outputsMatch(runner: fitToPlay)
    }

    func testChefAndStones() {
        [
            (10, [3, 4, 5], [4, 4, 5], 12)
        ]
        .outputsMatch(runner:chefAndStones)
    }

    func testLittleElephantAndStrings() {
        XCTAssertEqual(
            littleElephantAndStrings(
                as: [
                    "47",
                    "744",
                ],
                bs: [
                    "7444",
                    "447",
                    "7774",
                    "77777777777777777777777777777777777777777777774"
                ]
            ),
            [
                "Good",
                "Good",
                "Bad",
                "Good",
            ]
        )
    }

    func testStone() {
        XCTAssertEqual(
            stone(turns: 1, array: [5, -1, 7, 0]),
            [2, 8, 0, 7]
        )
    }

    func testLittleChefAndSums() {
        [
            ([1, 2, 3], 1),
            ([2, 1, 3, 1], 2),
        ]
        .outputsMatch(runner: littleChefAndSums)
    }

    func testShortestPathInBinaryTrees() {
        [
            (1, 2, 1),
            (2, 3, 2),
            (4, 3, 3),
        ]
        .outputsMatch(runner: shortestPathInBinaryTrees)
    }

    func testNotATriangle() {
        [
            ([4, 2, 10], 1),
            ([1, 2, 3], 0),
            ([5, 2, 9, 6], 2),
        ]
        .outputsMatch(runner: notATriangleBinarySearch)
    }

    func testBinarySearchIndex() {
        func binarySearchIndex(array: [Int], stepFunc: (Int) -> Bool) -> Int? {
            array.binarySearchIndex(predicate: stepFunc)
        }

        // returns last index where true or nil
        [
            ([0, 1], { $0 < 2 }, 1),
            ([0, 3], { $0 < 2 }, 0),
            // not nesseseraly sorted, just predicate needs to 
            // be a unit step function
            ([2, 2], { $0 < 2 }, nil),
            ([2, 2, 2], { $0 < 2 }, nil),
            ([1, 2, 2], { $0 < 2 }, 0),
            ([1, 1, 2], { $0 < 2 }, 1),
            ([5, 2],    { $0 > 4 }, 0),
        ]
        .outputsMatch(runner: binarySearchIndex)
    }

    func testRecepieReconstruction() {
        [
            ("?", 26),
            ("??", 26),
            ("ab?", 1),
            ("a?c", 0),
            ("aba", 1),
        ]
        .outputsMatch(runner: recepieReconstruction)
    }

    ///   7       -> 7
    ///  3   8    -> 5.5
    /// 1 4   19   -> 8
    func testTreeLevelAvarages() {
        let tree = Node(
            value: 7,
            left: Node(
                value: 3,
                left: Node(value: 1),
                right: Node(value: 4)
            ),
            right: Node(
                value: 8,
                right: Node(value: 19)
            )
        )
        XCTAssertEqual(
            treeLevelAvarages(root: tree),
            [ 7, 5.5, 8 ]
        )
    }

    static var allTests = [
        ("treeLevelAvarages", testTreeLevelAvarages),
        //("testPow", testPow),
        //("testMarbles", testMarbles),
        //("testNextPalindromeHelpers", testNextPalindromeHelpers),
        //("testSplit", testSplit),
        // ("testIncrementAt", testIncrementAt),
        // ("testNextSimplePalindrome", testNextSimplePalindrome),
        // ("testNextPalindrome", testNextPalindrome)
        //("testCodeCrazyMinions", testCodeCrazyMinions)
        // ("fitToPlay", testFitToPlay)
        //("chefAndStones", testChefAndStones)
        //("testLittleElephantAndStrings", testLittleElephantAndStrings)
        //("stone", testStone),
        //("littleChefAndSums", testLittleChefAndSums)
        //("shortestPathInBinaryTrees", testShortestPathInBinaryTrees),
        //("testBinarySearchIndex", testBinarySearchIndex),
        //("notATriangle", testNotATriangle)
        //("recepieReconstruction", testRecepieReconstruction),
    ]
}
