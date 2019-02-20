//
//  ViewController.swift
//  Autocomplete
//
//  Created by Amir Rezvani on 3/6/16.
//  Copyright © 2016 cjcoaxapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countriesTextField: UITextField!
    @IBOutlet weak var autocompleteContainerView: UIView!
    @IBOutlet weak var lblSelectedCountryName: UILabel!

    var autoCompleteViewController: AutoCompleteViewController!


    let countriesList = countries
    var isFirstLoad: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if self.isFirstLoad {
            self.isFirstLoad = false
            Autocomplete.setupAutocompleteForViewcontroller(self)
        }
    }
}

extension ViewController: AutocompleteDelegate {
    func autoCompleteTextField() -> UITextField {
        return self.countriesTextField
    }
    func autoCompleteThreshold(_ textField: UITextField) -> Int {
        return 1
    }

    func autoCompleteItemsForSearchTerm(_ term: String) -> [AutocompletableOption] {
        let filteredCountries = self.countriesList.filter { (country) -> Bool in
            return country.lowercased().contains(term.lowercased())
        }

        let countriesAndFlags: [AutocompletableOption] = filteredCountries.map { ( country) -> AutocompleteCellData in
            var country = country
            country.replaceSubrange(country.startIndex...country.startIndex, with: String(country[country.startIndex]).capitalized)
            return AutocompleteCellData(text: country, image: UIImage(named: country)) 
            }.map( { $0 as AutocompletableOption })

        return countriesAndFlags
    }

    func autoCompleteHeight() -> CGFloat {
        return self.view.frame.height / 3.0
    }


    func didSelectItem(_ item: AutocompletableOption) {
        self.lblSelectedCountryName.text = item.text
    }
}
