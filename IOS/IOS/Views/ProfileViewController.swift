import UIKit

class ProfileViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
    }
    
    private func setupView(){
        view.backgroundColor = .systemBackground
        title = "Profile"
    }
    
    private func setupUI(){
        view.addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        let nameStack = createHorizontalStack(nameLabel, nameTextField)
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
            name: nameTextField.text ?? "",
            role: roleTextField.text ?? "",
            github: githubTextField.text ,
            linkedin: linkedinTextField.text ,
            twitter: twitterTextField.text ,
            website: websiteTextField.text
    )
        print(profile)
        print(profile.socialLinks)
    }
    
    
    private func createHorizontalStack(_ views: UIView...) -> UIStackView{
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }
    
}
