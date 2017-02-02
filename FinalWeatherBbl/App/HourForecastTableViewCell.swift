//
//  HourForecastTableViewCell.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 29/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import UIKit

protocol HourForecastCellProtocol {
    var forecast : Forecast? { get }
}

class HourForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    private var delegate: HourForecastCellProtocol?
    private let imageMapper = Constants.WeatherImageMapper()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    internal func configure(withDelegate delegate: HourForecastCellProtocol) {
        
        self.delegate = delegate
        
        guard delegate.forecast != nil else { return }
        
        if let hourString = delegate.forecast?.hourString {
            self.hourLabel.text = hourString + "h"
        } else {
            self.hourLabel.text = EmptyString
        }
        
        if let tempMin = delegate.forecast?.temp_min {
            let t = Int(Double(tempMin).convertKelvinToCelsius()).description + Constants.Celcius
            self.tempMinLabel.text  = t ?? EmptyString
        }
        
        if let tempMax = delegate.forecast?.temp_max {
            let t = Int(Double(tempMax).convertKelvinToCelsius()).description + Constants.Celcius
            self.tempMaxLabel.text  = t ?? EmptyString
        }
        
        if let imageIcon = delegate.forecast?.weatherIcon {
            self.weatherImage.image = UIImage(named: imageMapper.imageName(weatherIcon: imageIcon))
        } else {
            self.weatherImage.image = nil
        }
    }
}