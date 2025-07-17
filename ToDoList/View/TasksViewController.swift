//
//  TasksViewController.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 15.07.2025.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    
    var tasks : [Task] = []
    
    var completedTasks : [Task] = []
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "January 15"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.textColor = .systemTeal
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emojiImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Task Image")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let statusLabel : UILabel = {
        let label = UILabel()
        label.text = "Bugünkü Görevler"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBar : UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 0.6
        progress.trackTintColor = .lightGray
        progress.progressTintColor = .systemBlue
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let percentageLabel : UILabel = {
        let label = UILabel()
        label.text = "30%"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView : UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.register(TaskCell.self , forCellReuseIdentifier: "TaskCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let pendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Bekleyen Görevler"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let addButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 28
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let completedLabel : UILabel = {
        let label = UILabel()
        label.text = "Tamamlanmış Görevler"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let completedTasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppBackground()
        setupUI()
        view.bringSubviewToFront(addButton)
        
        
        completedTasksTableView.dataSource = self
        completedTasksTableView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        addButton.addTarget(self, action: #selector(handleAddButtonTapped), for: .touchUpInside)
        
        loadTasks()
        
    }
    
    
    func setupUI(){
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        
        view.addSubview(statusView)
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            statusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            statusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            statusView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        statusView.addSubview(emojiImageView)
        statusView.addSubview(statusLabel)
        statusView.addSubview(progressBar)
        statusView.addSubview(percentageLabel)
        
        NSLayoutConstraint.activate([
            emojiImageView.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            emojiImageView.leadingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: 12),
            emojiImageView.widthAnchor.constraint(equalToConstant: 50),
            emojiImageView.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: emojiImageView.trailingAnchor, constant: 12),
            
            progressBar.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: percentageLabel.leadingAnchor, constant: -8),
            
            percentageLabel.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            percentageLabel.trailingAnchor.constraint(equalTo: statusView.trailingAnchor, constant: -12)
        ])
        
        view.addSubview(pendingLabel)
        
        NSLayoutConstraint.activate([
            pendingLabel.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 48),
            pendingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            pendingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: pendingLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -180)
            
        ])
        
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            addButton.widthAnchor.constraint(equalToConstant: 56),
            addButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        view.addSubview(completedLabel)
        
        NSLayoutConstraint.activate([
            completedLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 24),
            completedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            completedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            
        ])
        
        view.addSubview(completedTasksTableView)
        
        NSLayoutConstraint.activate([
            completedTasksTableView.topAnchor.constraint(equalTo: completedLabel.bottomAnchor, constant: 8),
            completedTasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            completedTasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            completedTasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return tasks.count
        } else if tableView == completedTasksTableView {
            return completedTasks.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        
        let task: Task
        if tableView == self.tableView {
            task = tasks[indexPath.row]
        } else {
            task = completedTasks[indexPath.row]
        }
        
        cell.configure(with: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            let selectedTask = tasks[indexPath.row]
            
            let alert = UIAlertController(
                title: "Tamamlandı mı?",
                message: "\"\(selectedTask.title)\" görevini tamamladınız mı?",
                preferredStyle: .alert
            )
            
            
            alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { _ in
                self.completedTasks.append(selectedTask)
                self.tasks.remove(at: indexPath.row)
                self.saveTasks()
                self.tableView.reloadData()
                self.completedTasksTableView.reloadData()
            }))
            
            
            alert.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
                if tableView == self.tableView {
                    let deletedTask = tasks[indexPath.row]
                    removeNotification(for: deletedTask)
                    tasks.remove(at: indexPath.row)
                } else if tableView == completedTasksTableView {
                    let deletedTask = completedTasks[indexPath.row]
                    removeNotification(for: deletedTask) 
                    completedTasks.remove(at: indexPath.row)
                }
            
            saveTasks()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
        
        
        @objc func handleAddButtonTapped() {
            let addVC = AddTaskViewController()
            
            
            addVC.onTaskAdded = { [weak self] newTask in
                self?.tasks.append(newTask)
                self?.saveTasks()
                self?.tableView.reloadData()
            }
            
            if let sheet = addVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
            
            present(addVC, animated: true)
        }
        
        func saveTasks() {
            if let data = try? JSONEncoder().encode(tasks) {
                UserDefaults.standard.set(data, forKey: "tasks")
            }
            if let completedData = try? JSONEncoder().encode(completedTasks) {
                UserDefaults.standard.set(completedData, forKey: "completedTasks")
            }
        }
        
        func loadTasks() {
            if let data = UserDefaults.standard.data(forKey: "tasks"),
               let savedTasks = try? JSONDecoder().decode([Task].self, from: data) {
                self.tasks = savedTasks
            }
            
            if let completedData = UserDefaults.standard.data(forKey: "completedTasks"),
               let savedCompleted = try? JSONDecoder().decode([Task].self, from: completedData) {
                self.completedTasks = savedCompleted
            }
        }
    
    func removeNotification(for task: Task) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
    }
    
    
    }

