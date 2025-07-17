//
//  MainTabBarControllerViewController.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 15.07.2025.
//

import UIKit

class MainTabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppBackground()
        setupTabs()
        
    }
    
    func setupTabs() {
        let tasksVC = TasksViewController()
        let calendarVC = CalendarViewController()
        let profileVC = ProfileViewController()
        
        tasksVC.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "checkmark.circle"), tag: 0)
        calendarVC.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 2)
        
        let tasksNav = UINavigationController(rootViewController: tasksVC)
        let calendarNav = UINavigationController(rootViewController: calendarVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        viewControllers = [tasksNav, calendarNav, profileNav]
    }
    
    
    
    
    

    

}
