import UIKit
struct MeasurementWindow {
    let length = 3
    var measurements: [Int] = []
    mutating func addMeasurement(_ measurement: Int) {
        if isComplete {
            measurements.removeFirst()
        }
        measurements.append(measurement)
    }
    var isComplete: Bool {
        return measurements.count == length
    }
    var total: Int {
        return measurements.reduce(0, +)
    }
    var description: String {
        return "Window \(measurements), total \(total)"
    }
}

if let path = Bundle.main.path(forResource: "input", ofType: "txt") {
    let input = try? String(contentsOfFile: path, encoding: .utf8)
    var previousDepth: Int? = nil
    var depthIncreases = 0
    var windowIncreases = 0
    var firstWindow = MeasurementWindow()
    var secondWindow = MeasurementWindow()
    input?.enumerateLines { depthString, _ in
        guard let depth = Int(depthString) else { return }
        guard let prevDepth = previousDepth  else { // Set up initial state for previous depth, and first window
            previousDepth = depth
            // Part 2
            firstWindow.addMeasurement(depth)
            return
        }
        if depth > prevDepth { depthIncreases += 1 }
        previousDepth = depth
        // Part 2
        secondWindow.addMeasurement(depth)
        if firstWindow.isComplete && secondWindow.isComplete {
            print("compare 1st \(firstWindow.description)\n     to 2nd \(secondWindow.description)\n----- -----")
            if secondWindow.total > firstWindow.total { windowIncreases += 1 }
        }
        firstWindow.addMeasurement(depth)
    }
    print(depthIncreases)
    print(windowIncreases)
}
