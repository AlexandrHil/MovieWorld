//
//  MWMovieCell.swift
//  MovieWorld
//
//  Created by Alex on 1.04.21.
//

import UIKit

class MWMovieCell: UICollectionViewCell {

    static let reuseIdentifier: String = "MWMovieCell"

    private let edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    // MARK: - gui variables

    private(set) lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.backgroundColor = .darkGray
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.tintColor = .black
            label.font = UIFont.systemFont(ofSize: 17)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.tintColor = .lightGray
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubviews([
                                        self.imageView,
                                        self.titleLabel,
                                        self.dateLabel
        ])
    }

    // MARK: - constraints

    override func updateConstraints() {
        self.imageView.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }

        self.titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(self.edgeInsets.top)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
        self.dateLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(self.edgeInsets.top)
            make.left.right.bottom.equalToSuperview().inset(self.edgeInsets)
        }

        super.updateConstraints()
    }

    func set(title: String, date: Date) {
        self.titleLabel.text = title
        self.dateLabel.text = date.toString()

        self.setNeedsUpdateConstraints()
    }
}
