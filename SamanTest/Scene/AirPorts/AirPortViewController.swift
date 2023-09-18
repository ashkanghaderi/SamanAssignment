//
//  AirPortViewController.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class AirPortViewController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: AirPortViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }

    private func configureTableView() {
        tableView.register(AirPortTableViewCell.self)
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let input = AirPortViewModel.Input(selectionTrigger: self.tableView.rx.itemSelected.asDriver(),sortSegment: segmentedControl.rx.value.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.airPorts.drive(self.tableView.rx.items(cellIdentifier: AirPortTableViewCell.reuseID, cellType: AirPortTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
        }.disposed(by: self.disposeBag)
       
        output.error.drive(errorBinding)
            .disposed(by: self.disposeBag)
        output.isFetching
            .drive()
            .disposed(by: self.disposeBag)
        output.selectedAirPort
            .drive()
            .disposed(by: self.disposeBag)

    }

}
