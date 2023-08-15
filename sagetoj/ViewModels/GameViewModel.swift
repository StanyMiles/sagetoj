import Foundation

extension GameView {
  final class ViewModel: ObservableObject {
    @Published var scores: [PlayerScore]
    @Published var activePlayer: Player
    @Published var throwCount = 1
    @Published var throwResult = ""
    @Published var isDouble = false
    @Published var isTriple = false
    @Published var presentWinnerAlert = false
    @Published var winner: Player?
    
    init(
      players: [Player],
      totalScore: Int
    ) {
      self.scores = players.map {
        PlayerScore(player: $0, score: totalScore)
      }
      self.activePlayer = players[0]
    }
    
    func isActive(_ player: Player) -> Bool {
      player.id == activePlayer.id
    }
    
    func onAddScore() {
      guard var throwResult = Int(throwResult) else { return }
      
      guard (0...20).contains(throwResult) else {
        // TODO: indicate not allowed input (alert/red border on TextField?)
        return
      }
 
      switch (isDouble, isTriple) {
        case (true, false):
          throwResult *= 2
        case (false, true):
          throwResult *= 3
        default:
          break
      }
      
      addScore(throwResult)
    }
    
    func onSingleBull() {
      addScore(.singleBull)
    }
    
    func onDoubleBull() {
      addScore(.doubleBull)
    }
    
    private func addScore(_ throwResult: Int) {
      for (index, score) in scores.enumerated() {
        if isActive(score.player) {
          var score = score
          score.score = abs(score.score - throwResult)
          scores[index] = score
          break
        }
      }
      
      checkForWinner()
      
      switch throwCount {
        case 3:
          throwCount = 1
          let playersCount = scores.count
          for (index, score) in scores.enumerated() {
            if isActive(score.player) {
              if index == playersCount - 1 {
                activePlayer = scores[0].player
              } else {
                activePlayer = scores[index + 1].player
              }
              break
            }
          }
        default:
          throwCount += 1
      }
      
      clear()
    }
    
    private func checkForWinner() {
      for score in scores {
        if score.score == 0 {
          winner = score.player
          presentWinnerAlert = true
          break
        }
      }
    }
    
    private func clear() {
      throwResult.removeAll()
      isDouble = false
      isTriple = false
    }
  }
}

private extension Int {
  static let singleBull = 25
  static let doubleBull = 50
}
