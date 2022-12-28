import UIKit
import Stevia
import Kingfisher

class LocalESIMViewCell: UITableViewCell {
    private let containerView = UIView()
    private let flagImageView = UIImageView()
    private let label = UILabel()
    private let arrowView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpSubviews()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 7
        containerView.applyShadow()
        
        label.font = UIFont.ibmPlexSansMedium(13)
        label.textColor = UIColor(hex: 0x4A4A4A)
        
        arrowView.image = UIImage(named: "Arrow")
        
        contentView.subviews {
            containerView
        }
        containerView.subviews {
            flagImageView
            label
            arrowView
        }
    }
    
    private func setUpLayout() {
        containerView.top(0).left(20).right(20).bottom(14).height(55)
        align(horizontally: |-20-flagImageView-15-label-14-arrowView-20-|)
        
        flagImageView.width(37).height(28)
        arrowView.width(7).height(12)
        
        flagImageView.centerVertically()
        label.centerVertically()
        arrowView.centerVertically()
    }
    
    func prepare(with eSIM: LocalESIM) {
        flagImageView.kf.setImage(with: eSIM.image.url)
        label.text = eSIM.title
    }
}
