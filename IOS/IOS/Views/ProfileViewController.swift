import UIKit

class ProfileViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private let roleLabel: UILabel = {
        let label = UILabel()
        label.text = "Role"
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your role"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let socialLabel: UILabel = {
        let label = UILabel()
        label.text = "Social"
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let githubTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your github"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let linkedinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your linkedin"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let twitterTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your twitter"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let websiteTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your website"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        setupConstraints()
        setupActions()
        
        fetchProfileData()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Profile"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(handleLogout)
        )
    }

    @objc private func handleLogout() {
        SessionManager.shared.logout()
        
      
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navController
        }, completion: nil)
    }

    
    private func setupUI(){
        view.addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        let nameStack = createHorizontalStack(nameLabel, nameValueLabel)
        let roleStack = createHorizontalStack(roleLabel, roleTextField)
        
        contentStackView.addArrangedSubview(nameStack)
        contentStackView.addArrangedSubview(roleStack)
        contentStackView.addArrangedSubview(socialLabel)
        contentStackView.addArrangedSubview(githubTextField)
        contentStackView.addArrangedSubview(linkedinTextField)
        contentStackView.addArrangedSubview(twitterTextField)
        contentStackView.addArrangedSubview(websiteTextField)
        contentStackView.addArrangedSubview(addButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container View
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            // Content Stack View
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])
    }
    
    private func setupActions(){
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    @objc private func addTapped(){
        let profile = Profile(
            name: nameValueLabel.text ?? "",
            role: roleTextField.text ?? "",
            github: githubTextField.text ,
            linkedin: linkedinTextField.text ,
            twitter: twitterTextField.text ,
            website: websiteTextField.text
        )
        
        APIService.shared.updateProfile(profile: profile) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    self?.showAlert(title: "Success", message: message)
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func fetchProfileData() {
        APIService.shared.fetchProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.nameValueLabel.text = profile.name // Read-only label
                    self?.roleTextField.text = profile.role
                    self?.githubTextField.text = profile.github
                    self?.linkedinTextField.text = profile.linkedin
                    self?.twitterTextField.text = profile.twitter
                    self?.websiteTextField.text = profile.website
                case .failure(let error):
                    print("Failed to fetch profile: \(error)")
                }
            }
        }
    }

    
    private func createHorizontalStack(_ views: UIView...) -> UIStackView{
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }
    
}
