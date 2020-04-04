func fitToPlay(matches: [Int]) -> String {
    guard let goals = matches.first else { return "UNFIT" }
    var min = goals, max = goals, maxImprovment = 0

    // track min, if min is changed, max <- min, track max difference
    for goals in matches {
        if goals < min {
            min = goals; max = min;
        } else if goals > max {
            max = goals
        }
        let improvment = max - min
        if improvment > maxImprovment {
            maxImprovment = improvment
        }
    }

    return maxImprovment == 0 ? "UNFIT" : "\(maxImprovment)"
}