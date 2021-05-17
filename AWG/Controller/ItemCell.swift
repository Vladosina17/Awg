//
//  ItemCell.swift
//  AWG
//
//  Created by Влад Барченков on 16.05.2021.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    static let reuseId = "itemCell"
    
    private var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.tintColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.tintColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 5
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(itemImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 2 + 40).isActive = true
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
    
    func setupCell(item: Item) {
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: item.image) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.itemImageView.image = UIImage(data: imageData)
            }
        }
        titleLabel.text = item.title
        priceLabel.text = String(item.price) + " ₽"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
