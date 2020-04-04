// https://www.codechef.com/problems/RRECIPE
// 20 min

func recepieReconstruction(recepie: String) -> Int {
    let recepie = Array(recepie)
    let count = recepie.count

    let centerHasVariation = 
        count % 2 == 1 && recepie[count / 2] == "?" ?
        1 : 0

    let freeCharacters: Int? = 
        zip(recepie[0..<count/2], recepie[count/2..<count].reversed())
        .reduce(.some(centerHasVariation), { (state, current) in
            switch state {
            case nil: return nil
            case .some(let count): 
                if current.0 != current.1 && current.0 != "?" && current.1 != "?" {
                    return nil
                }
                if current.0 == "?" && current.1 == "?" {
                    return count + 1
                }
                return count
            }
        })
    return freeCharacters
        .map { $0 * 26 }
        .map { $0 == 0 ? 1 : $0 }
        .default(value: 0)
}
