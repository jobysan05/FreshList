//
//  BarChart.swift
//  FreshList
//
//  Created by Team7 on 12/2/18.
//  Copyright © 2018 Joby Santhosh. All rights reserved.
//

import UIKit
import Charts

class BarChart: UIView {
    
    let barChartView = BarChartView()
    var dataEntry: [BarChartDataEntry] = []
    
    var workoutDuration = [String]()
    var beatsPerMinute = [String]()
    
    var delegate: GetChartData! {
        didSet {
            populateData()
            barChartSetup()
        }
    }
    
    func populateData() {
        workoutDuration = delegate.workoutDuration
        beatsPerMinute = delegate.beatsPerMinute
    }
    
    func barChartSetup() {
        self.backgroundColor = UIColor.white
        self.addSubview(barChartView)
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        barChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        barChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        barChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        setBarChart(dataPoints: workoutDuration, values: beatsPerMinute)
    }
    
    func setBarChart(dataPoints: [String], values: [String]) {
        
        barChartView.noDataTextColor = UIColor.white
        barChartView.noDataText = "No Data for the chart."
        barChartView.backgroundColor = UIColor.white
        
        for i in 0..<dataPoints.count {
            let dataPoint = BarChartDataEntry(x: Double(i), y: Double(values[i])!)
            dataEntry.append(dataPoint)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntry, label: "BPM")
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(false)
        chartDataSet.colors = [UIColor.blue]
        
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)
        let xaxis:XAxis = XAxis()
        xaxis.valueFormatter = formatter
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter
        barChartView.chartDescription?.enabled = false
        barChartView.legend.enabled = true
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = true
        barChartView.data = chartData
    }
    
}
