// https://www.codechef.com/problems/BINTREE
// 9 min

func shortestPathInBinaryTrees(i: Int, j: Int) -> Int {
    var i = i, j = j, path = 0
    while (i != j) {
        path += 1
        if i < j {
            j /= 2
        } else {
            i /= 2
        }
    }
    return path
}