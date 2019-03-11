//
//  PersonsCell.swift
//  InRatingTestApp
//
//  Created by Artem on 3/11/19.
//  Copyright © 2019 Artem. All rights reserved.
//

import Foundation

import UIKit
import Kingfisher

class PersonCell: UICollectionViewCell {

    @IBOutlet weak var avatar: UIImageView!

    @IBOutlet weak var personNamelbl: UILabel!

    var person: Person!

    func configure(person gotPerson: Person) {
        self.person = gotPerson

        let imageUrl = URL(string: self.person.avatar_image.url_small)
        avatar.kf.setImage(with: imageUrl)

        personNamelbl.text = self.person.nickname
    }
}
