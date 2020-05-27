//
//  MatlabResult.swift
//  TrafficGame_ios
//
//  Created by 周福 on 2020/5/12.
//  Copyright © 2020 zf.org.csu. All rights reserved.
//

import Foundation

class MatlabResult{
    
    var longCost:Double
    var carPath:[CarPath]
    var airplanPath:[AirplanPath]
    ///车机协同相比货车单独配送的成本节省率
    var save_ratefor0:Double
    /// 车机协同相比初始解的成本节约率
    var save_ratefor1:Double
    
    init(longCost:Double,carPath:[CarPath],airplanPath:[AirplanPath],save_ratefor0:Double,save_ratefor1:Double) {
        self.longCost = longCost
        self.carPath = carPath
        self.airplanPath = airplanPath
        self.save_ratefor0 = save_ratefor0
        self.save_ratefor1 = save_ratefor1
    }
    
    
}
