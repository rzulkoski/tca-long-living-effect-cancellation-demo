import UIKit

extension Notification.Name {
	static let problem = Notification.Name("Problem")
	static let task = Notification.Name("Task")
	static let workaround = Notification.Name("Workaround")
}

class NotifyViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Notify"
		view.backgroundColor = .systemGroupedBackground

		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.spacing = 30

		view.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
			stackView.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
		])

		let firstLabel = UILabel()
		firstLabel.textAlignment = .center
		firstLabel.numberOfLines = 0
		firstLabel.text = "Push the buttons below to send notifications being observed by their respective TCA views."
		stackView.addArrangedSubview(firstLabel)

		let problemButton = UIButton(type: .system)
		problemButton.setTitle("Send Problem Notification", for: .normal)
		problemButton.addTarget(self, action: #selector(problemButtonTapped), for: .touchUpInside)
		stackView.addArrangedSubview(problemButton)

		let workaroundButton = UIButton(type: .system)
		workaroundButton.setTitle("Send Workaround Notification", for: .normal)
		workaroundButton.addTarget(self, action: #selector(workaroundButtonTapped), for: .touchUpInside)
		stackView.addArrangedSubview(workaroundButton)

		let taskButton = UIButton(type: .system)
		taskButton.setTitle("Send Task Notification", for: .normal)
		taskButton.addTarget(self, action: #selector(taskButtonTapped), for: .touchUpInside)
		stackView.addArrangedSubview(taskButton)
	}

	@objc private func problemButtonTapped() {
		NotificationCenter.default.post(name: .problem, object: nil)
	}

	@objc private func workaroundButtonTapped() {
		NotificationCenter.default.post(name: .workaround, object: nil)
	}

	@objc private func taskButtonTapped() {
		NotificationCenter.default.post(name: .task, object: nil)
	}
}
