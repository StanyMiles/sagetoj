import Foundation

struct PlayerScore: Identifiable {
  let id: UUID = .init()
  let player: Player
  var score: Int
}
