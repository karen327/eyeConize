

import Foundation
import UIKit
import Vision

class Detect{
    var tmpText=""
    var current_code = ""
    var former_code = ""
    var output = ""
    
    let myNotificationName = Notification.Name("codeBri")
    
    let EYE_AR_THRESH = 0.2
    let EYE_AR_CONSEC_FRAMES = 2
    let EYE_OPEN_CONSEC_FRAMES = 2
    let DIV_THRESH = 20
//    let SPACE_THRESH = 100
    let SHORT_THRESH = 4
    let LONG_THRESH = 15
    let BLINK_FRE = 30
    let WIDTH = 1080
    let OUTPUT_LAST_TIME = 100
    //let THEME_COLOR_BLACK = (0, 0, 0)
    //let THEME_COLOR_BLUE = (0, 255, 255)

    var CLOSED_COUNTER = 0
    var TOTAL = 0
    var OPEN_COUNTER = 0
    var PARSED = 0
    var SPACED = 0
    var STATUS = 0
    var INPUT_MODE = 0
    var FRAME_COUNT = 0
    var OUTPUT_DISP_TIME = 0
    var OUTPUT_MODE = 0
    var CURRENT_TEMP = 24
    
    
    func get_width(string1:String) ->Int{
        var result = 0
        for ch in string1{
            if ch=="." {
                result += 1
            }
            else if ch==" " {
                result += 2
            }
            else{
                result += 3
            }
        }
        return result
    }
    
    
    func shorten_code(string1:String)->String{
        var result = 0
        var i = 0
        for _ in string1{
            if string1[string1.index(string1.startIndex, offsetBy:i)]=="." {
                result += 1
            }
            else if string1[string1.index(string1.startIndex, offsetBy:i)]==" "{
                result += 2
            }
            else{
                result += 3
            }
            i += 1
            if result > 10{
                break
            }
        }
        return String(string1[string1.index(string1.startIndex, offsetBy:i)...])
    }
    
    
    func parse_string(string1:String) ->String{
        var result = ""
        if !(string1.count==0){
            for ch in string1{
                if ch == "0" {
                    result += "."
                }
                else{
                    result += "-"
                }
            }
        }
        return result
    }
    
