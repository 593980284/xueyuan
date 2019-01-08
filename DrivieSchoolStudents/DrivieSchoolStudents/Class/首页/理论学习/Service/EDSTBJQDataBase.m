//
//  EDSTBJQDataBase.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2019/1/6.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "EDSTBJQDataBase.h"
#import <FMDB.h>

static EDSTBJQDataBase *_DBCtl = nil;
static FMDatabaseQueue *_queue = nil;


@interface EDSTBJQDataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
}
@end
@implementation EDSTBJQDataBase
-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}

+ (instancetype)sharedDataBase
{
    if (_DBCtl == nil) {
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentDirectory = [paths objectAtIndex:0];
        
        //dbPath： 数据库路径，在Document中。
//        NSString *dbPath = [documentDirectory stringByAppendingPathxrComponent:@"bank.db"];
//        NSLog(@"hyf-----%@",dbPath);
        _DBCtl = [[EDSTBJQDataBase alloc] init];
      NSString *dbPath =  [[NSBundle mainBundle]pathForResource:@"icon" ofType:@"db"];
        _queue =  [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [_DBCtl initDataBase];
    }
    
    return _DBCtl;
}
-(void)initDataBase{
    
    //    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //    NSString * documentsDirectory =[paths objectAtIndex:0];
    //    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    //    {
    //        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    //    }
    //
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentDirectory = [paths objectAtIndex:0];
//    //dbPath： 数据库路径，在Document中。
//    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"bank.db"];
    // 实例化FMDataBase对象
    NSString *dbPath =  [[NSBundle mainBundle]pathForResource:@"icon" ofType:@"db"];
    _db = [FMDatabase databaseWithPath:dbPath];
}
//获取道路图标
-(NSArray *)getDaoLuTuBaio{
    [_db open];
    FMResultSet *res = [_db executeQuery:@"SELECT *FROM iconbean WHERE cid = 1 LIMIT 100"];
    NSMutableArray * tubiaoArr = [NSMutableArray new];
    while ([res next]) {
        NSDictionary * tubiaoDic = @{
                                     @"title":[res stringForColumn:@"title"],
                                     @"icon":[res stringForColumn:@"icon"],
                                     };
        [tubiaoArr addObject:tubiaoDic];
        //        NSString * title = [res stringForColumn:@"title"];
        //        DLog(@"feng-----%@",title);
    }
    [_db close];
    return tubiaoArr;
}
//汽车仪表
-(NSArray *)getQiCheYiBiao{
    [_db open];
    FMResultSet *res = [_db executeQuery:@"SELECT *FROM iconbean WHERE cid = 14 LIMIT 100"];
    NSMutableArray * tubiaoArr = [NSMutableArray new];
    while ([res next]) {
        NSDictionary * tubiaoDic = @{
                                     @"title":[res stringForColumn:@"title"],
                                     @"icon":[res stringForColumn:@"icon"],
                                     };
        [tubiaoArr addObject:tubiaoDic];
        //        NSString * title = [res stringForColumn:@"title"];
        //        DLog(@"feng-----%@",title);
    }
    [_db close];
    return tubiaoArr;
}
//车内功能按键
-(NSArray *)getCheNeiGongNengJian{
    [_db open];
    FMResultSet *res = [_db executeQuery:@"SELECT *FROM iconbean WHERE cid = 15 LIMIT 100"];
    NSMutableArray * tubiaoArr = [NSMutableArray new];
    while ([res next]) {
        NSDictionary * tubiaoDic = @{
                                     @"title":[res stringForColumn:@"title"],
                                     @"icon":[res stringForColumn:@"icon"],
                                     };
        [tubiaoArr addObject:tubiaoDic];
        //        NSString * title = [res stringForColumn:@"title"];
        //        DLog(@"feng-----%@",title);
    }
    [_db close];
    return tubiaoArr;
}
//交通事故
-(NSArray *)getJiaoTongShiGu{
    [_db open];
    FMResultSet *res = [_db executeQuery:@"SELECT *FROM iconbean WHERE cid = 17 LIMIT 100"];
    NSMutableArray * tubiaoArr = [NSMutableArray new];
    while ([res next]) {
        NSDictionary * tubiaoDic = @{
                                     @"title":[res stringForColumn:@"title"],
                                     @"icon":[res stringForColumn:@"icon"],
                                     };
        [tubiaoArr addObject:tubiaoDic];
        //        NSString * title = [res stringForColumn:@"title"];
        //        DLog(@"feng-----%@",title);
    }
    [_db close];
    return tubiaoArr;
}




-(NSArray * )getTuBiaoWithCid:(long)cid andlimit:(NSInteger)limit{
    
    [_db open];

    FMResultSet *res = [_db executeQuery:@"SELECT *FROM iconbean WHERE cid = %ld  LIMIT 100",(long)cid];
    
    NSMutableArray * tubiaoArr = [NSMutableArray new];
    
    while ([res next]) {
        
        NSDictionary * tubiaoDic = @{
                                     @"title":[res stringForColumn:@"title"],
                                     @"icon":[res stringForColumn:@"icon"],
                                     };
        [tubiaoArr addObject:tubiaoDic];
//        NSString * title = [res stringForColumn:@"title"];
//        DLog(@"feng-----%@",title);
    }
    [_db close];
    
    return tubiaoArr;
//    return nil;
    
}

@end
