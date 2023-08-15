import SwiftUI

struct StarterView: View {
  @EnvironmentObject private var coordinator: Coordinator
  
  var body: some View {
    Button("Start game") {
      coordinator.start()
    }
  }
}

struct StarterView_Previews: PreviewProvider {
  static var previews: some View {
    StarterView()
  }
}
