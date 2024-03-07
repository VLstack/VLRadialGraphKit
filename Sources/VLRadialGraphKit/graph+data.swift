import SwiftUI
import VLShapeKit

@Observable
final class VLRadialGraphData: Identifiable//, Sendable
{
 let id: String = UUID().uuidString

 @ObservationIgnored
 var values: [ Double ]
 @ObservationIgnored
 var startAngle: Double
 @ObservationIgnored
 var endAngle: Double
 @ObservationIgnored
 var maximum: Double?

 var segments: [ VLRadialGraphSegmentData ]
 var points: [ VLArcPoints ]
 
 init(values: [ Double ] = [],
      startAngle: Double = 215,
      endAngle: Double = 90,
      maximum: Double? = nil)
 {
  self.values = values
  self.startAngle = startAngle
  self.endAngle = endAngle
  self.maximum = maximum
  self.segments = []
  self.points = []
 }
  
 private func normalize(angle: Double) -> Double
 {
  var normalized = angle.truncatingRemainder(dividingBy: 360.0)
  if normalized < 0 { normalized += 360.0 }

  return normalized
 }
 
 func set(values: [ Double ],
          update: Bool = true) async
 {
  self.values = values
  if update { await compute() }
 }
 
 func set(startAngle: Double,
          update: Bool = true) async
 {
  self.startAngle = startAngle
  if update { await compute() }
 }

 func set(endAngle: Double,
          update: Bool = true) async
 {
  self.endAngle = endAngle
  if update { await compute() }
 }
 
 func set(maximum: Double?,
          update: Bool = true) async
 {
  self.maximum = maximum
  if update { await compute() }
 }

 func compute() async
 {
  let startAngle: Double = normalize(angle: self.startAngle)
  var endAngle: Double = normalize(angle: self.endAngle)
  
  if endAngle <= startAngle
  {
   endAngle += 360
  }

  let computedMax: Double = values.reduce(0, +)
  let maxValue: Double
  if let maximum
  {
   maxValue = max(maximum, computedMax)
  }
  else
  {
   maxValue = computedMax
  }
    
  let distance: Double = endAngle - startAngle
  var arcStart: Double = 0
  var newSegments: [ VLRadialGraphSegmentData ] = []
  var newPoints: [ VLArcPoints ] = []
  for (index, value) in values.enumerated()
  {
   let percent: Double = value * 100 / maxValue
   let arcEnd: Double = arcStart + distance * percent / 100
   
   newSegments.append(VLRadialGraphSegmentData(index: index,
                                               value: value,
                                               percent: percent,
                                               startAngle: arcStart + startAngle,
                                               endAngle: arcEnd + startAngle))
   newPoints.append(VLArcPoints())

   arcStart = arcEnd
  }
  
  await MainActor.run
  {
   [newSegments, newPoints] in
   segments = newSegments
   points = newPoints
  }
 }
}
