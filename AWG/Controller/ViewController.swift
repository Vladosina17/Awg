//
//  ViewController.swift
//  AWG
//
//  Created by Влад Барченков on 14.05.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let service = Service()
    
    var menClothing: [Item]?
    var electronics: [Item]?
    var jewelery: [Item]?
    var womenClothing: [Item]?
    
    var rowToDisplay: [Item]?
    
    private var itemCollectionView: UICollectionView!
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: .zero, height: 50)
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private let segmentedControl: NoSwipeSegmentedControl = {
        let segmentControl = NoSwipeSegmentedControl(items: ["Men clothing", "Electronics", "Jewelery", "Women clothing"])
        segmentControl.backgroundColor = .none
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(handleSegmentControl), for: .valueChanged)
        return segmentControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        service.getData(url: "https://ecomm-4e14.restdb.io/rest/products") { (model) in
            guard let model = model else { return }
            self.menClothing = model.filter {$0.category == "men clothing"}
            self.electronics = model.filter {$0.category == "electronics"}
            self.jewelery = model.filter {$0.category == "jewelery"}
            self.womenClothing = model.filter {$0.category == "women clothing"}
            
            self.rowToDisplay = self.menClothing
            self.itemCollectionView.reloadData()
        }
        
        setupCollectionView()
        setupConstraint()
    }
    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width / 2 + 40, height: 250)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        itemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        itemCollectionView.showsVerticalScrollIndicator = false
        itemCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId)
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.backgroundColor = .clear
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
    }
    
    private func setupConstraint() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(segmentedControl)
        view.addSubview(scrollView)
        view.addSubview(itemCollectionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 80),
        ])

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            itemCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    //MARK: - Action
    @objc private func handleSegmentControl() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            rowToDisplay = menClothing
        case 1:
            rowToDisplay = electronics
        case 2:
            rowToDisplay = jewelery
        default:
            rowToDisplay = womenClothing
        }
        
        itemCollectionView.reloadData()
    }
    

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = rowToDisplay else { return 0}
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseId, for: indexPath) as? ItemCell,
              let item = rowToDisplay?[indexPath.row] else { return ItemCell() }
        cell.setupCell(item: item)
        return cell
    }
}





