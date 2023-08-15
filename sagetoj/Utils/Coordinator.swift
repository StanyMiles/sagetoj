import SwiftUI

enum Navigation: Hashable {
  case players, scoreSelection, game, restart
}

final class Coordinator: ObservableObject {
  @Published var path = NavigationPath()
  
  func start() {
    path = .init([Navigation.players])
  }
  
  func selectScore() {
    path.append(Navigation.scoreSelection)
  }
  
  func play() {
    path = NavigationPath([Navigation.game])
  }
  
  func restart() {
    path.removeLast(path.count)
  }
}
