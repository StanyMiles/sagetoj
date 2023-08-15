import SwiftUI

struct TextInputView: View {
  let onSubmit: (String) -> Void
  @State private var input = ""
  
  var body: some View {
    VStack(spacing: 20) {
      TextField("Player name", text: $input)
        .textFieldStyle(.roundedBorder)
        .onSubmit {
          handleSubmit()
        }
      Button("Add player") {
        handleSubmit()
      }
    }
    .padding()
  }
  
  private func handleSubmit() {
    onSubmit(input)
    input = ""
  }
}

struct TextInputView_Previews: PreviewProvider {
  static var previews: some View {
    TextInputView() { _ in }
  }
}
