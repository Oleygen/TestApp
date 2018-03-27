//
//  StoryTableViewCell.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate: class {
    func didToggleSwitch(cell: StoryTableViewCell)
}

class StoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var selectionSwitch: UISwitch!
    weak var delegate : StoryTableViewCellDelegate?
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with viewModel: StoryViewModel) {
        self.titleLabel.text = viewModel.title
        self.createdAtLabel.text = viewModel.createdAt
        self.selectionSwitch.isOn = viewModel.switchIsOn
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didChangeSwitchValue(_ sender: UISwitch) {
        self.delegate?.didToggleSwitch(cell: self)
    }
    
}


