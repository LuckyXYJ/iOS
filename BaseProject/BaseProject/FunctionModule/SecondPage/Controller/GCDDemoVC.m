//
//  GCDDemoVC.m
//  BaseProject
//
//  Created by ios on 2019/6/5.
//  Copyright © 2019 ios. All rights reserved.
//

#import "GCDDemoVC.h"
#import "SimpleCell.h"

@interface GCDDemoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation GCDDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"好友";
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSDictionary *list1 =  @{@"titleText":@"01 - demo",@"clickSelector":@"syncGetMainQueue"};
    NSDictionary *list2 =  @{@"titleText":@"02 - demo",@"clickSelector":@"syncGetGlobalQueue"};
    NSDictionary *list3 =  @{@"titleText":@"03 - demo",@"clickSelector":@"asyncGetCreatQueue"};
    NSDictionary *list4 =  @{@"titleText":@"04 - demo",@"clickSelector":@"asyncGlobalQueue"};
    NSDictionary *list5 =  @{@"titleText":@"05 - demo",@"clickSelector":@"demo5"};
    NSDictionary *list6 =  @{@"titleText":@"06 - demo",@"clickSelector":@""};
    NSDictionary *list7 =  @{@"titleText":@"07 - demo",@"clickSelector":@""};
    NSDictionary *list8 =  @{@"titleText":@"08 - demo",@"clickSelector":@""};
    NSDictionary *list9 =  @{@"titleText":@"09 - demo",@"clickSelector":@""};
    NSDictionary *list10 = @{@"titleText":@"10 - demo",@"clickSelector":@""};
    NSDictionary *list11 = @{@"titleText":@"11 - demo",@"clickSelector":@""};
    
    self.dataArray =@[list1,list2,list3,list4,list5,list6,list7,list8,list9,list10,list11].mutableCopy;
    
    [self initUI];
}

-(void)initUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight - kTopHeight -kTabBarHeight) style:UITableViewStylePlain];
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

- (void)syncAction {
    dispatch_queue_t  _Nonnull queue;
    dispatch_sync(queue, ^{
        
    });
    
    // 串行队列的创建方法
    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    // 并发队列的创建方法
    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
}

- (void)syncGetMainQueue {
    
    /**
     try也拯救不了的死锁
     */
    @try {
        // 可能会出现崩溃的代码
        NSLog(@"1");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    }
    @catch (NSException *exception) {
        // 捕获到的异常exception
        NSLog(@"%@",exception);
    }
    @finally {
        // 结果处理
        NSLog(@"success");
    }
}

- (void)syncGetGlobalQueue {
    
    NSLog(@"1");
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)asyncGetCreatQueue {
    
    dispatch_queue_t queue = dispatch_queue_create("com.demo.queue", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"1");
    
    dispatch_async(queue, ^{
        NSLog(@"2");
        
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    
    NSLog(@"5");
}


- (void)asyncGlobalQueue {
    
    NSLog(@"1");
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    
    NSLog(@"5");
}

- (void)demo5 {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    while (1) {
        
    }
    NSLog(@"5");
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
