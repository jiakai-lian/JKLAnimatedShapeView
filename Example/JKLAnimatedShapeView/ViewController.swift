//
//  ViewController.swift
//  JKLAnimatedShapeView
//
//  Created by Jacky Jiakai Lian on 04/09/2016.
//  Copyright (c) 2016 Jacky Jiakai Lian. All rights reserved.
//

import UIKit
import JKLAnimatedShapeView

class ViewController: UIViewController {
    @IBOutlet weak var animatedShapeView: JKLAnimatedShapeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        animatedShapeView.animateToTrapeziumShape(completionBlock: nil)
        animatedShapeView.animateToShape(JKLShapeAnimationRectToTrapezium(),completionBlock:nil)

    }

}

