//
//  ProductCell.swift
//  MVVMProducts
//
//  Created by Pankaj Sachdeva on 05.12.23.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    var product: Product? {
        didSet {
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15
        productImageView.layer.cornerRadius = 10
        productBackgroundView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func productDetailConfiguration() {
        guard let product = product else { return }
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        descriptionLabel.text = product.description
        rateLabel.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
}
