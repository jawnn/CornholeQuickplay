import Foundation

class Pitcher {
    var name: String
    var frames: [FrameStat] = []

    var totalScore: Int = 0
    var totalOnBoard: Int = 0
    var totalOffBoard: Int = 0
    var totalCornholes: Int = 0
    var matchPlusMinus: Int = 0

    var averageScore: Double {

        return Double(self.totalScore) / Double(self.frames.count)
    }

    var efficientcyRating: Double {
        let totalTosses = Double(frames.count * 4)
        let perfectScore = Double(totalTosses * 3)
        return Double(totalScore) / perfectScore
    }

    init(name: String) {
        self.name = name
    }

    func incrementStats(with frame: FrameStat) {
        totalScore += frame.score
        totalOnBoard += frame.onBoard
        totalOffBoard += frame.offBoard
        totalCornholes += frame.cornholes
        matchPlusMinus += frame.plusMinus
        frames.append(frame)
    }

}
