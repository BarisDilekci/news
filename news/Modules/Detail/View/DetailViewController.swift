//
//  DetailViewController.swift
//  news
//
//  Created by Barış Dilekçi on 24.05.2025.
//

import Foundation
import UIKit

protocol DetailViewProtocol : AnyObject {
    var presenter : DetailPresenterProtocol? { get set }
}
final class DetailViewController : UIViewController, DetailViewProtocol {
    
    var presenter: (any DetailPresenterProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
    }
}
