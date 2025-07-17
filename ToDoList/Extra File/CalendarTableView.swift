//
//  CalendarTableView.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 17.07.2025.
//

import UIKit

class CalendarTableView: UITableViewCell {

    let barView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.systemBlue
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 2
            return view
        }()

        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let timeLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            label.textColor = .gray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = UIColor.white.withAlphaComponent(0.6)
            layer.cornerRadius = 8
            layer.masksToBounds = true
                    
            contentView.addSubview(barView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(timeLabel)

            NSLayoutConstraint.activate([
                barView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                barView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                barView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
                barView.widthAnchor.constraint(equalToConstant: 5),
                            
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
                titleLabel.leadingAnchor.constraint(equalTo: barView.trailingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                
                timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
                timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                timeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -2)
            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

