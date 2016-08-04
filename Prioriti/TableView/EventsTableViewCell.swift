//
//  EventsTableViewCell.swift
//  Prioriti
//
//  Created by Eric Kim on 7/21/16.
//  Copyright © 2016 com.erickim. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class EventsTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func expandSwipe(direction: MGSwipeDirection, animated: Bool) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
