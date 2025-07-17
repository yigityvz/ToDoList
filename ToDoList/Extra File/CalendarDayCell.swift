//
//  CalendarDayCell.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 17.07.2025.
//

import UIKit

class CalendarDayCell: UICollectionViewCell {
    
    let dayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textAlignment = .center
            label.textColor = .black
            return label
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(dayLabel)
            dayLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
            
            contentView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
            contentView.layer.cornerRadius = 8
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        func updateSelection(isSelected: Bool, isToday: Bool) {
            if isSelected {
                contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3)
                dayLabel.textColor = .black
            } else if isToday {
                contentView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
                dayLabel.textColor = UIColor.systemBlue 
            } else {
                contentView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
                dayLabel.textColor = .black
            }
        }
    
}
