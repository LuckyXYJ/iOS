//
//  LiquidDragView.m
//  BaseProject
//
//  Created by ios on 2019/4/17.
//  Copyright © 2019 ios. All rights reserved.
//

#import "LiquidDragView.h"

@implementation LiquidDragView

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    //w -40
    
//    CGFloat editHeight = kScreenHeight;
//    
//    CGFloat editWidth = kScreenWidth;
//    
//    CGFloat borderWidth = 2.0;
//    
//    CGRect rectBorder;
//    
//    
//    
//    if (_photo.height == 0 || _photo.width == 0) {
//        
//        
//        
//    }else if (_photo.height/_photo.width<(editHeight-80)/ScreenWidth) {//宽图
//        
//        editHeight = editWidth*_photo.height/_photo.width;
//        
//    }else{
//        
//        editHeight = ScreenHeight - 116-80;//-80为边距
//        
//        editWidth = editHeight/(_photo.height/_photo.width);
//        
//    }
//    
//    // 大小可以自定义
//    
//    rectBorder = CGRectMake((fabs(ScreenWidth-editWidth))/2, (fabs(ScreenHeight - 116-editHeight))/2, editWidth, editHeight);
//    
//    
//    
//    //抠出透明部分
//    
//    [[UIColor clearColor] setFill];
//    
//    UIRectFill(rectBorder);
//    
//    
//    
//    //画矩形边框可以自定义
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextAddRect(context, rectBorder);
//    
//    [[UIColor whiteColor]setStroke];
//    
//    //设置画笔宽度
//    
//    CGContextSetLineWidth(context, borderWidth);
//    
//    CGContextDrawPath(context, kCGPathStroke);
    
}

@end
