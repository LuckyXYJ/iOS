//
//  XFMDBManager.h
//  BaseProject
//
//  Created by ios on 2018/12/26.
//  Copyright © 2018 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TallyModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^getDataByPrimaryKey)(NSData *data);
typedef void(^getAllData)(NSArray *dataArr);

@interface XFMDBManager : NSObject
{
    FMDatabase* _db;
}

/**
 创建表

 @return 是否创建成功
 */
- (BOOL)createContentTable;

/**
 插入数据

 @param tallyInfo 数据模型，需要内部配置
 @return 是否插入成功
 */
- (BOOL)addContent:(TallyModel*)tallyInfo;

/**
 批量增加数据

 @param brandInfos 数据列表
 @return 是否成功
 */
- (BOOL)batchAddContent:(NSArray*)brandInfos;
/**
 删除单条数据

 @param primaryKey 主键id
 */
- (BOOL)deleteContent:(int)primaryKey;

/**
 删除多条数据

 @param primaryKeys 主键id集合
 */
- (BOOL)deleteContents:(NSArray *)primaryKeys;

/**
 获取所有数据

 @return 返回数据列表
 */
- (NSMutableArray*)getAllContent;

/**
 删除所有数据
 */
- (BOOL)deleteAllContent;

/**
 搜索数据

 @param searchText searchText
 @return 数据列表
 */
- (NSMutableArray*)serachContent:(NSString*)searchText;

/**
 更新数据

 @param searchText searchText
 @param updateStr updateStr
 @return 是否成功
 */
- (BOOL)updateContent:(NSString*)searchText withUpdateStr:(NSString *)updateStr;
@end

NS_ASSUME_NONNULL_END
