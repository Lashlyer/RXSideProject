//
//  UserTableViewCell.swift
//  UserSideProject
//
//  Created by Alvin on 2022/2/7.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setValue(data: UserDataResponse.User) {
        self.userEmailLabel.text = data.email
        self.userNameLabel.text = data.firstName + data.lastName
        guard let url = URL(string: data.avatar) else { return }
        self.userImage.sd_setImage(with: url, placeholderImage: UIImage(named: "noimage"), options: [], progress: nil, completed: nil)
    }
    
}
