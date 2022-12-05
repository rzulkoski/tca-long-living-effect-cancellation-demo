import Foundation
import UIKit

class ProblemViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Problem"
		view.backgroundColor = .systemGroupedBackground

		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.spacing = 12

		view.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
			stackView.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
		])

		let label = UILabel()
		label.text = "Instructions"
		stackView.addArrangedSubview(label)

		let button = UIButton(type: .system)
		button.setTitle("Push Problem View", for: .normal)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		stackView.addArrangedSubview(button)
	}

	@objc private func buttonTapped() {
		print("YUP!!!")
	}
}
