//
//  AirPortTableViewCell.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-17.
//

import UIKit

class AirPortTableViewCell: UITableViewCell,NibLoadableView,ReusableView  {

    @IBOutlet weak var travelersScoreLabel: UILabel!
    @IBOutlet weak var flightsScoreLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var iataCodeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameCityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ model: AirPortModel) {
        nameCityLabel.text = (model.name ?? "") + " " + (model.address?.cityName ?? "")
        distanceLabel.text = "\(model.distance?.value ?? 0)" + (model.distance?.unit ?? "")
        iataCodeLabel.text = model.iataCode ?? ""
        timeZoneLabel.text = model.timeZoneOffset ?? ""
        flightsScoreLabel.text = "\(model.analytics?.flights?.score ?? 0)"
        travelersScoreLabel.text = "\(model.analytics?.travelers?.score ?? 0)"
    }
    
}