    func blinks_dectors(blink:Bool)->String{
        
        if OUTPUT_MODE != 0{
            OUTPUT_DISP_TIME += 1
            if OUTPUT_DISP_TIME > OUTPUT_LAST_TIME{
                OUTPUT_DISP_TIME = 0
                OUTPUT_MODE = 0
                output = ""
            }
        }
        
        
        FRAME_COUNT += 1
        FRAME_COUNT = FRAME_COUNT % BLINK_FRE
        
       
        //输出空格
        if OPEN_COUNTER >= DIV_THRESH && STATUS == 1 && !(output=="") && !output.hasSuffix(" "){
                output = output + " "
            print("输出空格")
            }
        
        
        if OPEN_COUNTER >= DIV_THRESH && PARSED == 0 && STATUS == 1{
            PARSED = 1
            
            if !(current_code==""){
                current_code += " "
                if get_width(string1: current_code) > 15{
                    current_code = shorten_code(string1: current_code)
                }
            }
            let userInfo = ["current_code": current_code,"former_code":parse_string(string1: former_code), "decode":true] as [String : Any]
            NotificationCenter.default.post(name: myNotificationName, object: self, userInfo: userInfo)
                //发送译码消息
            
            former_code=""
            }
        
            if blink{
                CLOSED_COUNTER += 1
//                print(CLOSED_COUNTER)
                if CLOSED_COUNTER >= EYE_AR_CONSEC_FRAMES{
                    if STATUS == 1{
                        STATUS = 0
                    }
                    OPEN_COUNTER = 0
                }
            }
        else{
            OPEN_COUNTER += 1
//            print("kaiyan")
//            print(OPEN_COUNTER)
            if OPEN_COUNTER >= EYE_OPEN_CONSEC_FRAMES{
                if STATUS == 0{
                    PARSED = 0
                    TOTAL += 1
                    if CLOSED_COUNTER < SHORT_THRESH{
                        current_code = current_code + "."
                        former_code = former_code + "0"
                        //print(current_code)
                    }
                    else {
                        if CLOSED_COUNTER < LONG_THRESH{
                            current_code = current_code + "-"
                            former_code = former_code + "1"
                        }
                        else{
                            current_code += "+"
                            former_code = ""
                            if INPUT_MODE == 1{
                                if (output.count) > 1{
                                    output = String(output[(output.index(output.startIndex, offsetBy:0))..<(output.index(output.startIndex, offsetBy:output.count-1))])
                                    
                                }
                                else{
                                    output = ""
                                }
                            }
                        }
                    }
                    let userInfo = ["current_code": current_code,"former_code":parse_string(string1: former_code), "decode":false] as [String : Any]
                NotificationCenter.default.post(name: myNotificationName, object: self, userInfo: userInfo)
                    
                }
                STATUS = 1
                CLOSED_COUNTER = 0
            }
        }
                
                //距离 currentcode output  outputmode input mode
            var tmp="current_code"+current_code+"\nINPUT_MODE:\(INPUT_MODE)\nOUTPUT_MODE: \(OUTPUT_MODE)\n"
                if OUTPUT_MODE == 1{
                    tmp+="输出"+output+"\n"
                }
                else if OUTPUT_MODE == 2{
                    tmp+="输出"+output+"\n"
                }
                else if OUTPUT_MODE == 3{
                    tmp+="向儿子发送呼唤信息\n"
                    tmp+="输出"+output+"\n"
                }
                if INPUT_MODE > 0{
                    tmp+=parse_string(string1: former_code)+"\n"
                }
                if INPUT_MODE == 1{
                    tmp+="输入模式\n"+"连眨六次（......）退出\n"
                }
                else if INPUT_MODE == 0{
                    tmp+="锁定模式\n"+"连眨四次（....）进入输入模式\n"+"短闭眼三次（---）进入紧急模式\n"+"眨二闭一（..-）进入呼唤模式\n"+"眨闭眨闭（.-.-）进入娱乐模式\n"+"眨闭（.-.-）进入空调模式\n"
                }
                else if INPUT_MODE == 4{
                    tmp+="功能选择\n"+"连眨四次（....）回主界面\n"
                }
                if INPUT_MODE == 1 && OUTPUT_MODE < 2{
                    tmp+="需要水：-.-\n"+"需要食物：..-.\n"+"需要小便：-..-\n"+"需要大便：.--.\n"+"是的：...\n"+"不是：.-.\n"
                }
                else if INPUT_MODE == 2{
                    tmp+="是否开启紧急呼救？\n"+"是：眨两次\n"+"不是：其他操作\n"
                }
                else if INPUT_MODE == 3 && OUTPUT_MODE < 2{
                    tmp+="请选择需要发送的备注\n"+"退出：其他\n"+"无备注：..-"+"需要水：-.-\n"+"需要食物：..-.\n"+"需要小便：-..-\n"+"需要大便：.--.\n"+"我好冷：...\n"+"我好热：.-.\n"
                }
                else if INPUT_MODE == 4{
                    tmp+="看视频：.-.\n"+"听音乐：--\n"+"看小说：-.\n"+"查看信息：--.\n"+"写文字：-.-\n"
                }
                else if INPUT_MODE == 5{
                    tmp+="当前空调温度：\n"+"调高空调温度：.-.\n"+"调低空调温度：--\n"+"退出：...\n"
            }
            
            return tmp
    }
    
