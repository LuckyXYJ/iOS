//
//  UIColor+XYJColor.h
//  BaseProject
//
//  Created by ios on 2018/12/19.
//  Copyright © 2018 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (XYJColor)
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(float)alpha;
@end

NS_ASSUME_NONNULL_END
