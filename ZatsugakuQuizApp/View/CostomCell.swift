//
//  CostomCell.swift
//  ZatsugakuQuizApp
//
//  Created by 神野成紀 on 2020/04/11.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class CostomCell: UICollectionViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var outsideView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        outsideView.layer.cornerRadius = outsideView.frame.height / 10
        insideView.layer.cornerRadius = outsideView.frame.height / 10
    }

}
