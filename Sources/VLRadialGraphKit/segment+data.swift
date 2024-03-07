import Foundation
import SwiftUI

@Observable
public final class VLRadialGraphSegmentData: Identifiable//, Sendable
{
 public let id: String = UUID().uuidString
 
 public var index: Int = 0
 public var value: Double = 0
 public var percent: Double = 0
 public var startAngle: Double = 0
 public var endAngle: Double = 0
 
 public init(index: Int = 0,
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
 public static func == (lhs: VLRadialGraphSegmentData,
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
