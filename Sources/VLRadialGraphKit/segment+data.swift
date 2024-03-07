import Foundation
import SwiftUI

@Observable
final class VLRadialGraphSegmentData: Identifiable
{
 let id: String = UUID().uuidString
 
 var index: Int = 0
 var value: Double = 0
 var percent: Double = 0
 var startAngle: Double = 0
 var endAngle: Double = 0
 
 init(index: Int = 0,
      value: Double = 0,
      percent: Double = 0,
      startAngle: Double = 0,
      endAngle: Double = 0)
 {
  self.index = index
  self.value = value
  self.percent = percent
  self.startAngle = startAngle
  self.endAngle = endAngle
 }
}

extension VLRadialGraphSegmentData: Equatable
{
 static func == (lhs: VLRadialGraphSegmentData,
                 rhs: VLRadialGraphSegmentData) -> Bool
 {
  return    lhs.id == rhs.id
         && lhs.index == rhs.index
         && lhs.value == rhs.value
         && lhs.percent == rhs.percent
         && lhs.startAngle == rhs.startAngle
         && lhs.endAngle == rhs.endAngle
 }
}

//extension VLRadialGraphSegmentData: Hashable
//{
// func hash(into hasher: inout Hasher)
// {
//  hasher.combine(index)
//  hasher.combine(value)
//  hasher.combine(percent)
//  hasher.combine(startAngle)
//  hasher.combine(endAngle)
//  hasher.combine(points)
// }
//}
