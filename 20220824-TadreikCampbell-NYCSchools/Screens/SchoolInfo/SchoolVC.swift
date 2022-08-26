//
//  SchoolVC.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import UIKit
import Combine

final class SchoolVC: UIViewController {
    
    let schoolNameLbl: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 24, weight: .medium)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 100)
        layout.minimumInteritemSpacing = 10
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var viewModel: SchoolVCViewModel
    var observers: Set<AnyCancellable> = []
    
    init(school: School) {
        self.viewModel = SchoolVCViewModel(school: school, dataFetcher: SchoolDataFetcher.shared)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init: coder not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        schoolNameLbl.text = viewModel.school.name ?? "No name"
        view.addSubviews(schoolNameLbl, collectionView)
        collectionView.register(ScoreCell.self, forCellWithReuseIdentifier: ScoreCell.reuseID)
        collectionView.dataSource = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            schoolNameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            schoolNameLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            schoolNameLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: schoolNameLbl.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupObservers() {
        viewModel.$scores
            .receive(on: DispatchQueue.main)
            .sink { [weak self] scores in
                self?.collectionView.reloadData()
                if scores.isEmpty {
                    self?.title = "No scores available"
                } else {
                    self?.title = "Scores"
                }
            }
            .store(in: &observers)
    }
    
}

// MARK: - CollectionView Datasource
extension SchoolVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.scores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let scoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: ScoreCell.reuseID, for: indexPath) as! ScoreCell
        if let score = viewModel.scores[safe: indexPath.item] {
            scoreCell.viewModel = ScoreCellViewModel(score: score)
        }
        return scoreCell
    }
    
}
