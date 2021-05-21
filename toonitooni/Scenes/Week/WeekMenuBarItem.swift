//
//  WeekMenuBarItem.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import Foundation

enum WeekMenuBarItem: Int, CaseIterable {
  case monday
  case tuesday
  case wednesday
  case thursday
  case friday
  case saturday
  case sunday
  case completed

  static let total = 8

  var title: String? {
    switch self {
    case .monday: return "월"
    case .tuesday: return "화"
    case .wednesday: return "수"
    case .thursday: return "목"
    case .friday: return "금"
    case .saturday: return "토"
    case .sunday: return "일"
    case .completed: return "완결"
    }
  }

  // 현재 요일
  static var currentWeekDay: Int {
    let day = Calendar.current.component(.weekday, from: Date())
    switch day {
    case 1: return WeekMenuBarItem(rawValue: 6)?.rawValue ?? 0
    case 2: return WeekMenuBarItem(rawValue: 0)?.rawValue ?? 0
    case 3: return WeekMenuBarItem(rawValue: 1)?.rawValue ?? 0
    case 4: return WeekMenuBarItem(rawValue: 2)?.rawValue ?? 0
    case 5: return WeekMenuBarItem(rawValue: 3)?.rawValue ?? 0
    case 6: return WeekMenuBarItem(rawValue: 4)?.rawValue ?? 0
    case 7: return WeekMenuBarItem(rawValue: 5)?.rawValue ?? 0
    default: return 0
    }
  }

  static func transformShort(by index: Int) -> String {
    let item = WeekMenuBarItem(rawValue: index)
    switch item {
    case .monday: return "mon"
    case .tuesday: return "tue"
    case .wednesday: return "wed"
    case .thursday: return "thu"
    case .friday: return "fri"
    case .saturday: return "sat"
    case .sunday: return "sun"
    case .completed: return ""
    default: return ""
    }
  }
}
