//
//  DrawFeedbackView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 14/01/2024.
//

import SwiftUI
import Vision

struct Line {
    var points: [CGPoint] = [CGPoint]()
    var color: Color = Color.theme.accent
    var lineWidth: Double = 3.0
}

struct RectangleShape {
    var topLeft: CGPoint
    var height: Int
    var width: Int
    var color: Color
    var lineWidth: Double = 3.0
}

struct DrawFeedbackView: View {
    @EnvironmentObject var store: Store
    var attempt: Attempt
    @Binding var frame: UIImage?
    @Binding var showScreen: Bool
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var selectedColor: Color = Color.theme.accent
    @State private var lastLineLength: Int = 0
    @State private var lineLengths: [Int] = []
    @State private var nextSubLineNewLine: Bool = true
    @State private var showColours: Bool = false
    @State private var currentTool: String = "pencil"
    
    
    
    var canvas: some View {
        return Canvas { context, size in
            print(size)
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
            }
        }
        .gesture(dragGesture)
    }
    
    
    var body: some View {
        ZStack {
            if let frame = frame {
                Image(uiImage: frame)
                    .resizable()
                    .containerRelativeFrame([.horizontal, .vertical])
                    .overlay(canvas)
            } else {
                Text("No Image Found to draw on!")
            }
            
                VStack {
                    HStack(alignment: .top) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                showScreen = false
                            }
                        
                        Spacer()
                        
                        VStack {
                            if showColours {
                                ColorPickerView(selectedColor: $selectedColor, goBack: removeLastStep, currentTool: $currentTool, showColours: $showColours)
                                    .onChange(of: selectedColor) { oldColor, newColor in
                                        currentLine.color = newColor
                                        showColours = false
                                    }
                            } else {
                                ToolPickerView(showColours: $showColours, currentTool: $currentTool, selectedColor: $selectedColor)
                            }
                            
                            if !self.lines.isEmpty {
                                Button {
                                    removeLastStep()
                                } label: {
                                    Image(systemName: "arrow.uturn.left")
                                        .resizable()
                                        .foregroundStyle(.accent)
                                        .frame(width: 30, height: 30)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundStyle(.green)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                // save canvas to uiimage
                                let drawingImage = canvas
                                    .frame(width: 390, height: 763)
                                    .snapshot()
                                if let image = frame {
                                    let targetSize = CGSize(width: 390, height: 763)
                                    let renderer = UIGraphicsImageRenderer(size: targetSize)
                                    let resizedFrame = renderer.image { (context) in
                                        image.draw(in: CGRect(origin: .zero, size: targetSize))
                                    }
                                    
                                    // merge image and canvas
                                    let mergedImage: UIImage = resizedFrame.mergeWith(topImage: drawingImage)
                                    Task {
                                        do {
                                            try await store.addDrawing(img: mergedImage, attempt: attempt)
                                            showScreen = false
                                            await store.sendToast(type: ToastType.success, message: "Image feedback added 👍")
                                        } catch {
                                            
                                        }
                                    }
                                }
                            }
                    }
                }
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

extension DrawFeedbackView {
    var dragGesture: some Gesture {
        return DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({value in
                self.currentLine.color = selectedColor
                
                switch self.currentTool {
                    
                // deal with straight line drawing
                case "line.diagonal":
                    if nextSubLineNewLine {
                        self.currentLine.points.append(value.location)
                    }
                    
                // deal with square drawing
                case "square":
                    if nextSubLineNewLine {
                        self.currentLine.points.append(value.location)
                    }
                
                // deal with free line drawing
                default:
                    if nextSubLineNewLine {
                        self.lastLineLength = 0
                    }
                    self.lastLineLength += 1
                    
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    self.lines.append(currentLine)
                }
                
                self.nextSubLineNewLine = false
            })
            .onEnded({value in
                switch self.currentTool {
                
                // deal with straight line drawing
                case "line.diagonal":
                    self.currentLine.points.append(value.location)
                    self.lineLengths.append(1)
                
                // deal with square drawing
                case "square":
                    // draw 4 lines
                    let origin = self.currentLine.points[0]
                    let oppositePoint = value.location
                    let secondPoint = CGPoint(x: origin.x, y: oppositePoint.y)
                    let fourthPoint = CGPoint(x: oppositePoint.x, y: origin.y)
                    self.currentLine.points = [origin, secondPoint, oppositePoint, fourthPoint, origin]
                    self.lineLengths.append(1)
                    
                // deal with free line drawing
                default:
                    self.lineLengths.append(self.lastLineLength+1)
                }
                
                self.lines.append(self.currentLine)
                self.nextSubLineNewLine = true
                self.currentLine = Line(points: [], color: selectedColor)
            })
    }
}


struct DrawFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        DrawFeedbackView(attempt: DrawFeedbackView_Previews.dev.attempt, frame: .constant(nil), showScreen: .constant(true))
    }
}
