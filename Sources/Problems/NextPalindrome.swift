public func runNextPalindrome() {
    let tests = Int(readLine()!)!
    for _ in (0..<tests) {
        print(nextPalindrome(readLine()!))
    }
}

// string considered to be well formed?
func nextPalindrome(_ integer: String) -> String {
    String(nextPalindrome(Array(integer)))
}

func nextPalindrome(_ digits: [Character]) -> [Character] {
    guard digits.firstIndex(where: { $0 != "9" }) != nil else {
        return
            [ "1" ]
            + Array(repeating: "0", count: digits.count - 1)
            + [ "1" ]
    }

    // last index in first half where d[i] < d[-i]
    var maybeIncrementCandidate: Int?
    for i in 0..<digits.count / 2 {
        if digits[i] < digits[digits.count - i - 1] {
            maybeIncrementCandidate = i
        }
    }

    // if not found simpler case can be considered
    guard let incrementCandidate = maybeIncrementCandidate else {
        return makeSimplePalindrome(digits)
    }

    // check if center component can be incremented
    let incrementCandidateTwin = digits.count - incrementCandidate - 1
    let center = Array(digits[incrementCandidate + 1 ..< incrementCandidateTwin])
    if center.first(where: { $0 != "9" }) != nil {
        let prefix = Array(digits[0..<incrementCandidate])
        return
            prefix
            + [ digits[incrementCandidate] ]
            + makeSimplePalindrome(center)
            + [ digits[incrementCandidate] ]
            + Array(prefix.reversed())
    }

    // last case ex: 
    // * 123 4 999 8 391
    // * 123 4     8 391
    return increment(at: incrementCandidate, digits: digits)
}

func split(digits: String) -> (String, Character?, String) {
    let result = split(digits: Array(digits))
    return (String(result.0), result.1, String(result.2))
}

func split(digits: [Character]) -> ([Character], Character?, [Character]) {
    let firstHalf = Array(digits[0..<digits.count/2])
    let center = digits.count % 2 == 0 ? nil : digits[digits.count/2]
    let secondHalf = Array(digits[(digits.count + 1)/2..<digits.count])
    return (firstHalf, center, secondHalf)
}

func increment(character: Character) -> Character {
    Character(String(Int("\(character)")! + 1))
}

func increment(at: Int, digits: String) -> String {
    String(increment(at: at, digits: Array(digits)))
}

func increment(at incrementAt: Int, digits: [Character]) -> [Character] {
    let (firstHalf, center, _) = split(digits: digits)
    // construct new first half 
    let newFirstHalf = 
        Array(firstHalf[0..<incrementAt])
        + [ increment(character: firstHalf[incrementAt]) ]
        + Array(repeating: "0", count: firstHalf.count - incrementAt - 1)

    return 
        newFirstHalf
        + (center != nil ? [ "0" ] : [])
        + Array(newFirstHalf.reversed())
}

/// prerequisite digits
///   * doesn't consist only of 9s
///   * left half is lexographically less or equal than reversed right half
func makeSimplePalindrome(_ digits: [Character]) -> [Character] {
    let (firstHalf, center, secondHalf) = split(digits: digits)

    if firstHalf != Array(secondHalf.reversed()) {
        // copying & reversing the first half will do 
        return firstHalf
            + (center == nil ? [] : [ center! ])
            + Array(firstHalf.reversed())
    }
    
    // two halfs are the same, try incrementing the center
    if let center = center, center != "9" {
        return firstHalf
            + [ increment(character: center) ]
            + firstHalf.reversed()
    }

    // 1239 9 9321 - need to increment first index that is not 9
    let incrementAt = firstHalf.lastIndex(where: { $0 != "9" })!
    return increment(at: incrementAt, digits: digits)
}

func isPalindrome(_ digits: String) -> Bool {
    isPalindrome(Array(digits))
}

func isPalindrome(_ digits: [Character]) -> Bool {
    let digits = Array(digits)
    let count = digits.count
    for i in (0 ..< count / 2) {
        if digits[i] != digits[count - i - 1] { return false }
    }
    return true
}