//
//  TallyModel.m
//  BaseProject
//
//  Created by ios on 2018/12/26.
//  Copyright © 2018 ios. All rights reserved.
//

#import "TallyModel.h"

@implementation TallyModel

- (void)tallyCalculate {
    
    CGFloat total = [self.wechat floatValue] + [self.alipay floatValue] + [self.cmbBank floatValue] + [self.cmbVisa floatValue] + [self.bcVisa floatValue] + [self.pinganVisa floatValue] - 43000 - 75000 -33000;
    
    self.totalMoney = [NSString stringWithFormat:@"%.2f",total];
    self.time = [self getTimeString];
}

- (NSString *)getTimeString {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate: date];
    return dateString;
}

@end
