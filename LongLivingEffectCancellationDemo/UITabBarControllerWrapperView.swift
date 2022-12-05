import SwiftUI
import UIKit

struct UITabBarControllerWrapperView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UITabBarController {
		let tabBarController = UITabBarController()
		tabBarController.applyStyle()

		let problemVC = ProblemViewController()
		let firstTabNav = UINavigationController(rootViewController: problemVC)
		firstTabNav.applyStyle()
		firstTabNav.tabBarItem.title = "Problem"

		let redVC = UIViewController()
		redVC.view.backgroundColor = .red
		redVC.title = "Red"
		let secondTabNav = UINavigationController(rootViewController: redVC)
		secondTabNav.applyStyle()
		secondTabNav.tabBarItem.title = "Workaround"

		tabBarController.viewControllers = [firstTabNav, secondTabNav]

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

		let buttonAppearance = UIBarButtonItemAppearance()
		buttonAppearance.normal.titleTextAttributes = [
			.foregroundColor: UIColor.label
		]
		barAppearance.buttonAppearance = buttonAppearance

		navigationBar.standardAppearance = barAppearance
		navigationBar.scrollEdgeAppearance = barAppearance
		navigationBar.tintColor = .label
	}
}
