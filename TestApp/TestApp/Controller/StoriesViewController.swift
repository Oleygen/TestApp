//
//  ViewController.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
    
    // MARK: - Properties
    static private let cellNibName = "StoryCell"
    static private let cellIdentifier = "StoryTableViewCell"
    
    weak var tableView : UITableView!
    var model = StoryModel()
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.updateNavigationBar(count: 0)
        self.model.fetchStories { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                // TODO: - handle error
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setupTableView() {
        let tableView = UITableView()
        self.view.addSubview(tableView)
        self.tableView = tableView
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(UINib.init(nibName: StoriesViewController.cellNibName, bundle: nil), forCellReuseIdentifier: StoriesViewController.cellIdentifier)
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func didSelectCell(at indexPath : IndexPath) {
        let index = indexPath.row
        self.model.selectableStories[index].isSelected = !self.model.selectableStories[index].isSelected
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.updateNavigationBar(count: self.model.selectedCount)
    }
    
    private func updateNavigationBar(count: Int) {
        self.navigationController?.navigationBar.topItem?.title = "Selected items: \(count)"
    }
}

extension StoriesViewController : StoryTableViewCellDelegate {
    func didToggleSwitch(cell: StoryTableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            self.didSelectCell(at: indexPath)
        }
    }
}

extension StoriesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.selectableStories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoriesViewController.cellIdentifier) as? StoryTableViewCell
        cell?.delegate = self
        cell?.setup(with: self.model.selectableStories[indexPath.row].createViewModel())
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectCell(at: indexPath)
        
    }
    
}
