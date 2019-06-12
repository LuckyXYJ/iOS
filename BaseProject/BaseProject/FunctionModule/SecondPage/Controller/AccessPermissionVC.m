//
//  AccessPermissionVC.m
//  BaseProject
//
//  Created by ios on 2019/3/25.
//  Copyright © 2019 ios. All rights reserved.
//

#import "AccessPermissionVC.h"
#import "ContactsVC.h"
#import "SimpleCell.h"

@interface AccessPermissionVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation AccessPermissionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"权限";
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSDictionary *list1 =  @{@"titleText":@"01 - 通讯录",@"clickSelector":@"contactsAction"};
    NSDictionary *list2 =  @{@"titleText":@"02 - 相册相机",@"clickSelector":@""};
    NSDictionary *list3 =  @{@"titleText":@"03 - 运动与健康",@"clickSelector":@""};
    NSDictionary *list4 =  @{@"titleText":@"04 - 日历",@"clickSelector":@""};
    NSDictionary *list5 =  @{@"titleText":@"05 - 权限读取",@"clickSelector":@""};
    NSDictionary *list6 =  @{@"titleText":@"06 - 位置",@"clickSelector":@""};
    NSDictionary *list7 =  @{@"titleText":@"07 - 面部id",@"clickSelector":@""};
    NSDictionary *list8 =  @{@"titleText":@"08 - 待定",@"clickSelector":@""};
    NSDictionary *list9 =  @{@"titleText":@"09 - 待定",@"clickSelector":@""};
    NSDictionary *list10 = @{@"titleText":@"10 - 待定",@"clickSelector":@""};
    NSDictionary *list11 = @{@"titleText":@"11 - 待定",@"clickSelector":@""};
    
    self.dataArray =@[list1,list2,list3,list4,list5,list6,list7,list8,list9,list10,list11].mutableCopy;
    
    [self initUI];
}

-(void)initUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight - kTopHeight) style:UITableViewStylePlain];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    [self.tableView registerClass:[SimpleCell class] forCellReuseIdentifier:@"SimpleCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

#pragma mark ————— tableview 代理 —————
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell" forIndexPath:indexPath];
    cell.cellData = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *selectorStr = _dataArray[indexPath.row][@"clickSelector"];
    if (selectorStr && selectorStr.length>0) {
        SEL selector = NSSelectorFromString(_dataArray[indexPath.row][@"clickSelector"]);
        if (selector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector: selector withObject: nil];
#pragma clang diagnostic pop
            //            [self performSelector:selector withObject:nil];
        }
    }
}

- (void)contactsAction {
    ContactsVC *testVC = [[ContactsVC alloc]init];
    
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
