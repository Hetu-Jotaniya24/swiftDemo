//
//  MonthPickerView.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 11/11/21.
//
import Foundation
import UIKit

class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var months: [Int]!
    var years: [Int]!
    var allMonths: [Int]!
    var currentMonth: String = ""
    var currentYear: String = ""

    
    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            let index = months.firstIndex(of: month)
            selectRow(index ?? 0, inComponent: 0, animated: false)
        }
    }
    
    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            selectRow(years.firstIndex(of: year) ?? 0, inComponent: 1, animated: true)
        }
    }
    
    var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() {
        // population years
        var years: [Int] = []
        if years.count == 0 {
            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
            for _ in 1...15 {
                years.append(year)
                year += 1
            }
        }
        self.years = years
        
        // population months with localized names
        var months: [Int] = []
        var month = 1
        for _ in 1...12 {
            
//            months.append(DateFormatter().monthSymbols[month].capitalized) // for showing string
            months.append(month)
            month += 1
        }
        self.months = months
        self.allMonths = months
        
        self.delegate = self
        self.dataSource = self
        
//        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
//        self.selectRow(months.index(of: currentMonth) ?? 0, inComponent: 0, animated: false)
        self.findCurrentMonthAndYear()
        self.updateMonthsArrayIfCurrentYearIsSelected(row: 0)
        let index = self.months.firstIndex(of: month)
        selectRow(index ?? 0, inComponent: 0, animated: false)

    }
    
    // Mark: UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(months[row])"
        case 1:
            return "\(years[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Updating months array, if current running year is selected
        if component == 1 {
            self.updateMonthsArrayIfCurrentYearIsSelected(row:row)
        }
        
        //Selection
        //Month component selection
        if component == 0 {
             print("month component has been changed")
             let monthRow = self.selectedRow(inComponent: 0)
             month = self.months[monthRow]
             print("selected month \(month)")
        }else {
            //Component 1
            //Year is changing
            print("year component has changed")
            year = years[self.selectedRow(inComponent: 1)]
            //If current year is changed, months array is updated
            let selectedMonthRow = self.selectedRow(inComponent: 0)
            if selectedMonthRow <= self.months.count - 1 {
                month = self.months[selectedMonthRow]
                print("Normal selected month \(month)")
            }else{
                month = self.months.last ?? 0
                print("Month boundary condition, selected month \(month)")
            }
        }

        if let block = onDateSelected {
            block(month, year)
        }
    }
    
    func updateMonthsArrayIfCurrentYearIsSelected(row: Int) {
           if years[row] == Int(currentYear) {
              //Current year
                let currentMonthInt = Int(currentMonth) ?? 0
                months.removeAll(where:{
                  return Int($0) < currentMonthInt
                })
                self.reloadComponent(0)
            }
            else {
                months = allMonths
                self.reloadComponent(0)
            }
     }
    
    func findCurrentMonthAndYear() {
         let now = NSDate()
         let monthFormatter = DateFormatter()
         monthFormatter.dateFormat = "MM"
         let curMonth = monthFormatter.string(from: now as Date)
         print("currentMonth : \(curMonth)")
         currentMonth = curMonth
         let yearFormatter = DateFormatter()
         yearFormatter.dateFormat = "yyyy"
         let curYear = yearFormatter.string(from: now as Date)
         print("currentYear : \(curYear)")
         currentYear = curYear
     }
    
}
