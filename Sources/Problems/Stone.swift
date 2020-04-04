// https://www.codechef.com/problems/RRSTONE

func stone(turns: Int, array: [Int]) -> [Int] {
    let max = array.max()!
    let array = array.map { max - $0 }
    let turnsLeft = turns - 1
    let newMax = array.max()!
    return turnsLeft % 2 == 0 ? array : array.map { newMax - $0 }
}