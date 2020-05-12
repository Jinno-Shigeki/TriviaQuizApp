//
//  CheckView.swift
//  ZatsugakuQuizApp
//
//  Created by 神野成紀 on 2020/05/02.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class CheckView: UIView {

    @IBOutlet weak var answerImage: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        answerLabel.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 7
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
