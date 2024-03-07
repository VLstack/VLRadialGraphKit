import SwiftUI
import Combine
import VLShapeKit

public struct VLRadialGraph: View
{
 @Environment(\.radialGraphColors) private var colors
 @Environment(\.radialGraphThickness) private var thickness
 @Environment(\.radialGraphStroke) private var stroke
 @Environment(\.radialGraphStrokeWidth) private var strokeWidth

 var data: VLRadialGraphData
 
 public init(data: VLRadialGraphData)
 {
  self.data = data
 }
 
 public init(values: [ Double ],
             startAngle: Double = 215,
             endAngle: Double = 90,
             maximum: Double? = nil)
 {
  self.data = VLRadialGraphData(values: values,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                maximum: maximum)
 }
 
 public var body: some View
 {
  @Bindable var data = data
  
  ZStack
  {
   ForEach(data.segments.indices, id: \.self)
   {
    index in
    let color = colors[index % colors.count]
    let segment = $data.segments[index]
    let point = $data.points[index]
    VLRadialGraphSegment(startAngle: segment.startAngle.wrappedValue,
                         endAngle: segment.endAngle.wrappedValue,
                         data: segment,
                         points: point)
    .radialGraphSegment(fill: color, thickness: thickness)
    .radialGraphSegment(stroke: stroke, strokeWidth: strokeWidth)
   }
  }
  .task { await data.compute() }
 }
}

#if targetEnvironment(simulator)
struct VLRadialGraphWrapper: View
{
 @State private var values: [ Double ] = [ 50, 100, 200 ]
 @State private var text: String = "50 100 200"
 @State private var thickness: CGFloat = 50
 @State private var startAngle: Double = 215
 @State private var endAngle: Double = 90
 @State private var stroke: Color = .black
 @State private var strokeWidth: Double = 1
 @State private var segments: [ VLRadialGraphSegmentData ] = []
 @State private var points: [ VLArcPoints ] = []
 
 @State private var data = VLRadialGraphData(values: [ 50, 100, 200 ])
 @State private var data2 = VLRadialGraphData(values: [ 50, 100, 200 ], maximum: 500)
 @State private var data3 = VLRadialGraphData(values: [ 50, 100, 200 ])

 var body: some View
 {
  VStack
  {
   Form
   {
    Grid()
    {
     GridRow
     {
      TextField("", text: $text)
       .textFieldStyle(.roundedBorder)
       .gridCellColumns(3)
      
      Button
      {
       Task
       {
        let arr: [ Double ] = text.split(separator: " ").compactMap { Double($0) }
        
        if !arr.isEmpty
        {
         await data.set(values: arr)
         await data2.set(values: arr)
         await data3.set(values: arr)
        }
       }
      }
     label: { Text(verbatim: "apply") }
       .disabled(text.isEmpty)
     }

     GridRow
     {
      Text(verbatim: "Start angle")
       .fixedSize(horizontal: true, vertical: false)

      Text(verbatim: "\(Int(startAngle))")

      Slider(value: $startAngle, in:0...360, step: 1)
       .gridCellColumns(2)
     }

     GridRow
     {
      Text(verbatim: "End angle")
       .fixedSize(horizontal: true, vertical: false)

      Text(verbatim: "\(Int(endAngle))")

      Slider(value: $endAngle, in:0...360, step: 1)
       .gridCellColumns(2)
     }

     GridRow
     {
      Text(verbatim: "Thickness")

      Text(verbatim: String(format: "%.1f", thickness))

      Slider(value: $thickness, in:1...60, step: 0.1)
       .gridCellColumns(2)
     }

     GridRow
     {
      Text(verbatim: "Stroke")

      ColorPicker("", selection: $stroke)
       .frame(alignment: .leading)
       .frame(maxWidth: 10)
       .padding(0)

      Slider(value: $strokeWidth, in: 0...25, step: 0.5)
       .gridCellColumns(2)
     }
    }
   }
 
   VLRadialGraph(data: data)
    .radialGraph(thickness: thickness)
    .radialGraph(stroke: stroke, strokeWidth: strokeWidth)

   HStack
   {
    VLRadialGraph(data: data2)
     .radialGraph(colors: [ .blue, .green, .white])

    VLRadialGraph(data: data3)
   }
   .radialGraph(colors: [ .yellow, .purple, .pink])
   .radialGraph(thickness: 15)
   .frame(maxWidth: .infinity, maxHeight: 200)
   .padding()
  }
  .onChange(of: startAngle)
  {
   Task
   {
    await data.set(startAngle: startAngle)
    await data2.set(startAngle: startAngle)
    await data3.set(startAngle: startAngle)
   }
  }
  .onChange(of: endAngle)
  {
   Task
   {
    await data.set(endAngle: endAngle)
    await data2.set(endAngle: endAngle)
    await data3.set(endAngle: endAngle)
   }
  }
 }
}

#Preview
{
 VLRadialGraphWrapper()
}
#endif
