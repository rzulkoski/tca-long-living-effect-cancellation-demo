import SwiftUI

extension View {
	func onFirstAppear(perform: @escaping () async -> Void) -> some View {
		self.modifier(OnFirstAppear(perform: perform))
	}
}

private struct OnFirstAppear: ViewModifier {
	let perform: () async -> Void
	@State private var didAppear = false

	func body(content: Content) -> some View {
		content.task {
			if !self.didAppear {
				self.didAppear = true
				await self.perform()
			}
		}
	}
}
