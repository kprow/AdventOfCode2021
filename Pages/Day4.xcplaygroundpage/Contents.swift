import Foundation
class Board {
    class Space {
        var number: Int
        var isMarked: Bool
        init(_ num: Int) {
            number = num
            isMarked = false
        }
        var description: String {
            return isMarked ? "x\(number)".padding(toLength: 4, withPad: " ", startingAt: 0) : "\(number)".padding(toLength: 4, withPad: " ", startingAt: 0)
        }
    }
    class Row {
        var spaces: [Space]
        init(values: [Int]) {
            spaces = []
            for value in values {
                spaces.append(Space(value))
            }
        }
        var description: String {
            var desc = ""
            spaces.forEach { desc += "\($0.description) " }
            return desc
        }
        var allSpacesMarked: Bool {
            return spaces.allSatisfy{ $0.isMarked }
        }
    }
    var rows: [Row]
    init(lines: [String]) {
        rows = []
        for line in lines {
            let newRow = Row( values: line.split(separator: " ", maxSplits: 5, omittingEmptySubsequences: true).map { Int($0)! } )
            rows.append(newRow)
        }
    }
    func drawNumber(_ number: Int) {
        for row in rows {
            for space in row.spaces {
                if space.number == number {
                    space.isMarked = true
                }
            }
        }
    }
    var description: String {
        var desc = ""
        rows.forEach { desc += "\($0.description)\n" }
        return desc
    }
    var isWinner: Bool {
        return rowMarked || columnMarked
    }
    var rowMarked: Bool {
        return rows.filter{ $0.allSpacesMarked }.count > 0
    }
    func column(index: Int) -> [Space] {
        var spaces: [Space] = []
        rows.forEach { spaces.append($0.spaces[index]) }
        return spaces
    }
    var allColumns: [[Space]] {
        var columns: [[Space]] = []
        for i in 0..<5 {
            columns.append(column(index: i))
        }
        return columns
    }
    var columnMarked: Bool {
        var isMarked = false
        for column in allColumns {
            if column.allSatisfy({ $0.isMarked }) {
                isMarked = true
            }
        }
        return isMarked
    }
    var unmarkedSpaces: [Space] {
        var unmarked: [Space] = []
        for row in rows {
            for space in row.spaces {
                if !space.isMarked { unmarked.append(space)}
            }
        }
        return unmarked
    }
}


if let path = Bundle.main.path(forResource: "input", ofType: "txt") {
    
    var input = try! String(contentsOfFile: path, encoding: .utf8).components(separatedBy: .newlines)
    
    let drawnNumbers = input.removeFirst().components(separatedBy: ",").map { Int($0)! }
    var boards: [Board] = []
    print( drawnNumbers )
    print( "=======")
    for (index, line) in input.enumerated() {
        if line.isEmpty && index != input.count - 1 {
            let newBoard = Board(lines: input[index + 1...index + 5].map { String($0) })
            boards.append(newBoard)
        }
    }
    boards.forEach { print($0.description) }
//    var currentNumber: Int!
//    var winningBoard: Board!
//    for drawnNumber in drawnNumbers {
//        currentNumber = drawnNumber
//        for board in boards {
//            board.drawNumber(drawnNumber)
//        }
//        if let winner = boards.filter({ $0.isWinner }).first {
//            winningBoard = winner
//            break
//        }
//    }
//    print(currentNumber!)
//    print(winningBoard.description)
//    let sumOfUnmarked = winningBoard.unmarkedSpaces.reduce(0, {$0 + $1.number})
//    print( sumOfUnmarked * currentNumber )
//    print( "=======")
    
    var currentNumber2: Int!
    var winningBoards: [Board] = []
    var winningBoardsIndex: [Int] = []
    let originalBoardsCount = boards.count
    for drawnNumber in drawnNumbers {
        currentNumber2 = drawnNumber
        for board in boards {
            board.drawNumber(drawnNumber)
        }
        for (index, board) in boards.enumerated() {
            if board.isWinner && !winningBoardsIndex.contains(index) {
                winningBoards.append(board)
                winningBoardsIndex.append(index)
            }
        }
        if winningBoards.count == originalBoardsCount {
            print("FOUND LAST")
            break
        }
    }
    print(currentNumber2!)
    print(winningBoards.last!.description)
    let sumOfUnmarkedLast = winningBoards.last!.unmarkedSpaces.reduce(0, {$0 + $1.number})
    print( sumOfUnmarkedLast * currentNumber2 )
}
