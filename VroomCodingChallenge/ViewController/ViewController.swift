//
//  ViewController.swift
//  VroomCodingChallenge
//
//  Created by Rahul Sharma on 2/26/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    
    let StoriesViewModel = TopStoriesViewModel()
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup nav bar
        navigationController?.navigationBar.barTintColor = .orange
        self.title = "Hacker News Top Stories"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.tintColor = .white
        
        // setup tableView
        setupTableView()
        
        // get story data
        StoriesViewModel.getStoryIDs() { (ids, err) in
            if let ids = ids {
                for id in ids {
                    self.StoriesViewModel.getStoryData(story: id) { stories, err in
                        DispatchQueue.main.async {
                           self.tableView.reloadData()
                        }
                    }
                }
            }
            else if let err = err {
                print(err.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoriesViewModel.stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = self.StoriesViewModel.stories[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .black
        
        cell.detailTextLabel?.text = "\(self.StoriesViewModel.stories[indexPath.row].score) points\n\(self.StoriesViewModel.stories[indexPath.row].by)\n\(self.StoriesViewModel.stories[indexPath.row].url)"
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(WebViewController(urlString: self.StoriesViewModel.stories[indexPath.row].url), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
    }
}
