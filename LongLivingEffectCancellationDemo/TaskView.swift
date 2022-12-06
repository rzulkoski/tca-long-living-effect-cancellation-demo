import ComposableArchitecture
import SwiftUI

struct Task: ReducerProtocol {
	struct State: Equatable {}

	enum Action {
		case onNotificationReceived(Notification)
		case sendButtonTapped
		case task
	}

	@Dependency(\.notificationCenterClient) var notificationCenterClient

	var body: some ReducerProtocol<State, Action> {
		Reduce { state, action in
			switch action {
			case let .onNotificationReceived(notification):
				print("Received notification named \"\(notification.name.rawValue)\"")
				return .none

			case .sendButtonTapped:
				self.notificationCenterClient.post(Notification(name: .task))
				return .none

			case .task:
				return Effect.run { send in
					let notifications = self.notificationCenterClient
						.observe([
							.task
						])
					for await notification in notifications {
						await send(.onNotificationReceived(notification))
					}
				}
			}
		}
	}
}

struct TaskView: View {
	let store: StoreOf<Task>

	var body: some View {
		WithViewStore(self.store) { viewStore in
			Text("Task View")
				.task { await viewStore.send(.task).finish() }
				.toolbar {
					Button(action: { viewStore.send(.sendButtonTapped) }) {
						Image(systemName: "paperplane.circle")
					}
				}
		}
	}
}
