//
//  DrawFeedbackView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 14/01/2024.
//

import SwiftUI

struct Line {
    var points: [CGPoint] = [CGPoint]()
    var color: Color = Color.theme.accent
    var lineWidth: Double = 3.0
}

struct DrawFeedbackView: View {
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var selectedColor: Color = Color.theme.accent
    @State private var lastLineLength: Int = 0
    @State private var lineLengths: [Int] = []
    @State private var nextSubLineNewLine: Bool = true
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("back_squat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .ignoresSafeArea()
            }
            VStack {
                Canvas { context, size in
                    for line in lines {
                        var path = Path()
                        path.addLines(line.points)
                        context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                    }
                    
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        if nextSubLineNewLine {
                            self.lastLineLength = 0
                        }
                        self.nextSubLineNewLine = false
                        self.lastLineLength += 1
                        
                        let newPoint = value.location
                        currentLine.points.append(newPoint)
                        self.lines.append(currentLine)
                    })
                        .onEnded({ value in
                            self.currentLine = Line(points: [], color: selectedColor)
                            self.nextSubLineNewLine = true
                            self.lineLengths.append(self.lastLineLength)
                        })
                )
                ColorPickerView(selectedColor: $selectedColor, goBack: removeLastStep)
                    .onChange(of: selectedColor) { oldColor, newColor in
                        currentLine.color = newColor
                    }
            }
            .frame(minWidth: 400, minHeight: 400)
            .padding()
        }
    }
    
    func removeLastStep() {
        if self.lines.isEmpty {
            return
        }
        self.lines.removeLast(self.lineLengths.last!)
        self.lineLengths.removeLast()
        self.lastLineLength = 0
    }
}


#Preview {
    DrawFeedbackView()
}
