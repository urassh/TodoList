//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by 浦山秀斗 on 2023/09/04.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet var priorityImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel : UILabel!
    @IBOutlet var priorityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setCell(priority: Int, title: String, date: String) {
        let isPriority: Bool = 0 < priority
        priorityImage.image = isPriority ? UIImage(systemName: "star.fill") : UIImage(systemName: "star");
        titleLabel.text     = title
        dateLabel.text      = "作成日 : \(date)"
        priorityLabel.text  = isPriority ? String(priority) : ""
    }
}
