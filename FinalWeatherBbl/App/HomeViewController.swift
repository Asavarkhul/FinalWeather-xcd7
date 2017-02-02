//
//  ViewController.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import UIKit

extension HomeViewController: HourForecastDataSourceDelegate {
    
}

extension HomeViewController: DayForecastDataSourceDelegate {
    
}

class HomeViewController: UIViewController {
    
    let ctm = ContextManager.sharedInstance
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var approxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var realTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var todayDateLabel: UILabel!
    
    @IBOutlet weak var dayForcastCollectionView: UICollectionView!
    @IBOutlet weak var hourForecastTableView: UITableView!
    
    var hourForecastDatasource : HourForecastDataSource?
    var dayForecastDatasource  : DayForecastDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hourForecastDatasource = HourForecastDataSource(tableView: hourForecastTableView)
        hourForecastDatasource?.delegate = self
        
        self.dayForecastDatasource = DayForecastDataSource(collectionView: dayForcastCollectionView)
        dayForecastDatasource?.delegate = self
        
        self.hourForecastTableView.dataSource    = hourForecastDatasource
        self.hourForecastTableView.delegate      = hourForecastDatasource
        
        self.dayForcastCollectionView.dataSource = dayForecastDatasource
        self.dayForcastCollectionView.delegate   = dayForecastDatasource
        
        self.hourForecastTableView.registerNib(UINib(nibName: hourForecastDatasource!.cellIdentifierRawRepresentation(.HourForecastTableViewCell),
                                                     bundle: nil),
                                               forCellReuseIdentifier: hourForecastDatasource!.cellIdentifierRawRepresentation(.HourForecastTableViewCell))

        self.dayForcastCollectionView.registerNib(UINib(nibName: dayForecastDatasource!.cellIdentifierRawRepresentation(.DayForecastCollectionViewCell),
                                                        bundle: nil),
                                                  forCellWithReuseIdentifier: dayForecastDatasource!.cellIdentifierRawRepresentation(.DayForecastCollectionViewCell))
        self.initLabels()
        self.initApiCall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initApiCall() {
        self.ctm.cacheInitialeData{ (result) in
            switch result {
            case .Success:
                self.initLabels()
            case .Failure:
                break
            }
        }
    }
    
    func initLabels() {
        
        let city = ctm.currentCity
        let imageMapper = Constants.WeatherImageMapper()
        
        self.cityLabel.text       = city?.libel ?? InternationalizedStrings.Loading
        
        self.todayDateLabel.text = Date.DateFormater.fullDateFormat.stringFromDate(NSDate()).capitalizedString
        
        if let temp = city?.temp {
            let t = Int(Double(temp)!.convertKelvinToCelsius()).description + Constants.Celcius
            self.approxTempLabel.text = t ?? EmptyString
        } else {
            self.approxTempLabel.text = EmptyString
        }
        
        if let realTemp = city?.temp {
            let t = Int(Double(realTemp)!.convertKelvinToCelsius()).description + Constants.Celcius
            self.realTempLabel.text  = t ?? EmptyString
        } else {
            self.realTempLabel.text  = EmptyString
        }
        
        self.pressureLabel.text   = city?.pressure ?? EmptyString
        self.humidityLabel.text   = city?.humidity ?? EmptyString
        
        if let imageIcon = city?.weatherIcon {
            self.weatherImage.image = UIImage(named: imageMapper.imageName(weatherIcon: imageIcon))
        } else {
            self.weatherImage.image = nil
        }
    }
}