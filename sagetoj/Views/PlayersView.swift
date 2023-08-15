import SwiftUI

struct PlayersView: View {
  @EnvironmentObject private var coordinator: Coordinator
  @EnvironmentObject private var gameStore: GameStore
  @State private var players: [Player] = []
  
  var body: some View {
    VStack {
      TextInputView { playerName in
        guard !playerName.isEmpty else { return }
        let newPlayer = Player(name: playerName)
        withAnimation {
          players.append(newPlayer)
        }
      }
      
      HStack {
        Text("Don't forget to put players in correct order")
          .font(.footnote.italic())
          .foregroundColor(.gray)
        EditButton()
      }
      
      List {
        ForEach(players) { player in
          Text(player.name)
        }
        .onDelete(perform: deletePlayers)
        .onMove { from, to in
          players.move(fromOffsets: from, toOffset: to)
        }
      }
    }
    .navigationTitle("Players")
    .navigationBarBackButtonHidden(true)
    .toolbarNextButton(disabled: players.isEmpty) {
      gameStore.players = players
      coordinator.selectScore()
    }
  }
  
  func deletePlayers(at offsets: IndexSet) {
    players.remove(atOffsets: offsets)
  }
}

struct PlayersView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      PlayersView()
    }
  }
}
