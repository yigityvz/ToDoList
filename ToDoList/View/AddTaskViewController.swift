//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 16.07.2025.
//
import UserNotifications
import UIKit

class AddTaskViewController: UIViewController {
    
    var onTaskAdded: ((Task) -> Void)?
    
    let titleTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Görev Başlığı"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    let descriptionTextView : UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.systemGray5.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 8
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let datePicker: UIDatePicker = {
            let dp = UIDatePicker()
            dp.datePickerMode = .dateAndTime
            dp.preferredDatePickerStyle = .compact
            dp.translatesAutoresizingMaskIntoConstraints = false
            return dp
        }()
    
    let repeatSegmentedControl: UISegmentedControl = {
            let sc = UISegmentedControl(items: ["Yok", "Günlük", "Haftalık", "Yıllık"])
            sc.selectedSegmentIndex = 0
            sc.translatesAutoresizingMaskIntoConstraints = false
            return sc
        }()
    
    let notificationTimePicker: UIDatePicker = {
            let dp = UIDatePicker()
            dp.datePickerMode = .time
            dp.preferredDatePickerStyle = .compact
            dp.translatesAutoresizingMaskIntoConstraints = false
            return dp
        }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Görev Tarihi ve Saati:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let repeatLabel: UILabel = {
        let label = UILabel()
        label.text = "Tekrarlamak İstediğin Zaman Dilimi:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Hangi Saatte Bildirim Verilsin:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Kaydet", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.backgroundColor = .systemBlue
            button.tintColor = .white
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppBackground()
        setupLayout()
        saveButton.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)

    }
    
    
    func setupLayout() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        view.addSubview(repeatLabel)
        view.addSubview(repeatSegmentedControl)
        view.addSubview(notificationLabel)
        view.addSubview(notificationTimePicker)
        view.addSubview(saveButton)
            
            NSLayoutConstraint.activate([
                    titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
                    titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

                    descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
                    descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                    descriptionTextView.heightAnchor.constraint(equalToConstant: 100),

                    dateLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
                    dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    
                    datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
                    datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

                    repeatLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
                    repeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    
                    repeatSegmentedControl.topAnchor.constraint(equalTo: repeatLabel.bottomAnchor, constant: 4),
                    repeatSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    repeatSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

                    notificationLabel.topAnchor.constraint(equalTo: repeatSegmentedControl.bottomAnchor, constant: 16),
                    notificationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    
                    notificationTimePicker.topAnchor.constraint(equalTo: notificationLabel.bottomAnchor, constant: 4),
                    notificationTimePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

                    saveButton.topAnchor.constraint(equalTo: notificationTimePicker.bottomAnchor, constant: 24),
                    saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    saveButton.widthAnchor.constraint(equalToConstant: 120),
                    saveButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    
    
    @objc func handleSaveButton() {
        
        guard let title = titleTextField.text, !title.isEmpty else { return }

        
        let description = descriptionTextView.text

        
        let selectedDate = datePicker.date

        
        let selectedRepeat: Task.TaskRepeatOption
        switch repeatSegmentedControl.selectedSegmentIndex {
        case 1:
            selectedRepeat = .daily
        case 2:
            selectedRepeat = .weekly
        case 3:
            selectedRepeat = .yearly
        default:
            selectedRepeat = .none
        }

        
        let notificationTime = notificationTimePicker.date

        
        let newTask = Task(
            title: title,
            description: description,
            date: selectedDate,
            isCompleted: false,
            repeatOption: selectedRepeat,
            notificationTime: notificationTime
        )

        scheduleNotification(for: newTask)
        onTaskAdded?(newTask)
        dismiss(animated: true)
    }
    
    func scheduleNotification(for task: Task) {
        let content = UNMutableNotificationContent()
        content.title = "Görev Hatırlatma"
        content.body = task.title
        content.sound = .default

        let calendar = Calendar.current

        
        let notifTimeComponents = calendar.dateComponents([.hour, .minute], from: task.notificationTime ?? Date())

        var components = DateComponents()

        switch task.repeatOption {
        case .none:
            
            guard let taskDate = task.date else { return }
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: taskDate)
            components.year = dateComponents.year
            components.month = dateComponents.month
            components.day = dateComponents.day
            components.hour = notifTimeComponents.hour
            components.minute = notifTimeComponents.minute

        case .daily:
            components.hour = notifTimeComponents.hour
            components.minute = notifTimeComponents.minute

        case .weekly:
            guard let taskDate = task.date else { return }
            let weekday = calendar.component(.weekday, from: taskDate)
            components.weekday = weekday
            components.hour = notifTimeComponents.hour
            components.minute = notifTimeComponents.minute

        case .yearly:
            guard let taskDate = task.date else { return }
            let dateComponents = calendar.dateComponents([.month, .day], from: taskDate)
            components.month = dateComponents.month
            components.day = dateComponents.day
            components.hour = notifTimeComponents.hour
            components.minute = notifTimeComponents.minute
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: task.repeatOption != .none)

        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Bildirim eklenemedi: \(error.localizedDescription)")
            } else {
                print("✅ Bildirim başarıyla eklendi.")
            }
        }
    }
}

    


