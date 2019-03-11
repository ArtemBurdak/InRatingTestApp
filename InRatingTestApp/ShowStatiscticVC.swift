//
//  ShowStatiscticVC.swift
//  InRatingTestApp
//
//  Created by Artem on 3/8/19.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class ShowStatiscticVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func shwStat(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StatisticVC") as! StatisticVC
        self.show(vc, sender: self)
    }

}
