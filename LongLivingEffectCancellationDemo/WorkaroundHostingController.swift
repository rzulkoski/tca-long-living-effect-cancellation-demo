import ComposableArchitecture
import SwiftUI
import UIKit

class WorkaroundHostingController<Content>: UIHostingController<Content> where Content: View {
	deinit {
		if let tearDownableView = self.rootView as? any TearDownableView {
			tearDownableView.tearDown()
		}
	}
}

public protocol TearDownableView: View {
	associatedtype State
	associatedtype Action: TearDownableAction

	var store: Store<State, Action> { get }
}

public protocol TearDownableAction: Equatable {
	static var tearDown: Self { get }
}

public extension TearDownableView {
	func tearDown() {
		ViewStore(store.stateless).send(.tearDown)
	}
}
