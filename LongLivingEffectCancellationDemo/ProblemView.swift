import ComposableArchitecture
import SwiftUI

struct Problem: ReducerProtocol {
	struct State: Equatable {}

	enum Action {
		case onFirstAppear
		case onNotificationReceived(Notification)
		case sendButtonTapped
	}

	@Dependency(\.notificationCenterClient) var notificationCenterClient

	var body: some ReducerProtocol<State, Action> {
		Reduce { state, action in
			switch action {
			case .onFirstAppear:
				return Effect.run { send in
					let notifications = self.notificationCenterClient
						.observe([
							.problem
						])
					for await notification in notifications {
						await send(.onNotificationReceived(notification))
					}
				}

			case let .onNotificationReceived(notification):
				print("Received notification named \"\(notification.name.rawValue)\"")
				return .none

			case .sendButtonTapped:
				self.notificationCenterClient.post(Notification(name: .problem))
				return .none
			}
		}
	}
}

struct ProblemView: View {
	let store: StoreOf<Problem>

	var body: some View {
		WithViewStore(self.store) { viewStore in
			Text("Problem View")
				.onFirstAppear { viewStore.send(.onFirstAppear) }
				.toolbar {
					Button(action: { viewStore.send(.sendButtonTapped) }) {
						Image(systemName: "paperplane.circle")
					}
				}
		}
	}
}
