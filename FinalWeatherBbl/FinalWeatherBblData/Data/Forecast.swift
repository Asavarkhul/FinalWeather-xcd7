import Foundation
import CoreData

struct HourForecastViewModel: HourForecastCellProtocol {
    
    var forecast : Forecast?
    
    init(withForecast: Forecast?){
        self.forecast = withForecast
    }
}

struct DayForecastViewModel: DayForecastCellProtocol {
    
    var forecast : Forecast?
    
    init(withForecast: Forecast?){
        self.forecast = withForecast
    }
}

@objc(Forecast)
public class Forecast: _Forecast {

    public class func forecastForForecastUri(forecastUri: String, moc: NSManagedObjectContext!) -> Forecast? {
        var currentForecast :Forecast?
        if let currentForecastArray = Forecast.fetchForecastForForecastUri(moc, uri: forecastUri) as NSArray? {
            if currentForecastArray.count>0 {
                currentForecast = currentForecastArray[0] as? Forecast
            }
        }
        return currentForecast
    }

}