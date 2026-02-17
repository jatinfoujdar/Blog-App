import UIKit

class ProfileViewController: UIViewController {
    
    private let nameTextField = UITextField()
    private let roleTextField = UITextField()
    
    
    private let containerView = UIView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupContainer()
        setupScrollView()
        setupStackView()
        setupName()
        setupRole()
    }
    
    private func setupContainer(){
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = .zero
        
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        
        NSLayoutConstraint.activate([
               containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
               containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
           ])
        
    }
    
    private func setupScrollView(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(scrollView)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupStackView(){
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    private func setupName(){
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .center
        
        
        let label = UILabel()
        label.text = "Name:"
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameTextField.placeholder = "Enter the name"
        nameTextField.borderStyle = .roundedRect
        
        
        horizontalStack.addArrangedSubview(label)
        horizontalStack.addArrangedSubview(nameTextField)
        
        stackView.addArrangedSubview(horizontalStack)
    }
    
    private func setupRole(){
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .center
        
        
        let label = UILabel()
        label.text = "Role:"
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        roleTextField.placeholder = "Enter you role"
        roleTextField.borderStyle = .roundedRect
        
        
        horizontalStack.addArrangedSubview(label)
        horizontalStack.addArrangedSubview(roleTextField)
        
        stackView.addArrangedSubview(horizontalStack)
    }
    
    
}
