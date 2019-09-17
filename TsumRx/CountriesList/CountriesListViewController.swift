//
//  CountriesListViewController.swift
//  rxFun
//
//  Created Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import RxSwift
import RxCocoa
import RxOptional

class CountriesListViewController: UIViewController, Storyboardable {
    // MARK: - Public
    var viewModel: CountriesListViewModelProtocol!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind()
        viewModel.moduleDidLoad()
    }
    // MARK: - Private
    private let bag = DisposeBag()
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var countriesDataSource: CountriesDataSource!
    private var activityIndicatorView = UIActivityIndicatorView(style: .gray)

    private func setupViews() {
        title = "Countries"
        tableView.rowHeight = UITableView.automaticDimension

        activityIndicatorView.tintColor = .black
        let refreshBarButton = UIBarButtonItem(customView: activityIndicatorView)
        navigationItem.rightBarButtonItem = refreshBarButton

        tableView.refreshControl = UIRefreshControl()
    }

    private func bind() {
        viewModel.isRequestActive
            .subscribe(onNext: { [weak self] isRequestActive in
                isRequestActive ? self?.showLoader() : self?.hideLoader()
            })
            .disposed(by: bag)

        viewModel.error
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: bag)

        viewModel.dataSet
            .do(onNext: { [weak self] _ in
                self?.tableView.refreshControl?.endRefreshing()
            })
            .subscribe(onNext: { [weak self] dataSet in
                self?.countriesDataSource.countriesDataSet = dataSet
                self?.tableView.reloadData()
            })
            .disposed(by: bag)

        tableView.rx.itemSelected
            .do(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .map { [weak self] in
                self?.countriesDataSource.countriesDataSet.countries[$0.row]
            }
            .filterNil()
            .bind(to: viewModel.didSelectCountry)
            .disposed(by: bag)

        tableView.refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.getData()
            })
            .disposed(by: bag)
    }

    private func showLoader() {
        activityIndicatorView.startAnimating()
    }

    private func hideLoader() {
        activityIndicatorView.stopAnimating()
    }

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
