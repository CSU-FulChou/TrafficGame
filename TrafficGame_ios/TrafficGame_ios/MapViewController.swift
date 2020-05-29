//
//  MapViewController.swift
//  TrafficGame_ios
//
//  Created by 周福 on 2020/2/18.
//  Copyright © 2020 zf.org.csu. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    var matlabResult:MatlabResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.在ViewController实现MKMapViewDelegate协议的委托
        mapView.delegate = self
        
        // 获取用户当前的位置：
        AF.request("http://127.0.0.1:5000/getResult",method: .get).response { response in
            //debugPrint(response)
            //print(response)
            //print(response.data)
            let json = JSON(response.data)
            
            let long = json["data"]["long"].double
            let save_ratefor1 = json["data"]["save_ratefor1"].double
            let save_ratefor0 = json["data"]["save_ratefor1"].double
            
            // 新建两个list
            var pathtList:[CarPath] = [CarPath]()
            var pathdList = [AirplanPath]()
            
            let pathtJson = json["data"]["patht"]
            // 无人机路径：
            let pathdJson = json["data"]["pathd"]
            
            // If json is .Array
            // The `index` is 0..<json.count's string value
            for (index,subJson):(String, JSON) in pathtJson {
                
                let carPath = CarPath(No: Int(index)!, longitude: subJson[1].double!, latitude: subJson[2].double!)
                //print(carPath)
                pathtList.append(carPath)
            }
            
            for (index,subJson):(String, JSON) in pathdJson {
                
                let airplanPath = AirplanPath(No: Int(index)!, longitude: subJson[1].double!, latitude: subJson[2].double!)
                //print(carPath)
                pathdList.append(airplanPath)
            }
            
            self.matlabResult = MatlabResult(longCost: long!, carPath: pathtList, airplanPath: pathdList, save_ratefor0: save_ratefor0!, save_ratefor1: save_ratefor1!)
                     
            // 创建一个 points of pain 结果的点集合：
            var locationCoordinate2Ds = [CLLocationCoordinate2D]()
            
            // 创建一个 注释的集合：
            var pointAnnotations = [MKAnnotation]()
            
            
            if let matlabResult = self.matlabResult{
                    for index in matlabResult.carPath{
                        locationCoordinate2Ds.append(CLLocationCoordinate2D(latitude: index.latitude, longitude: index.longitude))
                        
                        let pointAnnotation = MKPointAnnotation()
                    
                        pointAnnotation.title = "\(index.No)"
                        //print(pointAnnotation.title!)
                        
                        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: index.latitude, longitude: index.longitude)
                        pointAnnotations.append(pointAnnotation)
                    }

            }


//            var coordinateInput:[CLLocationCoordinate2D]=locationCoordinate2D

//                    let point1 = CLLocationCoordinate2DMake(-73.761105, 41.017791);
//                    let point2 = CLLocationCoordinate2DMake(-73.760701, 41.019348);
//                    let point3 = CLLocationCoordinate2DMake(-73.757201, 41.019267);
//                    let point4 = CLLocationCoordinate2DMake(-73.757482, 41.016375);
//                    let point5 = CLLocationCoordinate2DMake(-73.761105, 41.017791);
//
//                    let points: [CLLocationCoordinate2D]
//                    points = [point1, point2, point3, point4, point5]
                     // let geodesic = MKPolyline(coordinates: points, count: 5)
            
            let geodesic = MKGeodesicPolyline(coordinates: locationCoordinate2Ds, count: locationCoordinate2Ds.count)
            self.mapView.addOverlay(geodesic)
            
            // 动画setRegion
                    UIView.animate(withDuration: 1.5, animations: { () -> Void in
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        
                        let region1 = MKCoordinateRegion(center: locationCoordinate2Ds[0], span: span)
                        self.mapView.setRegion(region1, animated: true)
                    })
            
                   // 6.注释显示在地图上
                   self.mapView.showAnnotations(pointAnnotations, animated: true )

        }
        
        
        

       
        
    
        
//        //2.设置位置的纬度和经度
//        let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
//        let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
//
//        // 3.创建包含位置坐标的地标对象
//        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
//        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
//
//        // 4.MKMapitems用于路线的绘制。 此类封装有关地图上特定点的信息
//        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
//        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
//
//        // 5. 注释对象： 添加注释，显示地标的名称
//        let sourceAnnotation = MKPointAnnotation()
//        sourceAnnotation.title = "Times Square"
//
//        // 如果地标对象的坐标存在，就给MK点解释对象 制定坐标
//        if let location = sourcePlacemark.location {
//            sourceAnnotation.coordinate = location.coordinate
//        }
//
//
//        let destinationAnnotation = MKPointAnnotation()
//        destinationAnnotation.title = "Empire State Building"
//
//        if let location = destinationPlacemark.location {
//            destinationAnnotation.coordinate = location.coordinate
//        }
//
//        // 6.注释显示在地图上
//        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )

        
        
//        // 7. MKDirectionsRequest类用于计算路线。
//        let directionRequest = MKDirections.Request()
//        directionRequest.source = sourceMapItem
//        directionRequest.destination = destinationMapItem
//        directionRequest.transportType = .automobile
//
//        // Calculate the direction
//        let directions = MKDirections(request: directionRequest)
//
//        // 8.将使用折线作为地图顶部的叠加视图绘制路线。区域设置为两个位置都可见
//        directions.calculate {
//            (response, error) -> Void in
//
//            guard let response = response else {
//                if let error = error {
//                    print("Error: \(error)")
//                }
//
//                return
//            }
//
//            let route = response.routes[0]
//
//            route.polyline.title = "one"
//            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
//
//            let rect = route.polyline.boundingMapRect
//
//
//            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
//
//
//        }
       
    
        // 第二根线：
        
//        let routeLine = MKPolyline(coordinates: [sourceLocation,destinationLocation], count: 2)
//        routeLine.title = "two"
//        self.mapView.addOverlay(routeLine)
//        指定 地图的中心部位：
//        let rect1 = routeLine.boundingMapRect

//        self.mapView.setRegion(MKCoordinateRegion(rect1), animated: true)
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapViewController:MKMapViewDelegate{
    
    // 画线的函数：
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
//        let renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.strokeColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
//        renderer.lineWidth = 10.0
//        return renderer

        //画出两条线：
        let routeLineView = MKPolylineRenderer(overlay: overlay)
        
          routeLineView.lineWidth = 4.0
//        routeLineView.strokeColor = UIColor.red
        
        if overlay is MKPolyline{

            if overlay.title == "one"{
                routeLineView.strokeColor = UIColor.red
            }else{
                routeLineView.strokeColor = UIColor.green
            }
        }
        
            return routeLineView
    }
    
    
    // 自定义标记的样式： 系统的点是一个大头针：
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }else {
//            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
//            annotationView.canShowCallout = true
//
//            //annotationView.image = UIImage(systemName: "hare.fill")
//            return annotationView
//        }
//    }
    
    
    
}
