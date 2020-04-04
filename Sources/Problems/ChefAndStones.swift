func chefAndStones(totalTime: Int, times: [Int], profits: [Int]) -> Int {
    zip(times, profits)
    .map { (time, profit) in 
        totalTime / time * profit
    }
    .max()!
}