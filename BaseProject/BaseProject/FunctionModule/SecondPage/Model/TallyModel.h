//
//  TallyModel.h
//  BaseProject
//
//  Created by ios on 2018/12/26.
//  Copyright © 2018 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TallyModel : NSObject

@property (nonatomic, assign) int tallyId;
@property (nonatomic, copy) NSString *wechat;
@property (nonatomic, copy) NSString *alipay;
@property (nonatomic, copy) NSString *cmbBank;//招商
@property (nonatomic, copy) NSString *cmbVisa;//招商
@property (nonatomic, copy) NSString *bcVisa;//交通
@property (nonatomic, copy) NSString *pinganVisa;//招商
@property (nonatomic, copy) NSString *totalMoney;//合计
@property (nonatomic, copy) NSString *time;//时间

- (void)tallyCalculate;
@end

NS_ASSUME_NONNULL_END
