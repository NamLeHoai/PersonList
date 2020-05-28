//
//  CustomTableViewCell.swift
//  PersonList
//
//  Created by Nam Le on 5/22/20.
//  Copyright © 2020 Nam Le. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var phoneLB: UILabel!
    @IBOutlet weak var avataImageView: UIImageView!
    var person: Person? {
        didSet {
            if let data = person {
                avataImageView.image = data.avatarImage
                nameLB.text = data.name
                phoneLB.text = data.phone
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .lightGray
        avataImageView.layer.cornerRadius = avataImageView.bounds.height / 2
        avataImageView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
