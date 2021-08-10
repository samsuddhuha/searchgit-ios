//
//  RepoViewCell.swift
//  searchgit
//
//  Created by Samsud Dhuha on 10/08/21.
//

import UIKit

class RepoViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewRepo: UIView!
    @IBOutlet weak var imageOwner: UIImageView!
    @IBOutlet weak var labelFullName: UILabel!
    @IBOutlet weak var labelOwner: UILabel!
    @IBOutlet weak var labelDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewRepo.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
