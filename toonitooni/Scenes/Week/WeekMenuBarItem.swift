//
//  WeekMenuBarItem.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import Foundation

enum WeekMenuBarItem: Int {
  case monday
  case tuesday
  case wednesday
  case thursday
  case friday
  case saturday
  case sunday
  case completed
  case total

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
    default: return nil
    }
  }
}
