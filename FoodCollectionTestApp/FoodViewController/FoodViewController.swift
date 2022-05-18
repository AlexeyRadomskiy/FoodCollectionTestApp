//
//  FoodViewController.swift
//  FoodCollectionTestApp
//
//  Created by Alexey on 18.05.2022.
//

import UIKit

class FoodViewController: UIViewController {
    
    // MARK: - Private Properties
    private var data: [CurrentData] = []
    private var selectedIds: Set<String> = []
    private var tableView = UITableView(frame: .zero)
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9566411376, green: 0.9646645188, blue: 0.9688797593, alpha: 1)
        
        downloadData()
        setupTableView()
        setupConstraint()
    }
    
    // MARK: - Private Methods
    private func downloadData() {
        NetworkManager.shared.fetchData(from: Link.FoodApi.rawValue) { [weak self] data in
            guard let self = self else { return }
            self.data = data
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = #colorLiteral(red: 0.9566411376, green: 0.9646645188, blue: 0.9688797593, alpha: 1)
        tableView.separatorStyle = .none
        
        tableView.register(SectionsTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - SetupConstraints
    private func setupConstraint() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension FoodViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SectionsTableViewCell
        
        let section = indexPath.section
        let data = data[section]
        
        cell.setup(images: data.items)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let foodHeader = data[section]
        return foodHeader.header
    }
}

// MARK: - UITableViewDelegate
extension FoodViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.textColor = #colorLiteral(red: 0.1951332688, green: 0.2090256512, blue: 0.329311192, alpha: 1)
        header.textLabel?.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CellDelegate
extension FoodViewController: CellDelegate {
    
    func itemSelected(id: String) -> Bool {
        selectedIds.contains(id)
    }
    
    func didChosen(info: Information) {
        let id = info.id
        if selectedIds.contains(id) {
            selectedIds.remove(id)
        } else {
            if selectedIds.count > 5 {
                let alert = UIAlertController(title: "Rules",
                                              message: "Select up to 6 articles",
                                              preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(action)
                present(alert, animated: true)
                return
            }
            selectedIds.insert(id)
        }
    }
}
