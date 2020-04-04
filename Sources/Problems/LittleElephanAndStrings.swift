import Foundation

func littleElephantAndStrings(`as`: [String], bs: [String]) -> [String] {
    bs.map { b in
        b.count >= 47
        || `as`.map { a in b.contains(a) }
        .contains(true)
        ?
        "Good" : "Bad"
    }
}