//
//  StatsViewController.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

// TODO: Add protocol/delegate functionality for firebase auth list
// TODO: Add firebase DB access functionalities
// TODO: Add functionalities for recording stats from DB

import UIKit
import Charts

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [String])
    var workoutDuration: [String] {get set}
    var beatsPerMinute: [String] {get set}
}

class StatsViewController: UIViewController, GetChartData {
    
    var workoutDuration = [String]()
    var beatsPerMinute = [String]()
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        setupView()
        setupNavigationBar(title: "Statistics")
        
        populateChartData()
        
        barChart()
        
    }
    private func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    private func setupNavigationBar(title: String) {
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        // Call function to add buttons to navigation bar
        setupNavigationBarItems()
    }
    
    // Function called to set up buttons in navigation bar
    private func setupNavigationBarItems() {
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
