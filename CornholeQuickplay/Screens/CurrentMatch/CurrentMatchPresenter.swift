import UIKit

protocol CurrentMatchPresenterType: UITableViewDataSource, ScoreOutcomeDelegate {
    var currentMatch: Match { get }
    func sendNewMatchData()
    func startNextFrame()
    func sendNewFrameData()
    func didTeamReachScoreLimit()
}

protocol CurrentMatchViewType {
    func showMatchDetails()
    func reloadFrameHistoryData()
    func insertFrameRowAtTopOfTable()
    func updateScore(for stepper: ScoreStepperTag, with value: Int, frameScore: Int)
    func populateViewsForNextFrame(bluePitcher name: String, redPitcher name: String, blueTeam score: Int, redTeam score: Int)
}

class CurrentMatchPresenter: NSObject, CurrentMatchPresenterType {
    var view: CurrentMatchViewType
    var model: CurrentMatchModelType

    var currentMatch: Match

    init(model: CurrentMatchModelType, view: CurrentMatchViewType) {
        self.model = model
        self.view = view

        self.currentMatch = model.currentMatch
    }

    func sendNewMatchData() {
        let newMatch = model.currentMatch.matchType == . single ? Match.generateSinglesTestMatch() : Match.generateDoublesTestMatch()
        self.currentMatch = newMatch
        model.currentMatch = newMatch
        model.redTeam = newMatch.redTeam
        model.blueTeam = newMatch.blueTeam
        model.redPitcher = newMatch.redTeam.players[newMatch.currentPitcherIndex]
        model.bluePitcher = newMatch.blueTeam.players[newMatch.currentPitcherIndex]
        model.currentFrame = Frame(frame: newMatch.currentFrameNumber, bluePitcher: FrameStat(pitcher: model.bluePitcher), redPitcher: FrameStat(pitcher: model.redPitcher))

        sendNewFrameData()
        view.reloadFrameHistoryData()
    }

    func sendNewFrameData() {
        view.populateViewsForNextFrame(
            bluePitcher: model.blueTeam.players[model.currentPitcherIndex].name,
            redPitcher: model.redTeam.players[model.currentPitcherIndex].name,
            blueTeam: model.currentMatch.blueTeam.score,
            redTeam: model.currentMatch.redTeam.score
        )
    }

    func didTeamReachScoreLimit() {
        recordFrameResults()
        if model.blueTeam.score < 21 && model.redTeam.score < 21 {
            startNextFrame()
        } else {
            model.currentMatch.setWinningTeam()
            view.showMatchDetails()
        }
    }

    func startNextFrame() {
        model.currentMatch.currentFrameNumber += 1
        if model.currentMatch.matchType == .doubles {
            model.bluePitcher = model.currentMatch.blueTeam.players[model.currentPitcherIndex]
            model.redPitcher = model.currentMatch.redTeam.players[model.currentPitcherIndex]
        }
        let frame = Frame(frame: model.currentMatch.currentFrameNumber, bluePitcher: FrameStat(pitcher: model.bluePitcher), redPitcher: FrameStat(pitcher: model.redPitcher))
        model.currentFrame = frame

        sendNewFrameData()
        view.insertFrameRowAtTopOfTable()
    }

    func recordFrameResults() {
        let currentFrame = model.currentFrame
        let pointsThisFrame = currentFrame.generateFrameScore()

        model.currentMatch.generateMatchSore(scoringTeam: currentFrame.scoringTeam, points: pointsThisFrame)
        model.redPitcher.incrementStats(with: currentFrame.redFrame)
        model.bluePitcher.incrementStats(with: currentFrame.blueFrame)
        model.currentMatch.frames.insert(currentFrame, at: 0)
    }

}

extension CurrentMatchPresenter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.currentMatch.frames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FrameTableCell.self)) as? FrameTableCell else {
            return UITableViewCell()
        }

        let currentFrame = model.currentMatch.frames[indexPath.row]
        cell.layoutViewConfigurations(scoringTeam: currentFrame.scoringTeam)
        cell.frameOutcomeLabel.text = "+\(currentFrame.generatePlusMinus())"
        cell.bluePitcherLabel.text = currentFrame.blueFrame.pitcher.name
        cell.blueScoreLabel.text = "\(currentFrame.blueFrame.score)"
        cell.redPitcherLabel.text = currentFrame.redFrame.pitcher.name
        cell.redScoreLabel.text = "\(currentFrame.redFrame.score)"
        cell.frameNumberLabel.text = "Fr. \(currentFrame.frameNumber)"
        return cell
    }
}

extension CurrentMatchPresenter {
    func updateScoreModel(for stepperTag: ScoreStepperTag, with newValue: Int) {
        switch stepperTag {
        case .onBlue:
            model.currentFrame.blueFrame.onBoard = newValue
            view.updateScore(for: .onBlue, with: newValue, frameScore: model.currentFrame.blueFrame.score)
        case .inBlue:
            model.currentFrame.blueFrame.cornholes = newValue
            view.updateScore(for: .inBlue, with: newValue, frameScore: model.currentFrame.blueFrame.score)
        case .onRed:
            model.currentFrame.redFrame.onBoard = newValue
            view.updateScore(for: .onRed, with: newValue, frameScore: model.currentFrame.redFrame.score)
        case .inRed:
            model.currentFrame.redFrame.cornholes = newValue
            view.updateScore(for: .inRed, with: newValue, frameScore: model.currentFrame.redFrame.score)
        }
    }
}

