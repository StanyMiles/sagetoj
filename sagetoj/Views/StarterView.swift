import SwiftUI

struct StarterView: View {
  @EnvironmentObject private var coordinator: Coordinator
  
  var body: some View {
    Button("Start game", action: coordinator.start)
      .buttonStyle(.borderedProminent)
      .font(.title)
  }
}

struct StarterView_Previews: PreviewProvider {
  static var previews: some View {
    StarterView()
      .environmentObject(Coordinator())
  }
}
