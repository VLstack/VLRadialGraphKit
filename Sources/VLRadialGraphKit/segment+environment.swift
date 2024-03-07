import SwiftUI

struct VLRadialGraphSegmentThicknessKey: EnvironmentKey
{
 static let defaultValue: Double = 25
}

struct VLRadialGraphSegmentFillKey: EnvironmentKey
{
 static let defaultValue: Color = .secondary
}

struct VLRadialGraphSegmentStrokeWidthKey: EnvironmentKey
{
 static let defaultValue: Double = 0
}

struct VLRadialGraphSegmentStrokeKey: EnvironmentKey
{
 static let defaultValue: Color = .clear
}

extension EnvironmentValues
{
 public var radialGraphSegmentThickness: Double
 {
  get { self[VLRadialGraphSegmentThicknessKey.self] }
  set { self[VLRadialGraphSegmentThicknessKey.self] = newValue }
 }
 
 public var radialGraphSegmentFill: Color
 {
  get { self[VLRadialGraphSegmentFillKey.self] }
  set { self[VLRadialGraphSegmentFillKey.self] = newValue }
 }
 
 public var radialGraphSegmentStrokeWidth: Double
 {
  get { self[VLRadialGraphSegmentStrokeWidthKey.self] }
  set { self[VLRadialGraphSegmentStrokeWidthKey.self] = newValue }
 }
 
 public var radialGraphSegmentStroke: Color
 {
  get { self[VLRadialGraphSegmentStrokeKey.self] }
  set { self[VLRadialGraphSegmentStrokeKey.self] = newValue }
 }
}

extension View
{
 func radialGraphSegment(fill color: Color) -> some View
 {
  self.environment(\.radialGraphSegmentFill, color)
 }

 func radialGraphSegment(thickness: Double) -> some View
 {
  self.environment(\.radialGraphSegmentThickness, thickness)
 }

 func radialGraphSegment(fill color: Color,
                         thickness: Double) -> some View
 {
  self.radialGraphSegment(fill: color)
      .radialGraphSegment(thickness: thickness)
 }
 
 func radialGraphSegment(stroke color: Color) -> some View
 {
  self.environment(\.radialGraphSegmentStroke, color)
 }
 
 func radialGraphSegment(strokeWidth: Double) -> some View
 {
  self.environment(\.radialGraphSegmentStrokeWidth, strokeWidth)
 }
 
 func radialGraphSegment(stroke color: Color,
                         strokeWidth: Double) -> some View
 {
  self.radialGraphSegment(stroke: color)
      .radialGraphSegment(strokeWidth: strokeWidth)
 }
}
