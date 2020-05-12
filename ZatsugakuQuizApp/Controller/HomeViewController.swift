//
//  ViewController.swift
//  ZatsugakuQuizApp
//
//  Created by 神野成紀 on 2020/04/08.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellTitle = ["歴史","音楽","科学","文学","漫画・アニメ","スポーツ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        cellLayout()
        
        let nib = UINib(nibName: "CostomCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }

    func cellLayout(){
        let cellLayout = UICollectionViewFlowLayout()
            cellLayout.minimumLineSpacing = 30
            cellLayout.itemSize = CGSize(width: 120, height: 120)
            cellLayout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
        collectionView.collectionViewLayout = cellLayout
    }
}
//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
        nextView.cellTitleName = cellTitle[indexPath.row]
        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true, completion: nil)
    }
}
//MARK: -UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellTitle.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CostomCell
        cell.cellTitleLabel.text = cellTitle[indexPath.row]
        return cell
    }
}



