//
//  EarthquakeListViewController.swift
//  earthquake
//
//  Created by Zhou on 2024/11/6.
//

import UIKit

class EarthquakeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel = EarthquakeViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    // 设置表格视图
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // 获取数据并刷新
    private func fetchData() {
        viewModel.fetchEarthquakes { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // 数据源方法：表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEarthquakes()
    }
    
    // 数据源方法：表格单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let earthquake = viewModel.earthquake(at: indexPath.row)
        
        // 区分震级 >= 7.5 的地震
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(earthquake.place) - \(earthquake.magnitude)"
        cell.backgroundColor = earthquake.magnitude >= 7.5 ? .red : .white
        return cell
    }
    
    // 点击行打开地图视图
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let earthquake = viewModel.earthquake(at: indexPath.row)
        let detailVC = EarthquakeDetailViewController(earthquake: earthquake)
        present(detailVC, animated: true)
    }
}