    func highlightFaces(source: UIImage) -> UIImage  {
        tmpText = ""
        var resultImage = source
        let detectFaceRequest = VNDetectFaceLandmarksRequest { [self] (request, error) in
            if error == nil {
                if let results = request.results as? [VNFaceObservation] {
                    for faceObservation in results {
                        guard let landmarks = faceObservation.landmarks else {
                            continue
                        }
                        let boundingRect = faceObservation.boundingBox
                        var landmarkRegions: [VNFaceLandmarkRegion2D] = []
                        if let faceContour = landmarks.faceContour {
                            landmarkRegions.append(faceContour)
                        }
                        if let leftEye = landmarks.leftEye {
                            landmarkRegions.append(leftEye)
                        }
                        if let rightEye = landmarks.rightEye {
                            landmarkRegions.append(rightEye)
                        }
                        if let leftEyebrow = landmarks.leftEyebrow {
                            landmarkRegions.append(leftEyebrow)
                        }
                        if let rightEyebrow = landmarks.rightEyebrow {
                            landmarkRegions.append(rightEyebrow)
                        }
                  
                        resultImage = self.drawOnImage(source: resultImage,boundingRect: boundingRect,faceLandmarkRegions: landmarkRegions)
                        
                        let flag=calcuDist(points:landmarkRegions)
                        
                        self.tmpText = self.tmpText + self.blinks_dectors(blink: flag)
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }

        let vnImage = VNImageRequestHandler(cgImage: source.cgImage!, options: [:])
        try? vnImage.perform([detectFaceRequest])

        return resultImage
    }
    
    //在UITextView中显示关键点信息
//    func showDetail(flag:Bool) -> String {
//        let regionsType = ["人脸轮廓","左眼","右眼","鼻子","外嘴唇","左眉","右眉","内嘴唇"]
//        var faceDetail = "\n人脸关键点信息\n"
//        var pointCount = 0
//        for a in 0..<faceLandmarkRegions.count{
//            faceDetail = faceDetail + "\(regionsType[a])（共\(faceLandmarkRegions[a].pointCount)个关键点)\n"
//                pointCount = pointCount + faceLandmarkRegions[a].pointCount
//
//                for i in 0..<faceLandmarkRegions[a].pointCount {
//                    let point = faceLandmarkRegions[a].normalizedPoints[i]
//                    let p = CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))
//                    faceDetail = faceDetail + "(\(p.x),\(p.y))\n"
//                }
//        }
        
        //此处修改
//        for i in 0..<faceLandmarkRegions[2].pointCount {
//            let point = faceLandmarkRegions[2].normalizedPoints[i]
//            let p = CGPoint(x: CGFloat(point.x*100), y: CGFloat(point.y*100))
//            print("第\(i)个点是：(\(p.x),\(p.y))\n")
//        }
//
//        if calcuDist(points: faceLandmarkRegions){
//            faceDetail="眨眼"
//            print("眨眼")
//        }
//
//        //faceDetail = faceDetail + "共检测出\(pointCount)个关键点\n"
//        faceDetail="未眨眼"
//        print("未眨眼")
//        return faceDetail
        
        
 //   }
    
    //把关键点绘制在UIImageView中，并连线形成轮廓
    func drawOnImage(source: UIImage,boundingRect: CGRect,faceLandmarkRegions: [VNFaceLandmarkRegion2D]) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(source.size, false, 1)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: source.size.height)//变换原点
        context.scaleBy(x: 1.0, y: -1.0)//y轴轴对称
//        context.setBlendMode(CGBlendMode.colorBurn)//设置混合模式
        context.setLineJoin(.round)//设置线条交点样式
        context.setLineCap(.round)//设置线条端点样式
        context.setShouldAntialias(true)//抗锯齿
        context.setAllowsAntialiasing(true)//允许抗锯齿
        
        let rectWidth = source.size.width * boundingRect.size.width
        let rectHeight = source.size.height * boundingRect.size.height
        
        //draw image
        let rect = CGRect(x: 0, y:0, width: source.size.width, height: source.size.height)
        context.draw(source.cgImage!, in: rect)
        
        //draw bound rect
        var fillColor = UIColor.black
        fillColor.setFill()
        context.setLineWidth(2.0)
        context.addRect(CGRect(x: boundingRect.origin.x * source.size.width, y:boundingRect.origin.y * source.size.height, width: rectWidth, height: rectHeight))
        context.drawPath(using: CGPathDrawingMode.stroke)
        
        //draw overlay
        fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        fillColor.setStroke()
        context.setLineWidth(5.0)
        for faceLandmarkRegion in faceLandmarkRegions {
            var points: [CGPoint] = []
            
            for i in 0..<faceLandmarkRegion.pointCount {
                let point = faceLandmarkRegion.normalizedPoints[i]
                let p = CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))//获取距离可进行计算
                points.append(p)
            }
            let mappedPoints = points.map { CGPoint(x: boundingRect.origin.x * source.size.width + $0.x * rectWidth, y: boundingRect.origin.y * source.size.height + $0.y * rectHeight) }
            context.addLines(between: mappedPoints)
            context.drawPath(using: CGPathDrawingMode.stroke)
        }
        
        let coloredImg:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return coloredImg
    }
    
    //距离计算函数
    func calcuDist(points:[VNFaceLandmarkRegion2D])->Bool{
        var left: [CGPoint] = []
        var right: [CGPoint] = []
        //左眼
        for i in 0..<points[1].pointCount {
            let point = points[1].normalizedPoints[i]
            let p = CGPoint(x: CGFloat(point.x*1000), y: CGFloat(point.y*1000))
            left.append(p)
                    }
        //右眼
        for i in 0..<points[2].pointCount {
            let point = points[2].normalizedPoints[i]
            let p = CGPoint(x: CGFloat(point.x*1000), y: CGFloat(point.y*1000))
            right.append(p)
        }
        let la=euclideanDistance(pointA: left[1], pointB: left[5])
        let lb=euclideanDistance(pointA: left[2], pointB: left[4])
        let lc=euclideanDistance(pointA: left[0], pointB: left[3])
        
        let Lfinal=(la+lb)/(2*lc)
        
        let ra=euclideanDistance(pointA: right[1], pointB: right[5])
        let rb=euclideanDistance(pointA: right[2], pointB: right[4])
        let rc=euclideanDistance(pointA: right[0], pointB: right[3])
        
        let Rfinal=(ra+rb)/(2*rc)
        
//        print(Lfinal)
//        print("you")
//        print(Rfinal)
        
        let dis=(Rfinal+Lfinal)/2.0
        
        if dis<0.2{
//            print("眨眼")
            return true
        }
        return false
        
    }
    
    func euclideanDistance(pointA:CGPoint,pointB:CGPoint)->Double{
        let x=(pointA.x-pointB.x)*(pointA.x-pointB.x)
        let y=(pointA.y-pointB.y)*(pointA.y-pointB.y)
        return sqrt((x+y))
    }
    }
