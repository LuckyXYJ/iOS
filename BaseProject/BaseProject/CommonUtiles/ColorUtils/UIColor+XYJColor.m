//
//  UIColor+XYJColor.m
//  BaseProject
//
//  Created by ios on 2018/12/19.
//  Copyright © 2018 ios. All rights reserved.
//

#import "UIColor+XYJColor.h"

@implementation UIColor (XYJColor)
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString{
    
    
    return [UIColor colorWithHexRGB:inColorString alpha:1.0];
}

+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(float)alpha {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    return result;
}

@end
