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
    
    var topState: Variable<ButtonState> = Variable(.ON)
    var bottomState: Variable<ButtonState> = Variable(.OFF)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topButton.rx_tap
            .debug("top")
            .subscribe { _ in
                self.topState.value = .ON
                self.bottomState.value = .OFF
            }
            .addDisposableTo(disposeBag)
        
        bottomButton.rx_tap
            .debug("bottom")
            .subscribe { _ in
                self.topState.value = .OFF
                self.bottomState.value = .ON
            }
            .addDisposableTo(disposeBag)
        
        _ = topState
            .asObservable()
            .subscribeNext { state in
                self.changeButton(self.topButton, state: state)
            }
        
        _ = bottomState
            .asObservable()
            .subscribeNext { state in
                self.changeButton(self.bottomButton, state: state)
            }
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

