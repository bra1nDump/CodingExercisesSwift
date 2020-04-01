import XCTest
@testable import Problems

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

    static var allTests = [
        //("testPow", testPow),
        //("testMarbles", testMarbles),
        //("testNextPalindromeHelpers", testNextPalindromeHelpers),
        //("testSplit", testSplit),
        ("testIncrementAt", testIncrementAt),
        ("testNextSimplePalindrome", testNextSimplePalindrome),
        ("testNextPalindrome", testNextPalindrome)
    ]
}
