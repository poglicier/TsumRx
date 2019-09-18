//
//  CountryInfoViewController.swift
//  rxFun
//
//  Created Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import RxSwift

class CountryInfoViewController: UIViewController, Storyboardable {
    // MARK: - Public
    var viewModel: CountryInfoViewModelProtocol!
    var country: Country!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
        setupViews()
        bind()
        viewModel.moduleDidLoad()
    }
    // MARK: - Private
    @IBOutlet private var infoDataSource: InfoDataSource!
    @IBOutlet private var tableView: UITableView!
    private let bag = DisposeBag()
    private var countriesDataSet: CountriesDataSet!

    private func setupDataSource() {
        infoDataSource.country = country
    }

    private func setupViews() {
        title = country.name
    }

    private func bind() {
        viewModel.countriesDataSet.subscribe(onNext: { [weak self] dataSet in
            self?.countriesDataSet = dataSet
            self?.infoDataSource.countriesDataSet = dataSet
        })
        .disposed(by: bag)

        tableView.rx.itemSelected
            .filter { $0.section == InfoDataSource.Section.boundaries.rawValue }
            .do(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .map { [weak self] indexPath -> Country? in
                guard let self = self else { return nil }
                return self.countriesDataSet.country(byCioc: self.country.borders[indexPath.row])
            }
            .filterNil()
            .bind(to: viewModel.didSelectCountry)
            .disposed(by: bag)

        tableView.rx.setDelegate(self)
            .disposed(by: bag)
    }
}

extension CountryInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionEnum = InfoDataSource.Section(rawValue: section) else { return 0 }
        var res: CGFloat = 0.01
        switch sectionEnum {
        case .base:
            res = 44
        case .boundaries:
            res = country.borders.count > 0 ? 44 : 0.01
        case .currencies:
            res = (country.currencies?.count ?? 0) > 0 ? 44 : 0.01
        case .count:
            break
        }
        return res
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let sectionEnum = InfoDataSource.Section(rawValue: section) else { return 0 }
        var res: CGFloat = 0.01
        switch sectionEnum {
        case .base, .boundaries, .count:
            break
        case .currencies:
            res = (country.currencies?.count ?? 0) > 0 ? 44 : 0.01
        }
        return res
    }
}
