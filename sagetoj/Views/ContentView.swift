import SwiftUI

struct ContentView: View {
  @ObservedObject private var coordinator = Coordinator()
  @StateObject private var gameStore = GameStore()
  
  var body: some View {
    NavigationStack(path: $coordinator.path) {
      StarterView()
        .navigationDestination(for: Navigation.self) { navigation in
          switch navigation {
            case .players:
              PlayersView()
            case .scoreSelection:
              ScoreSelectionView()
            case .game:
              GameView(viewModel: .init( // TODO: move to factory
                players: gameStore.players,
                totalScore: gameStore.totalScore
              ))
            case .restart:
              StarterView()
          }
        }
    }
    .environmentObject(coordinator)
    .environmentObject(gameStore)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
