import SwiftUI
import UIKit

struct UITabBarControllerWrapperView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UITabBarController {
		let tabBarController = UITabBarController()
		tabBarController.applyStyle()

		let problemVC = ProblemViewController()
		let problemTabNav = UINavigationController(rootViewController: problemVC)
		problemTabNav.applyStyle()
		problemTabNav.tabBarItem.title = "Problem"
		problemTabNav.tabBarItem.image = UIImage(systemName: "ladybug")
		problemTabNav.tabBarItem.selectedImage = UIImage(systemName: "ladybug.fill")

		let workaroundVC = WorkaroundViewController()
		let workaroundTabNav = UINavigationController(rootViewController: workaroundVC)
		workaroundTabNav.applyStyle()
		workaroundTabNav.tabBarItem.title = "Workaround"
		workaroundTabNav.tabBarItem.image = UIImage(systemName: "bandage")
		workaroundTabNav.tabBarItem.selectedImage = UIImage(systemName: "bandage.fill")

		let taskVC = TaskViewController()
		let taskTabNav = UINavigationController(rootViewController: taskVC)
		taskTabNav.applyStyle()
		taskTabNav.tabBarItem.title = "Task"
		taskTabNav.tabBarItem.image = UIImage(systemName: "gearshape")
		taskTabNav.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")

		let notifyVC = NotifyViewController()
		let notifyTabNav = UINavigationController(rootViewController: notifyVC)
		notifyTabNav.applyStyle()
		notifyTabNav.tabBarItem.title = "Notify"
		notifyTabNav.tabBarItem.image = UIImage(systemName: "paperplane")
		notifyTabNav.tabBarItem.selectedImage = UIImage(systemName: "paperplane.fill")

		tabBarController.viewControllers = [problemTabNav, workaroundTabNav, taskTabNav, notifyTabNav]

		return tabBarController
	}

	func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {}
}

extension UITabBarController {
	func applyStyle() {
		let barItemAppearance = UITabBarItemAppearance()
		barItemAppearance.selected.iconColor = .link
		barItemAppearance.selected.titleTextAttributes = [
			NSAttributedString.Key.foregroundColor: UIColor.link,
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)
		]
		barItemAppearance.normal.iconColor = .secondaryLabel
		barItemAppearance.normal.titleTextAttributes = [
			NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)
		]

		let barAppearance = UITabBarAppearance()
		barAppearance.configureWithOpaqueBackground()
		barAppearance.backgroundColor = .white
		barAppearance.stackedLayoutAppearance = barItemAppearance
		barAppearance.inlineLayoutAppearance = barItemAppearance
		barAppearance.compactInlineLayoutAppearance = barItemAppearance

		tabBar.barStyle = .default
		tabBar.standardAppearance = barAppearance
		tabBar.scrollEdgeAppearance = barAppearance
	}
}

extension UINavigationController {
	func applyStyle() {
		let barAppearance = UINavigationBarAppearance()
		barAppearance.configureWithOpaqueBackground()
		barAppearance.backgroundColor = .white
		barAppearance.titleTextAttributes = [
			NSAttributedString.Key.foregroundColor: UIColor.label,
		]

		navigationBar.standardAppearance = barAppearance
		navigationBar.scrollEdgeAppearance = barAppearance
	}
}
