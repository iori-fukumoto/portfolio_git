//
//  TableViewCell.swift
//  NewDoneList
//
//  Created by 福本伊織 on 2021/03/04.
//

import UIKit
import Cosmos

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var DetailLabel: UILabel!
    @IBOutlet weak var StarLabel: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
