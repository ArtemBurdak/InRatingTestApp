//
//  StatisticVC.swift
//  InRatingTestApp
//
//  Created by Artem on 3/6/19.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit
import Alamofire

class StatisticVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!

    var statistic = [StatisticTVCell]()

    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    func setupStatistic() {

        let views = StatisticTVCell.init(title: "Views \(self.post.views_count)",
            postUrl: nil,
            postId: nil,
            personsArray: [],
            manualyCount: false)
        statistic.append(views)

        let likes = StatisticTVCell.init(title: "Likes \(self.post.likes_count)",
            postUrl: Constants.NetworkingUrl.likesUrl,
            postId: self.post.id,
            personsArray: [],
            manualyCount: false)
        statistic.append(likes)

        let comments = StatisticTVCell.init(title: "Comments \(self.post.comments_count)",
            postUrl: Constants.NetworkingUrl.commentsUrl,
            postId: self.post.id,
            personsArray: [],
            manualyCount: false)
        statistic.append(comments)

        let mentions = StatisticTVCell.init(title: "Mentions",
            postUrl: Constants.NetworkingUrl.mentionsUrl,
            postId: self.post.id,
            personsArray: [],
            manualyCount: true)

        statistic.append(mentions)

        let reposts = StatisticTVCell.init(title: "Reposts \(self.post.reposts_count)",
            postUrl: Constants.NetworkingUrl.repostsUrl,
            postId: self.post.id,
            personsArray: [],
            manualyCount: false)
        statistic.append(reposts)

        let bookmarks = StatisticTVCell.init(title: "Bookmarks \(self.post.bookmarks_count)",
            postUrl: nil,
            postId: nil,
            personsArray: [],
            manualyCount: false)
        statistic.append(bookmarks)

        var countAlam = 0
        var endCountAlam: Int {
            var x = 0
            for i in statistic {
                if i.postUrl != nil { x += 1 }
            }
            return x
        }

        for (index, item) in statistic.enumerated() {

            if item.postUrl != nil && item.postId != nil {
                Alamofire.request(item.postUrl!,
                                  method: .post,
                                  parameters:  ["id": item.postId!],
                                  encoding: JSONEncoding.default,
                                  headers: Constants.headers).responseJSON { [weak self] (response) in

                                    guard let data = response.data else { return }
                                    print(response.result.value ?? ":)")

                                    let decoder = JSONDecoder()
                                    if let statData = try? decoder.decode(StatisticData.self, from: data) {
                                        self?.statistic[index].personsArray = statData.data

                                        countAlam += 1
 
                                        if countAlam == endCountAlam {
                                            DispatchQueue.main.async {
                                                self?.activitySpinner.stopAnimating()
                                                self?.tableView.reloadData()
                                            }
                                        }
                                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statistic.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticCell") as! StatisticCell

        cell.configure(statistic: statistic[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 150

        if statistic[indexPath.row].personsArray.isEmpty {
            height = 50
        }
        return CGFloat(height)
    }

    func getData() {

        self.activitySpinner.startAnimating()

        let params = ["slug": "ClkMaq9RFcLk"]

        Alamofire.request(Constants.NetworkingUrl.slugUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Constants.headers).responseJSON { (response) in
            guard let data = response.data else { return }
            print(response.result.value ?? ":)")

            let decoder = JSONDecoder()
            if let post = try? decoder.decode(Post.self, from: data) {
                self.post = post

                self.setupStatistic()
            }
        }
    }
}
