//
//  ViewController.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static private let cellNibName = "StoryCell"
    static private let cellIdentifier = "StoryTableViewCell"
    
    weak var tableView : UITableView!
    var api = StoryAPI()
    
    var selectableStories: [SelectableStory] = []
    var selectedCount : Int {
        return selectableStories.filter({$0.isSelected}).count
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.updateNavigationBar(count: 0)
        api.fetchStories { (success, stories, error) in
            if success {
                self.selectableStories = stories!.map({return SelectableStory(item:$0)})
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                // TODO: - handle error
            }
        }
    }

    
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
        self.tableView.register(UINib.init(nibName: ViewController.cellNibName, bundle: nil), forCellReuseIdentifier: ViewController.cellIdentifier)
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func didSelectCell(at indexPath : IndexPath) {
        let index = indexPath.row
        self.selectableStories[index].isSelected = !self.selectableStories[index].isSelected
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.updateNavigationBar(count: self.selectedCount)
    }
    
    private func updateNavigationBar(count: Int) {
        self.navigationController?.navigationBar.topItem?.title = "Selected items: \(count)"
    }
}

extension ViewController : StoryTableViewCellDelegate {
    func didToggleSwitch(cell: StoryTableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            self.didSelectCell(at: indexPath)
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectableStories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier) as? StoryTableViewCell
        cell?.delegate = self
        cell?.setup(with: self.selectableStories[indexPath.row].createViewModel())
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.didSelectCell(at: indexPath)
        
    }
    
}
