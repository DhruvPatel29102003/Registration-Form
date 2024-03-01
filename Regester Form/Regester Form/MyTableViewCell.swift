//
//  MyTableViewCell.swift
//  Regester Form
//
//  Created by Droadmin on 6/22/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var checklbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    var delegate : hobbyManager!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func hobbybtn(_ sender: Any) {
        self.delegate.selectHobby(cell: self)
    }
    
}
