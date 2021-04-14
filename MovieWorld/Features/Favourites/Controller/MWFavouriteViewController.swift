//
//  MWFavouriteViewController.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 12.04.21.
//

import UIKit

class MWFavouriteViewController: MWViewController {

    var movies: [MWMovie] = MWDB.sh.loadMovies()

    var requestRandomMovie: (() -> MWMovie?)?

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.createFlowLayout())
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never

        view.delegate = self
        view.dataSource = self

        view.register(MWMainMovieCell.self, forCellWithReuseIdentifier: MWMainMovieCell.reuseIdentifier)

        return view
    }()

    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 130, height: 237)
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)

        return layout
    }

    override func initController() {
        super.initController()

        self.controllerTitle = "Favourites"

        self.mainView.addSubview(self.collectionView)

        self.setContentScrolling(isEnabled: false)

        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
    }

    @objc private func addMovie() {
        if let movie = self.requestRandomMovie?() {
            self.movies.append(movie)
            self.collectionView.reloadData()
            MWDB.sh.save(movie: movie)
        }
    }
}

extension MWFavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWMainMovieCell.reuseIdentifier, for: indexPath) as? MWMainMovieCell ?? MWMainMovieCell()
        cell.set(movie: self.movies[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MWDB.sh.delete([self.movies[indexPath.row]]) // удаляем из бд
        self.movies.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
}
