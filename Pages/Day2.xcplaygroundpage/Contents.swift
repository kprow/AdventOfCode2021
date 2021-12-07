import Foundation
struct Position {
    var horizontal: Int
    var depth: Int
    var depthPart1: Int
    var aim: Int
    init() {
        horizontal = 0
        depthPart1 = 0
        depth = 0
        aim = 0
    }
    mutating func update(move: Move) {
        switch move {
        case .forward(units: let units):
            horizontal += units
            depth += aim * units
        case .down(units: let units):
            depthPart1 += units
            aim += units
        case .up(units: let units):
            depthPart1 -= units
            aim -= units
        }
    }
    enum Move {
        case forward(units: Int)
        case down(units: Int)
        case up(units: Int)
        init(line: String) {
            let parts = line.split(separator: " ")
            let direction = String(parts[0])
            guard let units = Int(parts[1]) else {
                self = .forward(units: 0)
                return
            }
            switch direction {
            case "forward":
                self = .forward(units: units)
            case "down":
                self = .down(units: units)
            case "up":
                self = .up(units: units)
            default:
                self = .forward(units: 0)
            }
        }
    }
}
if let path = Bundle.main.path(forResource: "input", ofType: "txt") {
    let input = try? String(contentsOfFile: path, encoding: .utf8)
    var postion = Position()
    input?.enumerateLines { moveString, _ in
        postion.update(move: Position.Move(line: moveString))
    }
    print( postion.horizontal * postion.depthPart1 )
    print( postion.horizontal * postion.depth )
}
