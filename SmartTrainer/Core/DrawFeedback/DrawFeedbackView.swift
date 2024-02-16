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
    var frame: UIImage?
    @Binding var showScreen: Bool
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var selectedColor: Color = Color.theme.accent
    @State private var lastLineLength: Int = 0
    @State private var lineLengths: [Int] = []
    @State private var nextSubLineNewLine: Bool = true
    
    var body: some View {
        ZStack {
            if let frame = frame {
                Image(uiImage: frame)
                    .resizable()
                    .containerRelativeFrame([.vertical, .horizontal])
            } else {
                Text("No Image Found to draw on!")
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
            .padding()
            
            VStack {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            showScreen = false
                        }
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundStyle(.green)
                        .frame(width: 40, height: 40)

                }
                .padding()
                Spacer()
            }
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
    DrawFeedbackView(showScreen: .constant(true))
}
