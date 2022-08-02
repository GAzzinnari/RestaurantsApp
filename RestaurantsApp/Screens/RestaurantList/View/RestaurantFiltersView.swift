//
//  RestaurantFiltersView.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import UIKit

class RestaurantFiltersView: UIView {
    // MARK: Subviews
    private let container: UIStackView = UIStackView()
    private let sortControlsContainer: UIStackView = UIStackView()
    private let sortButton: UIButton = UIButton()
    private let ratingButton: UIButton = UIButton()
    private let nameButton: UIButton = UIButton()
    private let noneButton: UIButton = UIButton()

    // MARK: Bindings
    var onNameSortTapped: () -> Void = { }
    var onRatingSortTapped: () -> Void = { }
    var onNoneSortTapped: () -> Void = { }

    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupSortingControls()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(container)
        container.addArrangedSubview(sortButton)
        container.axis = .vertical
        container.alignment = .leading
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        container.spacing = 8.0

        sortButton.setTitle("Sort", for: .normal)
        sortButton.setImage(AppImage.sort, for: .normal)
        sortButton.setTitleColor(.black, for: .normal)
        sortButton.addTarget(self, action: #selector(toggleSortControlsVisibility), for: .touchUpInside)

        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupSortingControls() {
        container.addArrangedSubview(sortControlsContainer)

        sortControlsContainer.axis = .horizontal
        sortControlsContainer.spacing = 12
        nameButton.isHidden = true
        noneButton.isHidden = true
        ratingButton.isHidden = true

        sortControlsContainer.addArrangedSubview(ratingButton)
        sortControlsContainer.addArrangedSubview(nameButton)
        sortControlsContainer.addArrangedSubview(noneButton)

        ratingButton.setTitle("Rating", for: .normal)
        ratingButton.setTitleColor(.black, for: .normal)
        ratingButton.addTarget(self, action: #selector(didTapRatingButton), for: .touchUpInside)
        nameButton.setTitle("Name", for: .normal)
        nameButton.setTitleColor(.black, for: .normal)
        nameButton.addTarget(self, action: #selector(didTapNameButton), for: .touchUpInside)
        noneButton.setTitle("None", for: .normal)
        noneButton.setTitleColor(.black, for: .normal)
        noneButton.addTarget(self, action: #selector(didTapNoneButton), for: .touchUpInside)
    }

    @objc
    func toggleSortControlsVisibility() {
        UIView.animate(withDuration: 0.1) {
            self.nameButton.isHidden.toggle()
            self.noneButton.isHidden.toggle()
            self.ratingButton.isHidden.toggle()
        }
    }

    @objc
    func didTapRatingButton() {
        onRatingSortTapped()
        toggleSortControlsVisibility()
    }

    @objc
    func didTapNameButton() {
        onNameSortTapped()
        toggleSortControlsVisibility()
    }

    @objc
    func didTapNoneButton() {
        onNoneSortTapped()
        toggleSortControlsVisibility()
    }
}
