//
//  StatisticCell.swift
//  InRatingTestApp
//
//  Created by Artem on 3/6/19.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit
import Alamofire

class StatisticCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var statisticType: UILabel!

    var statistic: StatisticTVCell!

    var personsArray = [Person]()

    func configure(statistic: StatisticTVCell) {

        self.statistic = statistic

        self.statisticType.text = statistic.title

        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        getPersons(postUrl: statistic.postUrl, params: ["id": statistic.postId])
    }

    func getPersons(postUrl: String?, params: [String : Int?]) {

        guard postUrl != nil, params.first?.value != nil else {return}

            Alamofire.request(postUrl!,
                              method: .post,
                              parameters: params as Parameters,
                              encoding: JSONEncoding.default,
                              headers: Constants.headers).responseJSON { (response) in

                                guard let data = response.data else { return }
                                print(response.result.value ?? ":)")

                                let decoder = JSONDecoder()
                                if let statData = try? decoder.decode(StatisticData.self, from: data) {
                                    self.personsArray = statData.data

                                    DispatchQueue.main.async {
                                        self.manualyCount()
                                        self.collectionView.reloadData()
                                    }
            }
        }
    }

    override func prepareForReuse() {
        personsArray.removeAll()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
        cell.configure(person: personsArray[indexPath.row])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellsAcross: CGFloat = 2
        let screenWidth = self.frame.width
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 8)
        layout.itemSize = CGSize(width: screenWidth/cellsAcross, height: screenWidth/cellsAcross)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout

        return CGSize(width: self.frame.height - 40, height: self.frame.height - 40)
    }
    
    func manualyCount() {
        if self.statistic.manualyCount {
            self.statisticType.text = self.statisticType.text! + " \(personsArray.count)"
        }
    }

}