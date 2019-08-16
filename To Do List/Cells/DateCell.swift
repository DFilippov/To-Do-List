//
//  DateCell.swift
//  To Do List
//
//  Created by Ayu Filippova on 14/08/2019.
//  Copyright © 2019 Dmitry Filippov. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    
    func setDate(_ date: Date) {
        label.text = date.formattedDate
    }
}
