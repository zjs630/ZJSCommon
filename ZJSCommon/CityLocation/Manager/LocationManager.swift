//
//  LocationManager.swift
//  tsbbtClient
//
//  Created by zjs on 2020/7/24.
//  Copyright © 2020 tawy. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol LocationManagerDelegate: NSObjectProtocol {
    /// 用户选择或定位的城市
    func userSelectedOrLocatedPosition(city: String)
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    private var locationManager = CLLocationManager()
    private var latitude: Float?
    private var longitude: Float?
    /// 城市 经纬度定位的位置
    private var locality: String?
    /// 区/县 经纬度定位的位置 已废弃
    //private var subLocality: String?
    
    var success:((_ lat: Float, _ lon: Float, _ locality: String?) -> Void)?
    var faild:(() -> Void)?

    private override init() {
        super.init()
        if let cacheSelectedCity = UserSelectedLocationCacheManager.getCityInfo() {
            selectedLocation = cacheSelectedCity
        }
        locationManager.delegate = self
    }
    // MARK: - 外部调用接口
    /// 用户选择的区县及city_code
    var selectedLocation:(city: String, code: String)? {
        didSet {
            if let selectedCity = selectedLocation {
                delegate?.userSelectedOrLocatedPosition(city: selectedCity.city)
            }
            // 本地缓存选择的城市信息
            UserSelectedLocationCacheManager.cacheCity(info: selectedLocation)
        }
    }
    
    /// 选择城市和定位城市，是否为外地城市，“0”：否，“1”：是 //返回1，参数的经纬度失效
    var isOtherCity: String {
        // 没有选择城市，没有定位权限，默认选择高密市
        // 1. 无定位城市，认为是一个城市，此时otherCounty也可以不传。
        if !LocationManager.hasLocationAuthorization() {
            return "0"
        }
        // 2.只有定位，用户没有选择城市
        guard let selectedCode = selectedLocation?.code else {
            return "0"
        }
        // 3.有选择城市，有定位（定为的是城市级别，不是区县）
        if let location2 = locality {
            // 查询定位城市的city_code,城市名正常情况下，不存在重复的情况。
            let locationCode = MySQLLiteManager.shared.getCityCode(with: location2)
            if locationCode == "" { //找不到定位城市的code
                return "1"
            }
            // 判断选择城市的city_code,province_code，是否和定位的城市码对应
            if selectedCode == locationCode {
                return "0"
            }
            //用户可能选择的是某个区县，判断区县的province码是否相同
            let provinceCode = MySQLLiteManager.shared.getProvinceCode(with: selectedCode)
            let pc = provinceCode.substring(to: 6)
            let lc = locationCode.substring(to: 6)
            if lc == pc {
                return "0"
            }
        }
        return "1"
    }
    /// 返回经纬度，供外部接口获取
    func loaction() ->(Float,Float)? {
        guard let lati = latitude, let longti = longitude else {
            return nil
        }
        return (lati,longti)
    }
    
    /// 获取城市信息
    /// - Returns: 返回（选择的城市，定位的城市）
    func getCityInfo() -> (selectedCity: String, locationCity: String?) {
        return (currentLookingCity(),locality)
    }
    
    /// 用户是否开启地理位置授权
    static func hasLocationAuthorization() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted {
            return false
        }
        return true
    }
    
    /// 开始定位
    func startLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if LocationManager.hasLocationAuthorization() == false{
            let ac = UIAlertController(title: "温馨提示", message: "建议您开启定位权限，就能看到更多周边好店和惊喜优惠", preferredStyle: .alert)
            let save = UIAlertAction(title: "暂不", style: .default) { _ in
            }
            let cancel = UIAlertAction(title: "去开启", style: .default) { _ in
                UIApplication.ts_openSystemSettingPage()
            }
            ac.addAction(save)
            ac.addAction(cancel)
            UIApplication.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
        }
    }

    // MARK: -  私有方法
    /// 获取正在查看的城市,通过getCityInfo 获取城市信息
    private func currentLookingCity() -> String {
        if let selected = selectedLocation {
            return selected.city //用户选择的城市
        }
        if let locality = locality {
            let countyCode = MySQLLiteManager.shared.getCityCode(with: locality)
            if countyCode.count > 0 {
                selectedLocation = (locality,countyCode) //依据定位获取contyCode
            }
            return locality // 定位获取的城市
        }
        selectedLocation = ("高密市","370785000000") //设置默认选择城市
        UserSelectedLocationCacheManager.cacheCity(info: selectedLocation)
        return "高密市" //获取不到定位时默认定位：山东省潍坊市高密市
    }

}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 停止定位服务
        locationManager.stopUpdatingLocation()
        
        let location = locations.last! //delegate 传回定位，获取最后一个
        if location.horizontalAccuracy > 0 {
            latitude = Float(location.coordinate.latitude)
            longitude = Float(location.coordinate.longitude)
            
            //print("lat = \(latitude!),  lon = \(longitude!)")
            
            //反地理编码：将经纬度转换成城市，地区，街道
            CLGeocoder().reverseGeocodeLocation(location) { (placemakes , error) -> Void in
                guard let placemark = placemakes?.first else {
                    self.faild?()
                    self.delegate?.userSelectedOrLocatedPosition(city: self.currentLookingCity())
                    return
                }
                self.locality = placemark.locality
                //self.subLocality = placemark.subLocality

                //print("locality = \(placemark.locality ?? ""), sublocality = \(placemark.subLocality ?? ""), subthoroughfare = \(placemark.subThoroughfare ?? "")")  //详细街道
                self.success?(self.latitude!,self.longitude!,placemark.locality)
                self.delegate?.userSelectedOrLocatedPosition(city: self.currentLookingCity())
            }
        }
        
    }
    
    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        //print("定位出错拉！！\(error)")
        faild?()
        delegate?.userSelectedOrLocatedPosition(city: currentLookingCity())
    }
}
// MARK: - 经纬度距离计算
extension LocationManager {

