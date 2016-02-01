//
//  ViewController.swift
//  reveiller
//
//  Created by cwood on 1/9/16.
//  Copyright © 2016 caw. All rights reserved.
//

import UIKit
import Charts

class MainViewController: UIViewController {
    @IBOutlet weak var graphView: BarChartView!

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var historyGraph: LineChartView!
    @IBOutlet weak var decayLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var activateButton: UIButton!
    
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var decayTimeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var alarm: RealAlarm?
    var targetDate: NSDate = NSDate();
    
    func timerExpired() {
        if alarm!.alarmExpired() {
            print("Snooze!")
        } else {
            print("Done!")
            backgroundView.backgroundColor = UIColor.blackColor()
        }
    }
    
    func setDecayChart(dataPoints: [String], values: [Double]) {
        graphView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries)
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        
        graphView.data = chartData
        graphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        graphView.leftAxis.enabled = false
        graphView.rightAxis.enabled = false
        graphView.legend.enabled = false
        graphView.descriptionText = ""
    }
    
    func setHistoryChart(months: [String], values: [Double]) {
            // 1 - creating an array of data entries
            var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
            for var i = 0; i < months.count; i++ {
                yVals1.append(ChartDataEntry(value: values[i], xIndex: i))
            }
            
            // 2 - create a data set with our array
            let set1: LineChartDataSet = LineChartDataSet(yVals: yVals1, label: "First Set")
            set1.axisDependency = .Left // Line will correlate with left axis values
            set1.setColor(UIColor.redColor().colorWithAlphaComponent(0.5)) // our line's opacity is 50%
            set1.setCircleColor(UIColor.redColor()) // our circle will be dark red
            set1.lineWidth = 2.0
            set1.circleRadius = 6.0 // the radius of the node circle
            set1.fillAlpha = 65 / 255.0
            set1.fillColor = UIColor.redColor()
            set1.highlightColor = UIColor.whiteColor()
            set1.drawCircleHoleEnabled = true
            
            //3 - create an array to store our LineChartDataSets
            var dataSets : [LineChartDataSet] = [LineChartDataSet]()
            dataSets.append(set1)
            
            //4 - pass our months in for our x-axis label value along with our dataSets
            let data: LineChartData = LineChartData(xVals: months, dataSets: dataSets)
            data.setValueTextColor(UIColor.whiteColor())
            
            //5 - finally set our data
            historyGraph.data = data
    }
    
    func addAlarmGraph() {
        graphView.noDataText = "DUUUUUDE"
        
        let timeRange = alarm!.getAlarmRange()
        var times: [String] = []
        var values: [Double] = []
        for (t, i) in timeRange {
            times += [t.getTimeString()]
            values += [i]
        }
        setDecayChart(times, values: values)
        
        let months1 = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
        let dollars1 = [1453.0,2352,5431,1442,5451,6486,1173,5678,9234,1345,9411,2212]
        setHistoryChart(months1, values: dollars1)
    }
    
    func initUI() {
        let targetDate = alarm!.time!.getDateTime()
        let targetTime = alarm!.time!.getTimeString()
        print("Target alarm time: ", targetDate, targetTime)
        targetTimeLabel.text = targetTime
        
        let decay = String(alarm!.snoozeStart!);
        decayLabel.text = decay
        
        let start = String(alarm!.snoozeDecay!)
        startLabel.text = start
        
        addAlarmGraph()
    }
    
    func setViewAlarm(the_alarm: RealAlarm) {
        self.alarm = the_alarm
        initUI()
    }
    
    @IBAction func onActivatePress(sender: UIButton) {
        let alarmTime = alarm!.time!
    
        alarmTime.addSeconds(10)
        
        print("Setting the alarm at", alarm!.time?.getTimeString())
        alarm!.setAlarmDate(alarmTime.getDateTime())
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowActiveAlarm" {
            if let activeAlarmViewController = segue.destinationViewController as? ActiveAlarmViewController {
                activeAlarmViewController.alarm = alarm
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

