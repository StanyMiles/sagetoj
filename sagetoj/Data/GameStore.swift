import Foundation

final class GameStore: ObservableObject {
  var players: [Player] = []
  var totalScore: Int = -1
}
