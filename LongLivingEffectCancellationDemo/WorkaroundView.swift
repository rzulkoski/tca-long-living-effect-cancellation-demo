import ComposableArchitecture
import SwiftUI

struct Workaround: ReducerProtocol {
	struct State: Equatable {}

	enum Action: TearDownableAction {
		case onFirstAppear
		case onNotificationReceived(Notification)
		case sendButtonTapped
		case tearDown
	}

	@Dependency(\.notificationCenterClient) var notificationCenterClient

	var body: some ReducerProtocol<State, Action> {
		Reduce { state, action in
			struct TearDownId: Hashable {}

			switch action {
			case .onFirstAppear:
				return Effect.run { send in
					let notifications = self.notificationCenterClient
						.observe([
							.workaround
						])
					for await notification in notifications {
						await send(.onNotificationReceived(notification))
					}
				}.cancellable(id: TearDownId())

			case let .onNotificationReceived(notification):
				print("Received notification named \"\(notification.name.rawValue)\"")
				return .none

			case .sendButtonTapped:
				self.notificationCenterClient.post(Notification(name: .workaround))
				return .none

			case .tearDown:
				return .cancel(id: TearDownId())
			}
		}
	}
}

struct WorkaroundView: TearDownableView {
	let store: StoreOf<Workaround>

	var body: some View {
		WithViewStore(self.store) { viewStore in
			Text("Workaround View")
				.onFirstAppear { viewStore.send(.onFirstAppear) }
				.toolbar {
					Button(action: { viewStore.send(.sendButtonTapped) }) {
						Image(systemName: "paperplane.circle")
					}
				}
		}
	}
}
