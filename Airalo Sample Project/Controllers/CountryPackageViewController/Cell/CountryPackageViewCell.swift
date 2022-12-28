import UIKit
import Stevia

class CountryPackageViewCell: UITableViewCell {
    private let eSimImageView = UIImageView()
    private let packageDetailsView = UIView()
    private let gradientView = LinearGradientView()
    private let packageTitleLabel = UILabel()
    private let packageCountryLabel = UILabel()
    private let dataImageView = UIImageView()
    private let dataLabel = UILabel()
    private let dataValueLabel = UILabel()
    private let validityImageView = UIImageView()
    private let validityLabel = UILabel()
    private let validityValueLabel = UILabel()
    private let buyNowButton = UIButton()
    private let separatorView1 = UIView()
    private let separatorView2 = UIView()
    private let separatorView3 = UIView()
    
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
        
        eSimImageView.backgroundColor = UIColor.white.withAlphaComponent(0)
        eSimImageView.applyShadow()
        
        packageDetailsView.backgroundColor = UIColor.white.withAlphaComponent(0)
        packageDetailsView.applyShadow()
        
        packageTitleLabel.font = UIFont.ibmPlexSansSemiBold(19)
        packageTitleLabel.textColor = UIColor(hex: 0x4A4A4A)
        packageCountryLabel.font = UIFont.ibmPlexSansMedium(13)
        packageCountryLabel.textColor = UIColor(hex: 0x4A4A4A)
        
        gradientView.layer.cornerRadius = 7
        gradientView.clipsToBounds = true
        
        dataImageView.image = UIImage(named: "Data")?.withRenderingMode(.alwaysTemplate)
        dataLabel.font = UIFont.ibmPlexSansSemiBold(11)
        dataLabel.textColor = UIColor(hex: 0x4A4A4A)
        dataValueLabel.font = UIFont.ibmPlexSansMedium(17)
        dataValueLabel.textColor = UIColor(hex: 0x4A4A4A)
        dataValueLabel.textAlignment = .right
       
        validityImageView.image = UIImage(named: "Validity")?.withRenderingMode(.alwaysTemplate)
        validityLabel.font = UIFont.ibmPlexSansMedium(11)
        validityLabel.textColor = UIColor(hex: 0x4A4A4A)
        validityValueLabel.font = UIFont.ibmPlexSansMedium(17)
        validityValueLabel.textColor = UIColor(hex: 0x4A4A4A)
        validityValueLabel.textAlignment = .right
        
        buyNowButton.backgroundColor = .clear
        buyNowButton.layer.cornerRadius = 7
        buyNowButton.layer.borderColor = UIColor(hex: 0x4A4A4A).cgColor
        buyNowButton.layer.borderWidth = 1
        buyNowButton.setTitleColor(UIColor(hex: 0x4A4A4A), for: .normal)
        
        contentView.subviews {
            packageDetailsView
            eSimImageView
        }
        packageDetailsView.subviews {
            gradientView
            packageTitleLabel
            packageCountryLabel
            separatorView1
            dataImageView
            dataLabel
            dataValueLabel
            separatorView2
            validityImageView
            validityLabel
            validityValueLabel
            separatorView3
            buyNowButton
        }
    }
    
    private func setUpLayout() {
        eSimImageView.width(140).height(88)
        eSimImageView.top(0)
        eSimImageView.Right == packageDetailsView.Right - 20
        
        packageDetailsView.left(20).right(20).top(20).bottom(20)
        packageDetailsView.height(288)
        
        [separatorView1, separatorView2, separatorView3].forEach {
            $0.height(1)
            $0.backgroundColor = UIColor(hex: 0x232323).withAlphaComponent(0.1)
        }
        
        gradientView.fillContainer()
        packageTitleLabel.left(20).top(20)
        packageTitleLabel.Right == eSimImageView.Left - 20
        packageCountryLabel.left(20)
        packageCountryLabel.Top == packageTitleLabel.Bottom + 5
        packageCountryLabel.Right == eSimImageView.Left - 20
        
        packageDetailsView.layout {
            88
            |-0-separatorView1-0-|
            17
            |-20-dataImageView-10-dataLabel-10-dataValueLabel-20-|
            17
            |-0-separatorView2-0-|
            17
            |-20-validityImageView-10-validityLabel-10-validityValueLabel-20-|
            17
            |-0-separatorView3-0-|
            17
            |-20-buyNowButton-20-| ~ 44
        }
        
        dataImageView.size(22)
        dataLabel.CenterY == dataImageView.CenterY
        dataValueLabel.CenterY == dataImageView.CenterY
        validityImageView.size(22)
        validityLabel.CenterY == validityImageView.CenterY
        validityValueLabel.CenterY == validityImageView.CenterY
        
    }
    
    func prepare(with package: CountryPackage) {
        eSimImageView.kf.setImage(with: package.operator.image.url)
        
        packageTitleLabel.attributedText = NSMutableAttributedString(string: package.operator.title).kern(-0.2).lineHeight(22)
        packageCountryLabel.attributedText = NSMutableAttributedString(string: package.operator.countries.first?.title ?? "").lineHeight(15)
        
        dataLabel.attributedText = NSMutableAttributedString(string: "DATA").kern(1).lineHeight(14)
        dataValueLabel.attributedText = NSMutableAttributedString(string: package.data).kern(1).lineHeight(20)
        validityLabel.attributedText = NSMutableAttributedString(string: "VALIDITY").kern(1).lineHeight(14)
        validityValueLabel.attributedText = NSMutableAttributedString(string: package.validity).kern(1).lineHeight(20)
        
        let buttonTitle = NSMutableAttributedString(string: "\(package.price) - BUY NOW")
            .font(UIFont.ibmPlexSansSemiBold(11))
            .lineHeight(11)
            .kern(1)
        buyNowButton.setAttributedTitle(buttonTitle, for: .normal)
        
        gradientView.startColor = UIColor(hexString: package.operator.gradient_start)
        gradientView.endColor = UIColor(hexString: package.operator.gradient_end)
        gradientView.setNeedsDisplay()
        
        let styleColor = package.operator.style == .light ? UIColor.white : UIColor(hex: 0x4A4A4A)
        [packageTitleLabel, packageCountryLabel, dataLabel, dataValueLabel, validityLabel, validityValueLabel, buyNowButton.titleLabel].forEach {
            $0?.textColor = styleColor
        }
        buyNowButton.layer.borderColor = styleColor.cgColor
        dataImageView.tintColor = styleColor
        validityImageView.tintColor = styleColor
    }
}
