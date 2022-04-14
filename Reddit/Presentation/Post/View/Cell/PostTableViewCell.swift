//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 14/04/22.
//

import UIKit
import SDWebImage

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var viewCardBottom: UIView!
    @IBOutlet weak var lblTitlePost: UILabel!
    @IBOutlet weak var btnArrowUp: UIButton!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var btnArrowDown: UIButton!
    @IBOutlet weak var imgComment: UIImageView!
    @IBOutlet weak var lblCountComments: UILabel!
    
    var urlImgPost: String = "" {
        didSet {
            guard let urlImgName = URL(string: urlImgPost) else {
                imgPost.image = UIImage(named: "imgDefaultPost")
                imgPost.contentMode = .scaleToFill
                return
            }
            imgPost.sd_setImage(with: urlImgName, placeholderImage: UIImage(named: "imgDefaultPost"), options: .allowInvalidSSLCertificates, progress: nil, completed: nil)
            imgPost.contentMode = .scaleToFill
        }
    }
    
    var titlePost: String = "" {
        didSet {
            lblTitlePost.text = titlePost
            lblTitlePost.font = UIFont(name: "HelveticaNeue-Regular", size: 20)
            lblTitlePost.textColor = ColorPalette.DesignSystem.titleColor
            lblTitlePost.numberOfLines = 0
            lblTitlePost.textAlignment = .left
        }
    }
    
    var nameImgArrowUp: String = "" {
        didSet {
            btnArrowUp.setTitle("", for: .normal)
            btnArrowUp.setImage(UIImage(named: nameImgArrowUp), for: .normal)
        }
    }
    
    var scorePost: String = "" {
        didSet {
            lblScore.text = scorePost
            lblScore.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
            lblScore.textColor = ColorPalette.DesignSystem.descriptionColor
            lblScore.numberOfLines = 1
            lblScore.textAlignment = .left
        }
    }
    
    var nameImgArrowDown: String = "" {
        didSet {
            btnArrowDown.setTitle("", for: .normal)
            btnArrowDown.setImage(UIImage(named: nameImgArrowDown), for: .normal)
        }
    }
    
    var countCommentsPost: String = "" {
        didSet {
            lblCountComments.text = countCommentsPost
            lblCountComments.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
            lblCountComments.textColor = ColorPalette.DesignSystem.descriptionColor
            lblCountComments.numberOfLines = 1
            lblCountComments.textAlignment = .left
        }
    }
    
    var nameImgComment: String = "" {
        didSet {
            imgComment.image = UIImage(named: nameImgComment)
        }
    }
    
    static let identifier = "PostTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PostTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI() {
        configureCard()
    }
    
    func configureCard() {
        viewCard.backgroundColor = .white
        viewCard.layer.cornerRadius = 8
        viewCard.layer.shadowColor = UIColor.black.cgColor
        viewCard.layer.shadowOpacity = 0.16
        viewCard.layer.shadowOffset = .zero
        viewCard.layer.shadowRadius = 5
        
        viewCardBottom.layer.cornerRadius = 8
        viewCardBottom.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
}
