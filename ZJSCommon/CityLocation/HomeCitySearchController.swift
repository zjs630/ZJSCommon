//
//  HomeCitySearchController.swift
//  tsbbtClient
//
//  Created by ZhangJingshun on 2020/8/13.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

class HomeCitySearchController: UITableViewController, NoDataStatusView {
    
    weak var delegate: UIViewController?
    
    var noDataView: UIView = UIView()
    
    var matchList: [[String:String]] = [] {
        didSet {
            view.isHidden = false
            tableView.reloadData()
            if matchList.count == 0 {
                showNoDataView(image: "location_no_authorization", text: "未找到相关位置，请重试")
                noDataView.isHidden = false
            } else {
                noDataView.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension HomeCitySearchController {
    private func setupUI() {
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension HomeCitySearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseid")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseid")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            cell?.textLabel?.textColor = UIColor(0x2F2F33)
        }
        cell?.textLabel?.text = matchList[indexPath.row]["c_fullname"]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = matchList[indexPath.row]
        let cityInfo = (data["c_fullname"] ?? "", data["c_code"] ?? "")
        LocationManager.shared.selectedLocation = cityInfo
        delegate?.navigationController?.popViewController(animated: true)
    }
}
