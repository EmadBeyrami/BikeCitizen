//
//  LocationTableViewCell.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productTitle: UILabel!
    @IBOutlet var productSubtitle: UILabel!
    @IBOutlet var favBtn: UIButton!
    
    private var model: SearchModel?
    private let favImage: UIImage = UIImage(systemName: "suit.heart.fill")!
    private let unfaveImage: UIImage = UIImage(systemName: "suit.heart")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        productImageView.image = nil
        favBtn.setImage(nil, for: .normal)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        favBtn.tintColor = UIColor.blackWhite
    }
    
    private func setupView() {
        // productImageView
        productImageView.contentMode = .scaleToFill
        
        // productTitle
        productTitle.font = UIFont.boldSystemFont(ofSize: 14)
        productTitle.textAlignment = LanguageManager.shared.currentLanguage.textAlignment
        
        // productSubtitle
        productSubtitle.font = UIFont.systemFont(ofSize: 14, weight: .light)
        productSubtitle.textColor = .gray
        productSubtitle.textAlignment = LanguageManager.shared.currentLanguage.textAlignment
        productSubtitle.numberOfLines = 2
        
        favBtn.addTarget(self, action: #selector(didTapFavBtn), for: .touchUpInside)
    }
    
    @objc private func didTapFavBtn() {
        guard let id = model?.id else { return }
        favBtnDidTap(id)
    }
    
    private var favBtnDidTap: DataCompletion<String> = { _ in }
    public func bindFavButton(_ action: @escaping DataCompletion<String>) {
        self.favBtnDidTap = action
    }
}

extension LocationTableViewCell: BikeCitizenTableViewCell {
    
    func configureCellWith(_ item: SearchModel) {
        model = item
        if let url = URL(string: item.iconURL ?? "") {
            productImageView.load(url: url)
        }
        productTitle.text = item.name ?? ""
        productSubtitle.text = item.summary ?? ""
        
        favBtn.setImage(item.isFavorite ? favImage : unfaveImage, for: .normal)
    }
}
