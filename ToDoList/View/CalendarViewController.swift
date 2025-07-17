//
//  CalendarViewController.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 15.07.2025.


import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var collectionView: UICollectionView!

    let calendar = Calendar.current
    var currentDate = Date()
    var daysInMonth = [String]()
    var selectedDate: Date?
    var tasksForSelectedDate: [Task] = []
    
    let monthLabel : UILabel = {
        let ml = UILabel()
        ml.translatesAutoresizingMaskIntoConstraints = false
        ml.textAlignment = .center
        ml.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        ml.textColor = .black
        return ml
    }()
        
    let dateFormatter : DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "tr_TR")
        df.dateFormat = "LLLL yyyy"
        return df
    }()
    
    let daysStackView : UIStackView = {
        let daysStack = UIStackView()
        daysStack.axis = .horizontal
        daysStack.distribution = .fillEqually
        daysStack.alignment = .center
        daysStack.spacing = 0
        daysStack.translatesAutoresizingMaskIntoConstraints = false
        return daysStack
    }()
    
    let leftButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("<", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
    let rightButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(">", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.register(CalendarTableView.self, forCellReuseIdentifier: "taskCell")
        return tv
    }()
    
    let plannedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Planlanan Görevler"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Bu gün için planlanmış görev yok."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAppBackground()
        title = "Takvim"
        
        let weekDays = ["Pzt", "Sal", "Çar", "Per", "Cum", "Cmt", "Paz"]
        
        for day in weekDays {
            let label = UILabel()
            label.text = day
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.textAlignment = .center
            label.textColor = .darkGray
            daysStackView.addArrangedSubview(label)
        }
        
        monthLabel.text = dateFormatter.string(from: currentDate).capitalized
        leftButton.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        setupCollectionView()
        generateDaysInMonth()
    }
    

    func generateDaysInMonth() {
        daysInMonth.removeAll()

        daysInMonth.removeAll()

                let range = calendar.range(of: .day, in: .month, for: currentDate)!
                let components = calendar.dateComponents([.year, .month], from: currentDate)
                let firstDayOfMonth = calendar.date(from: components)!
                let weekday = calendar.component(.weekday, from: firstDayOfMonth)
                let weekdayIndex = (weekday + 5) % 7

                for _ in 0..<weekdayIndex {
                    daysInMonth.append("")
                }

                for day in range {
                    daysInMonth.append("\(day)")
                }

                monthLabel.text = dateFormatter.string(from: currentDate).capitalized
                collectionView.reloadData()
        }

        
        func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0

            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .clear
            collectionView.delegate = self
            collectionView.dataSource = self

            collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "dayCell")

                    view.addSubview(collectionView)
                    view.addSubview(monthLabel)
                    view.addSubview(daysStackView)
                    view.addSubview(leftButton)
                    view.addSubview(rightButton)
                    view.addSubview(tableView)
                    view.addSubview(plannedTitleLabel)
                    view.addSubview(noTaskLabel)

            
                    NSLayoutConstraint.activate([
                        
                        monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                        monthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        monthLabel.heightAnchor.constraint(equalToConstant: 30),
                        
                        leftButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
                        leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        leftButton.widthAnchor.constraint(equalToConstant: 30),
                        
                        rightButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
                        rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        rightButton.widthAnchor.constraint(equalToConstant: 30),
                        
                        daysStackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 7),
                        daysStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        daysStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        daysStackView.heightAnchor.constraint(equalToConstant: 10),

                        collectionView.topAnchor.constraint(equalTo: daysStackView.bottomAnchor, constant: 10),
                        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        collectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
                        
                        
                        plannedTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0),
                        plannedTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        plannedTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        plannedTitleLabel.heightAnchor.constraint(equalToConstant: 24),
                        
                        tableView.topAnchor.constraint(equalTo: plannedTitleLabel.bottomAnchor, constant: 8),
                        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                        
                        noTaskLabel.topAnchor.constraint(equalTo: plannedTitleLabel.bottomAnchor, constant: 20),
                        noTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        noTaskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                    ])
                }


        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return daysInMonth.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CalendarDayCell
            let dayText = daysInMonth[indexPath.item]
            cell.dayLabel.text = dayText

            if let dayInt = Int(dayText) {
                var components = Calendar.current.dateComponents([.year, .month], from: currentDate)
                components.day = dayInt

                if let cellDate = Calendar.current.date(from: components) {
                    let isSelected = selectedDate?.isSameDay(as: cellDate) ?? false
                    let isToday = Calendar.current.isDateInToday(cellDate)
                    cell.updateSelection(isSelected: isSelected, isToday: isToday)
                } else {
                    cell.updateSelection(isSelected: false, isToday: false)
                }
            } else {
                cell.updateSelection(isSelected: false, isToday: false)
            }

            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.size.width) / 7
            return CGSize(width: width, height: width)
        }

        @objc func previousMonth() {
            currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
            generateDaysInMonth()
        }

        @objc func nextMonth() {
            currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
            generateDaysInMonth()
        }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let dayText = daysInMonth[indexPath.item]
            guard let day = Int(dayText) else {
                tasksForSelectedDate = []
                tableView.reloadData()
                return
            }

        var components = Calendar.current.dateComponents([.year, .month], from: currentDate)
        components.day = day

        if let selected = Calendar.current.date(from: components) {
            self.selectedDate = selected
            loadTasksForSelectedDate()
            collectionView.reloadData()
        }
    }
    
        func loadTasksForSelectedDate() {
            tasksForSelectedDate = []

            if let data = UserDefaults.standard.data(forKey: "tasks"),
                   let allTasks = try? JSONDecoder().decode([Task].self, from: data) {

                    tasksForSelectedDate = allTasks
                        .filter { task in
                            if let taskDate = task.date, let selected = selectedDate {
                                return taskDate.isSameDay(as: selected)
                            } else {
                                return false
                            }
                        }
                        .sorted { task1, task2 in
                            guard let date1 = task1.date, let date2 = task2.date else { return false }
                            return date1 < date2
                        }
                }

                tableView.reloadData()
                noTaskLabel.isHidden = !tasksForSelectedDate.isEmpty

        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tasksForSelectedDate.count
        }

    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! CalendarTableView
            let task = tasksForSelectedDate[indexPath.row]
            cell.textLabel?.text = task.title
            cell.backgroundColor = .white.withAlphaComponent(0.7)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            
            if let date = task.date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    cell.timeLabel.text = formatter.string(from: date)
                } else {
                    cell.timeLabel.text = "-"
                }
            
            return cell
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedTask = tasksForSelectedDate[indexPath.row]

            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [deletedTask.id.uuidString])

            if let data = UserDefaults.standard.data(forKey: "tasks"),
               var allTasks = try? JSONDecoder().decode([Task].self, from: data) {

                allTasks.removeAll { $0.id == deletedTask.id }

                if let updatedData = try? JSONEncoder().encode(allTasks) {
                    UserDefaults.standard.set(updatedData, forKey: "tasks")
                }

                tasksForSelectedDate.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    
}
    


