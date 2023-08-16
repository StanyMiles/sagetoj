import SwiftUI

struct GameView: View {
  @EnvironmentObject private var coordinator: Coordinator
  @StateObject var viewModel: ViewModel
  @FocusState private var isFocused: Bool
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        HStack(spacing: 30) {
          ForEach(viewModel.scores) { playerScore in
            VStack {
              Text(playerScore.player.name)
                .font(.headline)
              Text(String(playerScore.score))
                .font(.title.bold())
            }
            .foregroundColor(viewModel.isActive(playerScore.player) ? .green : .black)
          }
        }
        
        HStack(spacing: 40) {
          throwView("Throw 1", isActive: viewModel.throwCount == 1)
          throwView("Throw 2", isActive: viewModel.throwCount == 2)
          throwView("Throw 3", isActive: viewModel.throwCount == 3)
        }
        
        TextField("Input", text: $viewModel.throwResult)
          .multilineTextAlignment(.center)
          .keyboardType(.numberPad)
          .textFieldStyle(.roundedBorder)
          .font(.largeTitle)
          .focused($isFocused)
          .padding(.horizontal, 30)
          .onSubmit(onAddScore)
        
        VStack {
          Toggle("Double", isOn: $viewModel.isDouble)
          Toggle("Triple", isOn: $viewModel.isTriple)
        }
        .padding(.horizontal)
        
        Button("Add score", action: onAddScore)
          .font(.largeTitle)
          .buttonStyle(.borderedProminent)
        
        HStack(spacing: 40) {
          Button("Add Single BULL", action: viewModel.onSingleBull)
          Button("Add Double BULL", action: viewModel.onDoubleBull)
        }
        .buttonStyle(.bordered)
      }
    }
    .navigationTitle("Throw your darts")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .onReceive(viewModel.$isDouble) { isDouble in
      guard isDouble else { return }
      if viewModel.isTriple {
        viewModel.isTriple = false
      }
    }
    .onReceive(viewModel.$isTriple) { isTriple in
      guard isTriple else { return }
      if viewModel.isDouble {
        viewModel.isDouble = false
      }
    }
    .alert(
      "Gamer over!",
      isPresented: $viewModel.presentWinnerAlert,
      presenting: viewModel.winner
    ) { _ in
      Button("Restart", action: coordinator.restart)
    } message: { player in
      Text("Winner is \(player.name)")
    }
  }
  
  private func throwView(_ text: String, isActive: Bool) -> some View {
    VStack {
      Text(text)
        .font(isActive ? .title.bold() : .title2)
      
    }
  }
  
  private func onAddScore() {
    isFocused = false
    viewModel.onAddScore()
  }
}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      GameView(viewModel: .init(
        players: [
          Player(name: "Player 1"),
          Player(name: "Player 2"),
          Player(name: "Player 3"),
        ],
        totalScore: 301
      ))
      .environmentObject(Coordinator())
    }
  }
}
