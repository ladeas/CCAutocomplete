//
//  AutoCompleteViewController.swift
//  Autocomplete
//
//  Created by Amir Rezvani on 3/6/16.
//  Copyright © 2016 cjcoaxapps. All rights reserved.
//

import UIKit

let AutocompleteCellReuseIdentifier = "autocompleteCell"

open class AutoCompleteViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet fileprivate weak var tableView: UITableView!

    //MARK: - internal items
    internal var autocompleteItems: [AutocompletableOption]?
    internal var cellHeight: CGFloat?
    internal var cellDataAssigner: ((_ cell: UITableViewCell, _ data: AutocompletableOption) -> Void)?
    internal var textField: UITextField?
    internal let animationDuration: TimeInterval = 0.2    

    //MARK: - private properties
    fileprivate var autocompleteThreshold: Int?
    fileprivate var maxHeight: CGFloat = 0
    fileprivate var height: CGFloat = 0

    //MARK: - public properties
    open weak var delegate: AutocompleteDelegate?

    //MARK: - view life cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        shadowAutoCompleteVC()
        self.view.isHidden = true
        self.textField = self.delegate!.autoCompleteTextField()

        self.height = self.delegate!.autoCompleteHeight()
        self.view.frame = CGRect(x: self.textField!.frame.minX,
            y: self.textField!.frame.maxY,
            width: self.textField!.frame.width,
            height: self.height)

        self.tableView.register(self.delegate!.nibForAutoCompleteCell(), forCellReuseIdentifier: AutocompleteCellReuseIdentifier)
        self.textField?.addTarget(self, action: #selector(AutoCompleteViewController.textDidChange(_:)), for: UIControl.Event.editingChanged)
        self.autocompleteThreshold = self.delegate!.autoCompleteThreshold(self.textField!)
        self.cellDataAssigner = self.delegate!.getCellDataAssigner()

        self.cellHeight = self.delegate!.heightForCells()
        // not to go beyond bound height if list of items is too big
        self.maxHeight = UIScreen.main.bounds.height - self.view.frame.minY
    }
    
    func shadowAutoCompleteVC() {
        tableView.layer.shadowColor = UIColor.gray.cgColor
        tableView.layer.shadowOffset = CGSize.zero
        tableView.layer.shadowOpacity = 0.7
//        tableView.layer.shadowRadius = 4
//        let shadowRect: CGRect = CGRectInset(tableView.bounds, 0, 4);  // inset top/bottom
//        tableView.layer.shadowPath = UIBezierPath(rect: shadowRect).CGPath
        tableView.layer.shouldRasterize = true
        tableView.layer.masksToBounds = false // bug in the code
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    //MARK: - private methods
    @objc func textDidChange(_ textField: UITextField) {
        tableView.isHidden = false // showing tableView because hiding after end editing 
        let numberOfCharacters = textField.text?.count
        if let numberOfCharacters = numberOfCharacters {
            if numberOfCharacters > self.autocompleteThreshold! {
                self.view.isHidden = false
                guard let searchTerm = textField.text else { return }
                self.autocompleteItems = self.delegate!.autoCompleteItemsForSearchTerm(searchTerm)
                UIView.animate(withDuration: self.animationDuration,
                    delay: 0.0,
                    options: .curveEaseInOut,
                    animations: { () -> Void in
                        let minHeight = min(
                            CGFloat(self.autocompleteItems!.count) * CGFloat(self.cellHeight!),
                            self.maxHeight,
                            self.height
                        )
                        self.view.frame.size.height = minHeight
                        self.tableView.frame.size.height = minHeight
                    },
                    completion: nil)

                UIView.transition(with: self.tableView,
                    duration: self.animationDuration,
                    options: .transitionCrossDissolve,
                    animations: { () -> Void in
                        self.tableView.reloadData()
                    },
                    completion: nil)

            } else {
                self.view.isHidden = true
            }
        }
    }

}
