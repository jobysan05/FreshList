//
//  ChartViewController.swift
//  FreshList
//
//  Created by Team7 on 12/2/18.
//  Copyright © 2018 Joby Santhosh. All rights reserved.
//

import UIKit
import Foundation
import Charts

//protocol GetChartData {
//    func getChartData(with dataPoints: [String], values: [String])
//    var workoutDuration: [String] {get set}
//    var beatsPerMinute: [String] {get set}
//}

class ChartViewController: UIViewController{
}/*, GetChartData {

//    var workoutDuration = [String]()
//    var beatsPerMinute = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        populateChartData()
//        
//        barChart()

        // Do any additional setup after loading the view.
    }
    
    func populateChartData(){
        workoutDuration = ["1","2","3","4","5","6","7","8","9","10"]
        beatsPerMinute = ["76","150","160","180","195","195","180","164","136","112"]
        self.getChartData(with: workoutDuration, values: beatsPerMinute)
    }
    
    func barChart(){
        let barChart = BarChart(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width,
                                              height: self.view.frame.height))
        barChart.delegate = self
        self.view.addSubview(barChart)
    }
    
    func getChartData(with dataPoints: [String], values: [String]){
        self.workoutDuration = dataPoints
        self.beatsPerMinute = values
    }
}

public class ChartFormatter: NSObject, IAxisValueFormatter {
    
    var workoutDuration = [String]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String{
        return workoutDuration[Int(value)]
    }
    
    public func setValues(values: [String]){
        self.workoutDuration = values
    }
}
*/
