//
//  LaunchCell.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/20/22.
//

import UIKit

class LaunchCell: UICollectionViewCell {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var launchImageView: UIImageView!
    @IBOutlet private var flightNumberLabel: UILabel!
    @IBOutlet private var stateIcon: UIImageView!
    @IBOutlet private var stateLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var informationLabel: UILabel!

    var launchImage: UIImage? {
        didSet {
            launchImageView.image = launchImage
        }
    }

    var flightNumber: String? {
        didSet {
            flightNumberLabel.text = flightNumber
        }
    }

    var launchState: LaunchState? {
        didSet {
            stateLabel.text = launchState?.rawValue
            stateIcon.image = launchState?.icon

            switch launchState {
            case .success:
                stateIcon.tintColor = .systemGreen
            default:
                stateIcon.tintColor = .systemRed

            }
        }
    }

    var date: String? {
        didSet {
            dateLabel.text = date
        }
    }

    var information: String? {
        didSet {
            informationLabel.text = information
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let screenWidth = UIScreen.main.bounds.width
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: screenWidth - 32)
        ])
        containerView.layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        launchImageView.image = nil
    }

    // MARK: - Theme
    func applyTheme() {
        containerView.backgroundColor = .systemBackground
    }
}
