import SwiftUI

extension View {
  func toolbarNextButton(
    disabled: Bool,
    action: @escaping () -> Void
  ) -> some View {
    toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Next", action: action)
          .disabled(disabled)
      }
    }
  }
}
