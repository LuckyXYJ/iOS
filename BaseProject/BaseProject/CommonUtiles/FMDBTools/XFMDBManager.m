//
//  XFMDBManager.m
//  BaseProject
//
//  Created by ios on 2018/12/26.
//  Copyright © 2018 ios. All rights reserved.
//

#import "XFMDBManager.h"

@implementation XFMDBManager

- (id)init
{
    self = [super init];
    if (self) {
        //1.创建database路径
        NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//        docuPath = @"/Users/ios/个人/资料/fmdbSql";
        NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
        NSLog(@"!!!dbPath = %@",dbPath);
        //2.创建对应路径下数据库
        _db = [FMDatabase databaseWithPath:dbPath];
        //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
        [_db open];
        if (![_db open]) {
            NSLog(@"db open fail");
            return nil;
        }
    }
    return self;
}
//建立数据库表
- (BOOL)createContentTable
{
    [_db beginTransaction];
    
    BOOL success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS TallyData (tallyId integer primary key AUTOINCREMENT,wechat TEXT ,alipay TEXT,cmbBank TEXT,cmbVisa TEXT,bcVisa TEXT,pinganVisa TEXT,totalMoney TEXT,time TEXT);"];
    [_db commit];
    
    if (!success || [_db hadError]) {
        [_db rollback];
        
        NSLog(@"faild");
        return NO;
    }
    else {
        NSLog(@"建立数据库表 success");
    }
    return YES;
}
//增加数据
-(BOOL)addContent:(TallyModel*)brandInfo
{
    [_db beginTransaction];
    
    BOOL success = [_db executeUpdate:@"INSERT INTO TallyData(wechat,alipay,cmbBank,cmbVisa,bcVisa,pinganVisa,totalMoney,time) VALUES (?,?,?,?,?,?,?,?)",
                    brandInfo.wechat,
                    brandInfo.alipay,
                    brandInfo.cmbBank,
                    brandInfo.cmbVisa,
                    brandInfo.bcVisa,
                    brandInfo.pinganVisa,
                    brandInfo.totalMoney,
                    brandInfo.time];
    
    [_db commit];
    
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"faild  yes  no");
        return NO;
    }
    return YES;
}
//批处理数据 仅作示例
- (BOOL)batchAddContent:(NSArray *)brandInfos{
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int i = 0; i<brandInfos.count; i++) {
            TallyModel *brandInfo = brandInfos[i];
            BOOL success = [_db executeUpdate:@"INSERT INTO TallyData(wechat,alipay,cmbBank,cmbVisa,bcVisa,pinganVisa,totalMoney,time) VALUES (?,?,?,?,?,?,?,?)",
                            brandInfo.wechat,
                            brandInfo.alipay,
                            brandInfo.cmbBank,
                            brandInfo.cmbVisa,
                            brandInfo.bcVisa,
                            brandInfo.pinganVisa,
                            brandInfo.totalMoney,
                            brandInfo.time];
            if (!success ) {
                NSLog(@"插入失败1");
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
        return NO;
    }
    @finally {
        if (!isRollBack) {
            [_db commit];
            return YES;
        }
    }
}
//搜索内容
- (NSMutableArray*)serachContent:(NSString*)searchText
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    NSString *sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM TallyData WHERE time LIKE '%%%@%%'", searchText];
    
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        TallyModel* brandInfo = [[TallyModel alloc] init];
        brandInfo.tallyId = [rs intForColumn:@"id"];
        brandInfo.wechat = [rs stringForColumn:@"wechat"];
        brandInfo.alipay = [rs stringForColumn:@"alipay"];
        brandInfo.cmbBank = [rs stringForColumn:@"cmbBank"];
        brandInfo.cmbVisa = [rs stringForColumn:@"cmbVisa"];
        brandInfo.bcVisa = [rs stringForColumn:@"bcVisa"];
        brandInfo.pinganVisa = [rs stringForColumn:@"pinganVisa"];
        brandInfo.totalMoney = [rs stringForColumn:@"totalMoney"];
        brandInfo.time = [rs stringForColumn:@"time"];
        [result addObject:brandInfo ];
    }
    [rs close];
    NSMutableArray* sort = [NSMutableArray array];
    if (result && [result count] > 0) {
        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creatTime" ascending:NO] ;
        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        sort = [NSMutableArray arrayWithArray:[result sortedArrayUsingDescriptors:sortDescriptors]];
    }
    
    return sort;
}
//更新数据
- (BOOL)updateContent:(NSString*)searchText withUpdateStr:(NSString *)updateStr
{
    
    [_db beginTransaction];
    NSString *sqlStr=[NSString stringWithFormat:@"UPDATE TallyData SET time='%@' WHERE time LIKE '%%%@%%'", updateStr,searchText];
    BOOL success = [_db executeUpdate:sqlStr];
    
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"faild  yes  no");
        return NO;
    }
    [_db commit];
    return YES;
}
//获取所有数据
- (NSMutableArray*)getAllContent
{
    NSMutableArray* result = [NSMutableArray array];
    NSString *sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM TallyData"];
    
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        TallyModel* brandInfo = [[TallyModel alloc] init];
        brandInfo.tallyId = [rs intForColumn:@"id"];
        brandInfo.wechat = [rs stringForColumn:@"wechat"];
        brandInfo.alipay = [rs stringForColumn:@"alipay"];
        brandInfo.cmbBank = [rs stringForColumn:@"cmbBank"];
        brandInfo.cmbVisa = [rs stringForColumn:@"cmbVisa"];
        brandInfo.bcVisa = [rs stringForColumn:@"bcVisa"];
        brandInfo.pinganVisa = [rs stringForColumn:@"pinganVisa"];
        brandInfo.totalMoney = [rs stringForColumn:@"totalMoney"];
        brandInfo.time = [rs stringForColumn:@"time"];
        [result addObject:brandInfo ];
    }
    [rs close];
 
    return result;
}
//删除单条内容
- (BOOL)deleteContent:(int)primaryKey
{
    [_db beginTransaction];
    NSString *str = [NSString stringWithFormat:@"DELETE FROM TallyData WHERE id = %d or id = 14",primaryKey];
    BOOL success = [_db executeUpdate:str];
    [_db commit];
    if(!success ||[_db hadError])
    {
        [_db rollback];
        NSLog(@"error1");
        return NO;
    }
    return YES;
}
//删除多条内容
- (BOOL)deleteContents:(NSArray *)primaryKeys {
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < primaryKeys.count; i++) {
        [arr addObject:[NSString stringWithFormat:@"id = %d",[primaryKeys[i] intValue]]];
    }
    NSString *str = [arr componentsJoinedByString:@" or "];
    [_db beginTransaction];
    NSString *delStr = [NSString stringWithFormat:@"DELETE FROM TallyData WHERE %@",str];
    BOOL success = [_db executeUpdate:delStr];
    [_db commit];
    if(!success ||[_db hadError])
    {
        [_db rollback];
        NSLog(@"error1");
        return NO;
    }
    return YES;
}

//删除所有数据
- (BOOL)deleteAllContent
{
    [_db beginTransaction];
    BOOL success = [_db executeUpdate:@"DELETE  FROM TallyData"];
    [_db commit];
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"error1");
        return NO;
    }
    return YES;
}

- (void)dealloc {
    [_db close];
}

@end
