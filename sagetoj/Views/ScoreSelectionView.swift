import SwiftUI

struct ScoreSelectionView: View {
  @EnvironmentObject private var coordinator: Coordinator
  @EnvironmentObject private var gameStore: GameStore
  
  var body: some View {
    VStack(spacing: 30) {
      Button("301") {
        setScore(301)
      }
      Button("501") {
        setScore(501)
      }
      Button("1001") {
        setScore(1001)
      }
    }
    .font(.largeTitle.bold())
    .navigationTitle("Select score")
  }
  
  func setScore(_ value: Int) {
    gameStore.totalScore = value
    coordinator.play()
  }
}

struct ScoreSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ScoreSelectionView()
    }
  }
}