    //根据角度计算弧度
    func radian(d:Double) -> Double {
         return d * Double.pi/180.0
    }
    //根据弧度计算角度
    func angle(r:Double) -> Double {
         return r * 180/Double.pi
    }
    
    func getDistance(lat1:Double,lng1:Double) -> Double {
            let EARTH_RADIUS:Double = 6378137.0
            
            let radLat1:Double = self.radian(d: lat1)
        let radLat2:Double = self.radian(d: Double(self.latitude ?? 0.0))
            
            let radLng1:Double = self.radian(d: lng1)
        let radLng2:Double = self.radian(d: Double(self.longitude ?? 0.0))
     
            let a:Double = radLat1 - radLat2
            let b:Double = radLng1 - radLng2
            
            var s:Double = 2 * asin(sqrt(pow(sin(a/2), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b/2), 2)))
            s = s * EARTH_RADIUS
            return s
    }
}

// MARK: - 选择城市缓存
/// 缓存用户选择城市的记录，避免下次启动app缓存消失
class UserSelectedLocationCacheManager {
    /// 获取本地存储的用户选择的城市信息
    static func getCityInfo() -> (city: String, code: String)? {
        let cityStr = UserDefaults.standard.value(forKey: "userSelectedLoaction") as? String
        if let cityInfo = cityStr, cityInfo.count > 0 {
            let array = cityInfo.components(separatedBy: ",")
            if array.count == 2 {
                return (array[0],array[1])
            }
        }
        return nil
    }
    /// 存储选择的城市及citycode
    static func cacheCity(info: (city: String, code: String)?) {
        if let info = info {
            UserDefaults.standard.set("\(info.city),\(info.code)", forKey: "userSelectedLoaction")
        } else {
            UserDefaults.standard.set("", forKey: "userSelectedLoaction")
        }
        UserDefaults.standard.synchronize()
    }
}
