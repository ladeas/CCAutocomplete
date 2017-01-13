//
//  AutoCompleteCell.swift
//  Autocomplete
//
//  Created by Amir Rezvani on 3/6/16.
//  Copyright © 2016 cjcoaxapps. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var chablisColor: UIColor {
        return UIColor(red: (255/255.0), green: (242/255.0), blue: (242/255.0), alpha: 1.0)
    }
    
    class var whiteSmoke: UIColor {
        return UIColor(red: (241/255.0), green: (241/255.0), blue: (241/255.0), alpha: 1.0)
    }
    
    class var gray71: UIColor {
        return UIColor(red: (181/255.0), green: (181/255.0), blue: (181/255.0), alpha: 1.0)
    }
    
    class var darkTurquoise: UIColor {
        return UIColor(red: (3/255.0), green: (205/255.0), blue: (213/255.0), alpha: 1.0)
    }
    
    class var carminePink: UIColor {
        return UIColor(red: (240/255.0), green: (80/255.0), blue: (80/255.0), alpha: 1.0) // #EE5254
    }
    
    class var pastelGreen: UIColor {
        return UIColor(red: (7/255.0), green: (212/255.0), blue: (25/255.0), alpha: 1.0) // #07D419
    }
    
    class var textGray: UIColor {
        return UIColor(red: (155/255.0), green: (155/255.0), blue: (155/255.0), alpha: 1.0) // #9B9B9B
    }
    
    class var veryLightBlue: UIColor {
        return UIColor(red: (242/255.0), green: (251/255.0), blue: (252/255.0), alpha: 1.0) // #F2FBFC
    }
}


public class AutoCompleteCell: UITableViewCell {
    //MARK: - outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!

    //MARK: - public properties
    public var textImage: AutocompleteCellData? {
        didSet {
            self.lblTitle.text = textImage!.text
            self.imgIcon.image = textImage!.image
            self.lblTitle.textColor = UIColor.textGray
            self.lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 16)
            self.selectionStyle = UITableViewCellSelectionStyle.none
        }
    }
}
