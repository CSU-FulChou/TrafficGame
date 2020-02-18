//
//  MapViewController.swift
//  TrafficGame_ios
//
//  Created by 周福 on 2020/2/18.
//  Copyright © 2020 zf.org.csu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.在ViewController实现MKMapViewDelegate协议的委托
        mapView.delegate = self
        // 获取用户当前的位置：
        
        
        //2.设置位置的纬度和经度
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
        
        // 3.创建包含位置坐标的地标对象
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.MKMapitems用于路线的绘制。 此类封装有关地图上特定点的信息
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5. 添加注释，显示地标的名称
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Times Square"
        // 如果地标对象的坐标存在，就给MK点解释对象指点坐标
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Empire State Building"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.注释显示在地图上
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7. MKDirectionsRequest类用于计算路线。
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.将使用折线作为地图顶部的叠加视图绘制路线。区域设置为两个位置都可见
        directions.calculate {
            (response, error) -> Void in

            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }

                return
            }

            let route = response.routes[0]
            
            route.polyline.title = "one"
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect

            
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)


        }
        
        let routeLine = MKPolyline(coordinates: [sourceLocation,destinationLocation], count: 2)
        routeLine.title = "two"
        self.mapView.addOverlay(routeLine)
        let rect1 = routeLine.boundingMapRect

        self.mapView.setRegion(MKCoordinateRegion(rect1), animated: true)
        
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
            }else
                if overlay.title == "two" {
                routeLineView.strokeColor = UIColor.green
            }
        }
        
            return routeLineView
    }
    // 自定义标记的样式：
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image = UIImage(systemName: "hare.fill")
//            annotationView.annotation.
            return annotationView
        }
    }
    
}
