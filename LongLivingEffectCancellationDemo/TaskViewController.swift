import ComposableArchitecture
import SwiftUI
import UIKit

class TaskViewController: UIViewController {
	private lazy var sendItem = UIBarButtonItem(title: "Send", image: UIImage(systemName: "paperplane.circle"), target: self, action: #selector(sendButtonTapped))

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Task"
		navigationItem.rightBarButtonItem = sendItem
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
		firstLabel.text = "Push the task view using the button below. Use the send button in the navigation bar to send a notification observed by the task view."
		stackView.addArrangedSubview(firstLabel)

		let button = UIButton(type: .system)
		button.setTitle("Push Task View", for: .normal)
		button.addTarget(self, action: #selector(pushButtonTapped), for: .touchUpInside)
		stackView.addArrangedSubview(button)

		let secondLabel = UILabel()
		secondLabel.textAlignment = .center
		secondLabel.numberOfLines = 0
		secondLabel.text = "Notice messages do NOT continue to print in the console after the workaround view has been popped. However, message also do NOT print when on the notify tab."
		stackView.addArrangedSubview(secondLabel)
	}

	@objc private func pushButtonTapped() {
		let store = StoreOf<Task>(
			initialState: .init(),
			reducer: Task()
		)
		let rootView = TaskView(store: store)
		let host = UIHostingController(rootView: rootView)

		navigationController?.pushViewController(host, animated: true)
	}

	@objc private func sendButtonTapped() {
		NotificationCenter.default.post(name: .problem, object: nil)
	}
}
