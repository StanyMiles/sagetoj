import Foundation

struct Player: Identifiable {
  let id: UUID = UUID()
  let name: String
}

extension Player {
  static var dummy = Player(name: "")
}
