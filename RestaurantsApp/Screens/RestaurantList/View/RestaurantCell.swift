//
//  RestaurantCell.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation
import UIKit

class RestaurantCell: UITableViewCell {
    // MARK: Subviews
    private var viewModel: RestaurantCellViewModel?

    private let detailsContainer: UIStackView = UIStackView()
    private let ratingContainer: UIStackView = UIStackView()
    private let thumbnailView: UIImageView = UIImageView()
    private let favouriteButton: UIButton = UIButton()
    private let titleLabel: UILabel = UILabel()
    private let subtitleLabel: UILabel = UILabel()

    private let ratingImageView: UIImageView = UIImageView()
    private let ratingLabel: UILabel = UILabel()

    // MARK: Properties
    static var identifier: String {
        return String(describing: Self.self)
    }

    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupStyles()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public methods
    func setup(viewModel: RestaurantCellViewModel) {
        self.viewModel = viewModel
        updateViewDetails()
        thumbnailView.image = AppImage.placeholder
        favouriteButton.removeTarget(nil, action: nil, for: .allEvents)
        favouriteButton.addTarget(viewModel, action: #selector(RestaurantCellViewModel.favouriteTapped), for: .touchUpInside)
        viewModel.imageUrl.map { thumbnailView.loadAsync(url: $0) }
        viewModel.onUpdate = { [weak self] in self?.updateViewDetails() }
    }

    func updateViewDetails() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        ratingLabel.text = viewModel.rating
        favouriteButton.setImage(viewModel.favouriteImage, for: .normal)
    }
}

// MARK: Private extension
private extension RestaurantCell {
    func setupSubviews() {
        setupDetailsContainer()
        setupRatingsContainer()

        contentView.addSubview(ratingContainer)
        contentView.addSubview(detailsContainer)
        ratingContainer.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.translatesAutoresizingMaskIntoConstraints = false

        // Container constraints
        NSLayoutConstraint.activate([
            detailsContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            detailsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailsContainer.bottomAnchor.constraint(equalTo: ratingContainer.topAnchor),
            ratingContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setupDetailsContainer() {
        detailsContainer.alignment = .center
        detailsContainer.axis = .horizontal
        detailsContainer.spacing = Constants.horizontalSpacing
        detailsContainer.isLayoutMarginsRelativeArrangement = true
        detailsContainer.layoutMargins = UIEdgeInsets(top: Constants.padding,
                                                      left: Constants.padding,
                                                      bottom: Constants.verticalSpacing,
                                                      right: Constants.padding)
        let labelsContainer = UIStackView()
        labelsContainer.spacing = Constants.verticalSpacing
        labelsContainer.axis = .vertical
        labelsContainer.addArrangedSubview(titleLabel)
        labelsContainer.addArrangedSubview(subtitleLabel)

        detailsContainer.addArrangedSubview(thumbnailView)
        detailsContainer.addArrangedSubview(labelsContainer)
        detailsContainer.addArrangedSubview(favouriteButton)

        NSLayoutConstraint.activate([
            thumbnailView.heightAnchor.constraint(equalToConstant: Constants.thumbnailSize),
            thumbnailView.widthAnchor.constraint(equalToConstant: Constants.thumbnailSize),
            favouriteButton.heightAnchor.constraint(equalToConstant: Constants.favouriteSize),
            favouriteButton.widthAnchor.constraint(equalToConstant: Constants.favouriteSize)
        ])
    }

    func setupRatingsContainer() {
        ratingContainer.axis = .horizontal
        ratingContainer.distribution = .equalCentering
        ratingContainer.isLayoutMarginsRelativeArrangement = true
        ratingContainer.layoutMargins = UIEdgeInsets(top: 0,
                                                     left: Constants.padding,
                                                     bottom: Constants.padding,
                                                     right: Constants.padding)

        ratingImageView.image = AppImage.theforkIcon
        ratingLabel.text = "5.6"

        let theForkContainer = UIStackView()
        theForkContainer.alignment = .center
        theForkContainer.spacing = Constants.horizontalSpacing / 2
        theForkContainer.addArrangedSubview(ratingImageView)
        theForkContainer.addArrangedSubview(ratingLabel)

        ratingContainer.addArrangedSubview(theForkContainer)

        NSLayoutConstraint.activate([
            ratingImageView.heightAnchor.constraint(equalToConstant: 15),
            ratingImageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }

    func setupStyles() {
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        ratingLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textColor = .gray
        favouriteButton.contentMode = .scaleAspectFit
        thumbnailView.contentMode = .scaleAspectFit
        thumbnailView.tintColor = .gray
        thumbnailView.layer.cornerRadius = Constants.thumbnailBorderRadius
        thumbnailView.layer.masksToBounds = true
    }

    private enum Constants {
        static let padding: CGFloat = 18.0
        static let horizontalSpacing: CGFloat = 16.0
        static let verticalSpacing: CGFloat = 8.0
        static let thumbnailSize: CGFloat = 64.0
        static let thumbnailBorderRadius: CGFloat = 8.0
        static let favouriteSize: CGFloat = 26.0
    }
}
