// https://www.codechef.com/problems/CHEFSUM
// 7 min

func littleChefAndSums(array: [Int]) -> Int {
    array.firstIndex { $0 == array.min() }! + 1
}