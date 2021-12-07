import Foundation
func remove(compare: String, index: Int, from: [String]) -> [String] {
    let removed = from.filter {
        Array($0)[index] == Array(compare)[index]
    }
    print(removed)
    if removed.count == 1 { return removed }
    return remove(compare: compare, index: index + 1, from: removed)
}
func sumBits(input: [String]) -> (sums: [Int], lengthOfBits: Int) {
    guard let first = input.first,
}
//if let path = Bundle.main.path(forResource: "input", ofType: "txt") {
if let path = Bundle.main.path(forResource: "reduced", ofType: "txt") {
    let input = try? String(contentsOfFile: path, encoding: .utf8)
//    var sumOfBits = [Int](repeating: 0, count: 12)
    var sumOfBits = [Int](repeating: 0, count: 5)
    var inputs: [String] = []
    input?.enumerateLines { binary, _ in
        print(binary)
        inputs.append(binary)
    }
    for (index, char) in binary.enumerated() {
        sumOfBits[index] += char.wholeNumberValue ?? 0
    }
    print( sumOfBits )
    var gamma = ""
    var epsillon = ""
    sumOfBits.forEach {
//        if $0 > 500 {
        if $0 > 6 {
            gamma += "1"
            epsillon += "0"
        } else {
            gamma += "0"
            epsillon += "1"
        }
    }
    print( gamma )
    print( epsillon )
    print( strtoul(gamma, nil, 2) * strtoul(epsillon, nil, 2) )
    let oxygen = remove(compare: gamma, index: 0, from: inputs)
    print(oxygen)
}
