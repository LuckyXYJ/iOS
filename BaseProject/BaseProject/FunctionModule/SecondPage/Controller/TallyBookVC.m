//
//  TallyBookVC.m
//  BaseProject
//
//  Created by ios on 2018/12/26.
//  Copyright © 2018 ios. All rights reserved.
//

#import "TallyBookVC.h"
#import "XFMDBManager.h"
#import "TallyModel.h"
#import "TallyListVC.h"

@interface TallyBookVC ()<UITextFieldDelegate>

@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic, strong)NSMutableArray *listArray;
@property(nonatomic, strong)UIView *commonLine;
@property(nonatomic, strong)TallyModel *model;

@property(nonatomic, strong)UILabel *totalLeb;
@property(nonatomic, strong)UILabel *timeLeb;
@end

@implementation TallyBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的资产";
    [self initBaseData];
    [self initUI];
}

- (void)initBaseData {
    
    _listArray = [NSMutableArray arrayWithArray: @[@{@"name":@"微信",@"key":@"wechat"},@{@"name":@"支付宝",@"key":@"alipay"},@{@"name":@"招商银行",@"key":@"cmbBank"},@{@"name":@"招商信用",@"key":@"cmbVisa"},@{@"name":@"交通信用",@"key":@"bcVisa"},@{@"name":@"平安信用",@"key":@"pinganVisa"}]];
}

- (void)initUI{
    
    UIImage *img = [[UIImage imageNamed:@"right_list_black"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(checkListView)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, _listArray.count * 450 + 70);
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.scrollView addGestureRecognizer:singleTap];
    [self.view addSubview:self.scrollView];
    CGFloat originY = 0;
    for (int i = 0; i < _listArray.count; i++) {
        UILabel *moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(15, originY + 10 + 45 * i, 100, 45)];
        moneyLB.text = _listArray[i][@"name"];
        moneyLB.textColor = [UIColor colorWithHexRGB:@"394246"];
        moneyLB.font = [UIFont systemFontOfSize:14];
        moneyLB.textAlignment = NSTextAlignmentLeft;
        [self.scrollView addSubview:moneyLB];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-29, originY + 10 + 45 * i, 14, 45)];
        lb.text = @"元";
        lb.textColor = [UIColor colorWithHexRGB:@"394246"];
        lb.font = [UIFont systemFontOfSize:14];
        lb.textAlignment = NSTextAlignmentRight;
        [self.scrollView addSubview:lb];
        
        UITextField *moneyField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - 189, originY + 10 + 45 * i, 150, 45)];
        moneyField.delegate = self;
        moneyField.placeholder = @"请输入";
        moneyField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        moneyField.textColor = [UIColor colorWithHexRGB:@"394246"];
        moneyField.keyboardType = UIKeyboardTypeDecimalPad;
        moneyField.autocorrectionType = UITextAutocorrectionTypeNo;
        [moneyField setValue:[UIColor colorWithHexRGB:@"CAD2D5"] forKeyPath:@"_placeholderLabel.textColor"];
        moneyField.textAlignment = NSTextAlignmentRight;
        [self.scrollView addSubview:moneyField];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.listArray[i]];
        [dict setValue:moneyField forKey:@"fieldView"];
        self.listArray[i] = dict;
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, originY + 10 + 45 * i + 44.75, kScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithHexRGB:@"EEF0F1"];
        [self.scrollView addSubview:lineView];
    }
    
    UIButton *calculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calculateBtn.frame = CGRectMake((kScreenWidth - 200)/3.0, _listArray.count * 45 + 30, 100, 38);
    calculateBtn.backgroundColor = [UIColor colorWithHexRGB:@"18C9FF"];
    calculateBtn.layer.masksToBounds = YES;
    calculateBtn.layer.cornerRadius = 19;
    [calculateBtn setTitle:@"计算" forState:UIControlStateNormal];
    [calculateBtn setTitleColor:[UIColor colorWithHexRGB:@"FFFFFF"] forState:UIControlStateNormal];
    calculateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [calculateBtn addTarget:self action:@selector(calculateAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:calculateBtn];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake((kScreenWidth - 200)/3.0*2+100, _listArray.count * 45 + 30, 100, 38);
    submitBtn.backgroundColor = [UIColor colorWithHexRGB:@"18C9FF"];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 19;
    [submitBtn setTitle:@"统计" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorWithHexRGB:@"FFFFFF"] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(tallyBookAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:submitBtn];
    
    _totalLeb = [[UILabel alloc] initWithFrame:CGRectMake(15, submitBtn.frame.origin.y+submitBtn.frame.size.height, kScreenWidth - 30, 45)];
    _totalLeb.text = @"";
    _totalLeb.textColor = [UIColor colorWithHexRGB:@"394246"];
    _totalLeb.font = [UIFont systemFontOfSize:14];
    _totalLeb.textAlignment = NSTextAlignmentLeft;
    _totalLeb.hidden = YES;
    [self.scrollView addSubview:_totalLeb];
    
    _timeLeb = [[UILabel alloc] initWithFrame:CGRectMake(15, _totalLeb.frame.origin.y+_totalLeb.frame.size.height, kScreenWidth - 30, 45)];
    _timeLeb.text = @"";
    _timeLeb.textColor = [UIColor colorWithHexRGB:@"394246"];
    _timeLeb.font = [UIFont systemFontOfSize:14];
    _timeLeb.textAlignment = NSTextAlignmentLeft;
    _timeLeb.hidden = NO;
    [self.scrollView addSubview:_timeLeb];
}

- (void)calculateAction {
    
    
    
    _model = [[TallyModel alloc]init];
    for (int i = 0; i < _listArray.count; i++) {
        UITextField *field = _listArray[i][@"fieldView"];
        if (field.text && field.text.length > 0) {
            [_model setValue:field.text forKey:_listArray[i][@"key"]];
        }else {
            [_model setValue:@"0" forKey:_listArray[i][@"key"]];
        }
    }
    [_model tallyCalculate];
    _totalLeb.hidden = NO;
    _totalLeb.text = [NSString stringWithFormat:@"总计：%@",_model.totalMoney];
    _timeLeb.hidden = NO;
    _timeLeb.text = [NSString stringWithFormat:@"时间：%@",_model.time];
//    [tallyDb addContent:model];
}

- (void)tallyBookAction {
    if (_model) {
        XFMDBManager *tallyDb = [[XFMDBManager alloc]init];
        [tallyDb createContentTable];
        [tallyDb addContent:_model];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    NSInteger flag=0;
    
    const NSInteger limited = 2;//小数点后需要限制的个数
    for (long i = (futureString.length-1); i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            if (flag > limited) {
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
}


- (void)checkListView {
    TallyListVC *testVC = [[TallyListVC alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
}

#pragma mark --收起键盘
// 滑动空白处隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
// 点击空白处收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
