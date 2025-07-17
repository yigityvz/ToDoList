//
//  TaskCell.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 16.07.2025.
//

import UIKit

class TaskCell: UITableViewCell {
    
    
    let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .darkGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     
     let leftLineView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemBlue
            view.layer.cornerRadius = 3
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            backgroundColor = .clear
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 12
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOpacity = 0.1
            contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
            contentView.layer.shadowRadius = 6
            contentView.layer.masksToBounds = false
                
            
            contentView.addSubview(leftLineView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(timeLabel)
        
        
            
            NSLayoutConstraint.activate([
                
                leftLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
                leftLineView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                leftLineView.widthAnchor.constraint(equalToConstant: 6),
                leftLineView.heightAnchor.constraint(equalToConstant: 50),
                
                
                titleLabel.leadingAnchor.constraint(equalTo: leftLineView.trailingAnchor, constant: 12),
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                
                timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
                timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
                
            ])
        
        
        
    }
    
    func configure(with task : Task) {
        titleLabel.text = task.title
        let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            if let date = task.date {
                timeLabel.text = formatter.string(from: date)
            } else {
                timeLabel.text = ""
            }
    }
    
    
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
