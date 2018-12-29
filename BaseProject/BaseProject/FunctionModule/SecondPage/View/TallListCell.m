//
//  TallListCell.m
//  BaseProject
//
//  Created by ios on 2018/12/28.
//  Copyright © 2018 ios. All rights reserved.
//

#import "TallListCell.h"
#import "TallyModel.h"

@implementation TallListCell

- (void)setModel:(TallyModel *)model {
    
    _model = model;
    _wxLeb.text = [NSString stringWithFormat:@"微信：%@", model.wechat];
    _aliLeb.text = [NSString stringWithFormat:@"支付宝：%@", model.alipay];
    _zsLeb.text = [NSString stringWithFormat:@"招商：%@", model.cmbBank];
    _zsvLeb.text = [NSString stringWithFormat:@"招商：%@", model.cmbVisa];
    _jtvLeb.text = [NSString stringWithFormat:@"交通：%@", model.bcVisa];
    _pavLeb.text = [NSString stringWithFormat:@"平安：%@", model.pinganVisa];
    _totolLeb.text = [NSString stringWithFormat:@"合计：%@", model.totalMoney];
    _timeLeb.text = [NSString stringWithFormat:@"%@", model.time];
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
