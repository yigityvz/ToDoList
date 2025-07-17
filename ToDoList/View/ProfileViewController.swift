//
//  ProfileViewController.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 15.07.2025.
//

import UIKit

class ProfileViewController: UIViewController {

    let completedValueLabel = UILabel()
    let refreshControl = UIRefreshControl()
    var totalTaskLabel: UILabel?
    var completedTaskLabel: UILabel?

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Task Image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        return imageView
    }()

    let greetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Merhaba!"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    let statsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppBackground()
        title = "Profil"
        setupLogoutButton()

        let totalTasks = getTaskCount()
        let completedTasks = getTaskCount(completed: true)

        let (totalCard, totalLabel) = createStatCard(title: "Toplam Görev", value: "\(totalTasks)")
        let (completedCard, completedLabel) = createStatCard(title: "Tamamlanan", value: "\(completedTasks)")

        self.totalTaskLabel = totalLabel
        self.completedTaskLabel = completedLabel

        statsStackView.addArrangedSubview(totalCard)
        statsStackView.addArrangedSubview(completedCard)

        refreshControl.addTarget(self, action: #selector(refreshTaskStats), for: .valueChanged)

        view.addSubview(profileImageView)
        view.addSubview(greetingLabel)
        view.addSubview(statsStackView)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            greetingLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            greetingLabel.heightAnchor.constraint(equalToConstant: 40),

            statsStackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30),
            statsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statsStackView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

    func setupLogoutButton() {
        let logoutButton = UIBarButtonItem(title: "Çıkış Yap", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
    }

    func createStatCard(title: String, value: String) -> (UIView, UILabel) {
        let cardView = UIView()
        cardView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        cardView.layer.cornerRadius = 12
        cardView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        cardView.addSubview(titleLabel)
        cardView.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])

        return (cardView, valueLabel)
    }

    func getTaskCount(completed: Bool? = nil) -> Int {
        if let data = UserDefaults.standard.data(forKey: "completedTasks"),
           let tasks = try? JSONDecoder().decode([Task].self, from: data),
           completed == true {
            return tasks.count
        } else if let data = UserDefaults.standard.data(forKey: "tasks"),
                  let tasks = try? JSONDecoder().decode([Task].self, from: data),
                  completed != true {
            return tasks.count
        } else {
            return 0
        }
    }

    @objc func refreshTaskStats() {
        let totalTasks = getTaskCount()
        let completedTasks = getTaskCount(completed: true)

        totalTaskLabel?.text = "\(totalTasks)"
        completedTaskLabel?.text = "\(completedTasks)"
        refreshControl.endRefreshing()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTaskStats()
    }

    @objc func logout() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
}
