//
//  ViewController.swift
//  AppleNewsFeed
//
//  Created by jazeps.ivulis on 10/05/2023.
//

import UIKit
import SDWebImage

class NewsFeedViewController: UIViewController {

    private var newItems: [Article] = []
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple News"
        getNewsData()
    }

    @IBAction func infoBarItemTapped(_ sender: Any) {
        basicAlert(title: "News Feed info!", message: "In current Tab Bar you can check News articles about Apple.")
    }
    
    @IBAction func extraButtonTapped(_ sender: Any) {
    }
    
    private func activityIndicator(animated: Bool) {
        DispatchQueue.main.async {
            if animated {
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            }else{
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    private func getNewsData() {
        activityIndicator(animated: true)
        
        NetworkManager.fetchData(url: NetworkManager.api) { newsItems in
            self.newItems = newsItems.articles ?? []
            dump(self.newItems)
            DispatchQueue.main.async {
                self.tblView.reloadData()
                self.activityIndicator(animated: false)
            }
        }
    }
}//class

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        let item = newItems[indexPath.row]
        cell.newsTitleLabel.text = item.title ?? ""
        cell.newsTitleLabel.numberOfLines = 0
        cell.newsImageView.sd_setImage(with: URL(string: item.urlToImage ?? ""))
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        let item = newItems[indexPath.row]
        vc.titleString = item.title ?? "Title"
        vc.webString = item.url ?? ""
        vc.authorString = item.author ?? "Author"
        vc.descString = item.description ?? "Description"
        vc.imageString = item.urlToImage ?? ""
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
