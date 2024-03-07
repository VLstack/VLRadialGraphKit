import SwiftUI

struct VLRadialGraphColorsKey: EnvironmentKey
{
 static let defaultValue: [ Color ] = [ .red, .orange, .yellow, .green, .blue, .indigo, .purple ]
}

struct VLRadialGraphThicknessKey: EnvironmentKey
{
 static let defaultValue: Double = 35
}

struct VLRadialGraphStrokeKey: EnvironmentKey
{
 static let defaultValue: Color = .black
}

struct VLRadialGraphStrokeWidthKey: EnvironmentKey
{
 static let defaultValue: Double = 1
}

extension EnvironmentValues
{
 public var radialGraphColors: [ Color ]
 {
  get { self[VLRadialGraphColorsKey.self] }
  set { self[VLRadialGraphColorsKey.self] = newValue }
 }
 
 public var radialGraphThickness: Double
 {
  get { self[VLRadialGraphThicknessKey.self] }
  set { self[VLRadialGraphThicknessKey.self] = newValue }
 }
 
 public var radialGraphStroke: Color
 {
  get { self[VLRadialGraphStrokeKey.self] }
  set { self[VLRadialGraphStrokeKey.self] = newValue }
 }
 
 public var radialGraphStrokeWidth: Double
 {
  get { self[VLRadialGraphStrokeWidthKey.self] }
  set { self[VLRadialGraphStrokeWidthKey.self] = newValue }
 }
}

extension View
{
 public func radialGraph(colors: [ Color ]) -> some View
 {
  self.environment(\.radialGraphColors, colors)
 }
 
 public func radialGraph(thickness: Double) -> some View
 {
  self.environment(\.radialGraphThickness, thickness)
 }
 
 public func radialGraph(stroke color: Color) -> some View
 {
  self.environment(\.radialGraphStroke, color)
 }
 
 public func radialGraph(strokeWidth: Double) -> some View
 {
  self.environment(\.radialGraphStrokeWidth, strokeWidth)
 }

 public func radialGraph(stroke color: Color,
                         strokeWidth: Double) -> some View
 {
  self.radialGraph(stroke: color)
      .radialGraph(strokeWidth: strokeWidth)
 }
}
