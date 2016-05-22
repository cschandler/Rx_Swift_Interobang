//
//  ViewController.swift
//  Rx_Swift_starter
//
//  Created by Charles Chandler on 5/22/16.
//  Copyright © 2016 WillowTree, Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var topState: ButtonState = .ON {
        didSet {
            changeButton(topButton, state: topState)
        }
    }
    var bottomState: ButtonState = .OFF {
        didSet {
            changeButton(bottomButton, state: bottomState)
        }
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topButton.rx_tap
            .subscribeNext { _ in
                self.topState = .ON
                self.bottomState = .OFF
            }
            .addDisposableTo(disposeBag)
        
        bottomButton.rx_tap
            .subscribeNext { _ in
                self.topState = .OFF
                self.bottomState = .ON
            }
            .addDisposableTo(disposeBag)        
    }
    
    func changeButton(button: UIButton, state: ButtonState) {
        button.backgroundColor = state == .ON ? UIColor.greenColor() : UIColor.redColor()
        button.setTitle(state.rawValue, forState: .Normal)
    }
    
    enum ButtonState: String {
        case ON
        case OFF
    }
}

