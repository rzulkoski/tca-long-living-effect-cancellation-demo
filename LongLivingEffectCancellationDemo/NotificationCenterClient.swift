import Combine
import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct NotificationCenterClient {
	public var observe: @Sendable (Set<Notification.Name>) -> AsyncStream<Notification>
	public var post: (Notification) -> Void
}

extension NotificationCenterClient {
	public static let live = Self(
		observe: { names in
			AsyncStream(
				Publishers.MergeMany(names.map { NotificationCenter.default.publisher(for: $0) })
					.values
			)
		},
		post: { notification in
			NotificationCenter.default.post(notification)
		}
	)
}

extension NotificationCenterClient: TestDependencyKey {
	public static let testValue = Self(
		observe: XCTUnimplemented("\(Self.self).observe"),
		post: XCTUnimplemented("\(Self.self).post")
	)
}

extension DependencyValues {
	public var notificationCenterClient: NotificationCenterClient {
		get { self[NotificationCenterClient.self] }
		set { self[NotificationCenterClient.self] = newValue }
	}
}

extension NotificationCenterClient: DependencyKey {
	public static let liveValue = NotificationCenterClient.live
}
