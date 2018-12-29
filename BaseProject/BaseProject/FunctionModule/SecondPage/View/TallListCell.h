//
//  TallListCell.h
//  BaseProject
//
//  Created by ios on 2018/12/28.
//  Copyright © 2018 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TallyModel;
@interface TallListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *wxLeb;
@property (weak, nonatomic) IBOutlet UILabel *aliLeb;
@property (weak, nonatomic) IBOutlet UILabel *zsLeb;
@property (weak, nonatomic) IBOutlet UILabel *zsvLeb;
@property (weak, nonatomic) IBOutlet UILabel *jtvLeb;
@property (weak, nonatomic) IBOutlet UILabel *pavLeb;
@property (weak, nonatomic) IBOutlet UILabel *totolLeb;
@property (weak, nonatomic) IBOutlet UILabel *timeLeb;
@property (nonatomic, strong)TallyModel *model;
@end

NS_ASSUME_NONNULL_END
