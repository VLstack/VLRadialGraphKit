import SwiftUI
import VLShapeKit

public struct VLRadialGraphSegment: View
{
 @Environment(\.radialGraphSegmentThickness) private var thickness
 @Environment(\.radialGraphSegmentFill) private var fill
 @Environment(\.radialGraphSegmentStroke) private var stroke
 @Environment(\.radialGraphSegmentStrokeWidth) private var strokeWidth
 
 var startAngle: Double
 var endAngle: Double
 @Binding var data: VLRadialGraphSegmentData
 @Binding var points: VLArcPoints

 init(startAngle: Double,
      endAngle: Double,
      data: Binding<VLRadialGraphSegmentData>? = nil,
      points: Binding<VLArcPoints>? = nil)
 {
  self.startAngle = startAngle
  self.endAngle = endAngle
  self._data = data ?? Binding<VLRadialGraphSegmentData>(get: { .init() },
                                                         set: { _ in })
  self._points = points ?? Binding<VLArcPoints>(get: { .init() },
                                                set: { _ in })
 }

 public var body: some View
 {
  if fill != .clear
  {
   filled
    .overlay { stroked }
  }
  else
  {
   stroked
  }
 }
}

// MARK: - Components
extension VLRadialGraphSegment
{
 private var arc: some Shape
 {
  VLArc(startAngle: startAngle,
        endAngle: endAngle,
        thickness: thickness,
        strokeWidth: strokeWidth,
        points: points)
 }

 // @ViewBuilder
 private var filled: some View
 {
  arc.fill(fill)
 }
 
 @ViewBuilder
 private var stroked: some View
 {
  if strokeWidth > 0
  {
   arc
   .stroke(stroke, lineWidth: strokeWidth)
  }
 }
}

// MARK: - Computed properties
extension VLRadialGraphSegment
{
}

// MARK: - Functions
extension VLRadialGraphSegment
{
}

// MARK: - Previews
#if targetEnvironment(simulator)
fileprivate struct VLRadialGraphSegmentWrapper: View
{
 @State private var startAngle: Double = 0
 @State private var endAngle: Double = 90
 @State private var thickness: Double = 20
 @State private var data: VLRadialGraphSegmentData = .init()
 @State private var points: VLArcPoints = .init()

 var body: some View
 {
  VStack
  {
   LabeledContent("Start")
   {
    Slider(value: $startAngle, in:0...90, step: 1)
   }
   LabeledContent("End")
   {
    Slider(value: $endAngle, in:0...90, step: 1)
   }
   LabeledContent("Thickness")
   {
    Slider(value: $thickness, in:1...100, step: 1)
   }
   
   Grid()
   {
    GridRow
    {
     Text(verbatim: "center")
     Text(verbatim: "\(String(format: "%.2f", points.center.x))")
     Text(verbatim: "\(String(format: "%.2f", points.center.y))")
    }
    GridRow
    {
     Text(verbatim: "outerEnd")
     Text(verbatim: "\(String(format: "%.2f", points.outerEnd.x))")
     Text(verbatim: "\(String(format: "%.2f", points.outerEnd.y))")
    }
    GridRow
    {
     Text(verbatim: "outerStart")
     Text(verbatim: "\(String(format: "%.2f", points.outerStart.x))")
     Text(verbatim: "\(String(format: "%.2f", points.outerStart.y))")
    }
    GridRow
    {
     Text(verbatim: "innerEnd")
     Text(verbatim: "\(String(format: "%.2f", points.innerEnd.x))")
     Text(verbatim: "\(String(format: "%.2f", points.innerEnd.y))")
    }
    GridRow
    {
     Text(verbatim: "innerStart")
     Text(verbatim: "\(String(format: "%.2f", points.innerStart.x))")
     Text(verbatim: "\(String(format: "%.2f", points.innerStart.y))")
    }
   }
   
   ZStack
   {
    VLRadialGraphSegment(startAngle: startAngle,
                         endAngle: endAngle,
                         data: $data,
                         points: $points)
    .radialGraphSegment(fill: .red, thickness: thickness)
    .radialGraphSegment(stroke: .purple, strokeWidth: 2)
    
    VLRadialGraphSegment(startAngle: 90,
                         endAngle: 180)
    .radialGraphSegment(fill: .green, thickness: 40)
    .radialGraphSegment(stroke: .red, strokeWidth: 4)
    
    VLRadialGraphSegment(startAngle: 180,
                         endAngle: 270)
    .radialGraphSegment(fill: .blue, thickness: 60)
    .radialGraphSegment(stroke: .green, strokeWidth: 6)
    
    VLRadialGraphSegment(startAngle: 270,
                         endAngle: 0)
    .radialGraphSegment(fill: .purple, thickness: 80)
    .radialGraphSegment(stroke: .blue, strokeWidth: 8)
   }
  }
  .padding()
 }
}

#Preview("No sample")
{
 VLRadialGraphSegmentWrapper()
}
#endif
