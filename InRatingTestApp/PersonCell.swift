//
//  PersonsCell.swift
//  InRatingTestApp
//
//  Created by Artem on 3/11/19.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit
import Kingfisher

class PersonCell: UICollectionViewCell {

    @IBOutlet weak var avatar: UIImageView!

    @IBOutlet weak var personNamelbl: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatar.image = nil
        self.personNamelbl.text = nil
    }

    func configure(person model: Person) {

        let imageUrl = URL(string: model.avatar_image.url_small)
        avatar.kf.setImage(with: imageUrl)

        personNamelbl.text = model.nickname
    }
}
