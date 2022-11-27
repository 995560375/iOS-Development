//
//  ITemCellTableViewCell.swift
//  Quiz
//
//  Created by sunny on 2022/11/26.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var questionLabel: UILabel!;
    @IBOutlet var selectionLabel: UILabel!;
    @IBOutlet var answerLabel: UILabel!;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
