//
//  TallyListVC.m
//  BaseProject
//
//  Created by ios on 2018/12/28.
//  Copyright © 2018 ios. All rights reserved.
//

#import "TallyListVC.h"
#import "TallListCell.h"
#import "XFMDBManager.h"

@interface TallyListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, strong) UIButton *rightbutton;

@property (nonatomic,strong) UIButton *deleteBT;
@end

@implementation TallyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"记录";
    self.dataArray = [NSMutableArray array];
    self.selectArray = [NSMutableArray array];
    self.indexArray = [NSMutableArray array];
    [self initUI];
    [self requestData];
}

-(void)initUI{
    
    self.rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 15 -34, 12.5, 34, 24)];
    [self.rightbutton setBackgroundColor:[UIColor whiteColor]];
    [self.rightbutton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightbutton setTitleColor:[UIColor colorWithHexRGB:@"394246"] forState:(UIControlStateNormal)];
    self.rightbutton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.rightbutton.userInteractionEnabled = YES;
    [self.rightbutton addTarget:self action:@selector(editeAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:self.rightbutton];
    self.navigationItem.rightBarButtonItem=rightitem;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight - kTopHeight) style:UITableViewStylePlain];
    //分割线设置
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //分割线风格设置
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TallListCell" bundle:nil] forCellReuseIdentifier:@"TallListCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView reloadData];
    
    
    self.deleteBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.deleteBT.frame = CGRectMake(15,  kScreenHeight - 55 - kBotHeight, kScreenWidth - 30, 45);
    self.deleteBT.layer.cornerRadius = 7;
    self.deleteBT.layer.masksToBounds = YES;
    self.deleteBT.backgroundColor = [UIColor colorWithHexRGB:@"FF2525"];
    [self.deleteBT setTitle:@"删除" forState:(UIControlStateNormal)];
    [self.deleteBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.deleteBT.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.deleteBT addTarget:self action:@selector(deleteBTAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.deleteBT.hidden = YES;
    [self.view addSubview:self.deleteBT];
    
}

#pragma mark ————— tableview 代理 —————
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TallListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TallListCell" forIndexPath:indexPath];
//    cell.cellData = _dataArray[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView.editing) {
        TallyModel *model = self.dataArray[indexPath.row];
        [self.selectArray addObject:[NSNumber numberWithInt:model.tallyId]];
        [self.indexArray addObject:model];
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.tableView.editing) {
        TallyModel *model = self.dataArray[indexPath.row];
        [self.selectArray removeObject:[NSNumber numberWithInt:model.tallyId]];
        [self.indexArray removeObject:[NSNumber numberWithInteger:indexPath.row]];
    }else {
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.dataArray.count > 0){
        return YES;
    }else{
        return NO;
    }
}
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count > 0) {
        if (tableView.isEditing) {
            // 多选
            return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
        }else{
            //删除
            return UITableViewCellEditingStyleDelete;
        }
    }else{
        return UITableViewCellEditingStyleNone;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count > 0) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            TallyModel *model = self.dataArray[indexPath.row];
            XFMDBManager *tallyDb = [[XFMDBManager alloc]init];
            [tallyDb deleteContent:model.tallyId];
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
            
        }else{
            
        }
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > 0) {
        return @"删除";
    }else{
        return nil;
    }
    
}

- (void)requestData {
    XFMDBManager *tallyDb = [[XFMDBManager alloc]init];
    self.dataArray = [tallyDb getAllContent];
    [self.tableView reloadData];
    
}

- (void)editeAction {

    self.tableView.editing = ! self.tableView.editing;
    [self.rightbutton setTitle:self.tableView.editing ? @"取消":@"编辑" forState:(UIControlStateNormal)];
    self.deleteBT.hidden = (self.tableView.editing) ? NO:YES;
    self.tableView.frame =  CGRectMake(0, kTopHeight, kScreenWidth, self.tableView.editing ? (kScreenHeight - kTopHeight - kBotHeight - 65) : (kScreenHeight -kTopHeight));
}

- (void)deleteBTAction{
    
    XFMDBManager *tallyDb = [[XFMDBManager alloc]init];
    [tallyDb deleteContents:self.selectArray];
    [self editeAction];
    for (TallyModel *model in self.indexArray) {
        [self.dataArray removeObject:model];
    }
    [self.tableView reloadData];
    
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
