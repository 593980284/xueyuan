//
//  EDSFirstSubjectExamBase.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFirstSubjectExamBase.h"
#import <FMDB.h>

static EDSFirstSubjectExamBase *_DBCtl = nil;
static FMDatabaseQueue *_queue = nil;

@interface EDSFirstSubjectExamBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}
@end

@implementation EDSFirstSubjectExamBase


+ (instancetype)sharedDataBase
{
    if (_DBCtl == nil) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"classify.db"];
        _DBCtl = [[EDSFirstSubjectExamBase alloc] init];
        _queue =  [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    
    return _DBCtl;
}


+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
        [_DBCtl initDataBase];
    }
    
    return _DBCtl;
    
}

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

-(void)initDataBase{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"classify.db"];
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:dbPath];
}

- (NSArray *)getFirstSubjectExam
{
    [_db open];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT bankid FROM classifyfristbean WHERE tagid = 12 OR tagid = 16 ORDER BY random() LIMIT 20"]];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    while ([res next]) {
        
        [arr addObject:[res stringForColumn:@"bankid"]];
    }
    
    FMResultSet *res1 = [_db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT bankid FROM classifyfristbean WHERE bankid not in %@ AND tagid = 7 OR tagid = 8 OR tagid = 11 ORDER BY random() LIMIT 25",arr]];
    
    while ([res1 next]) {
        
        [arr addObject:[res1 stringForColumn:@"bankid"]];
    }
    
    FMResultSet *res2 = [_db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT bankid FROM classifyfristbean WHERE bankid not in %@ AND tagid = 14 OR tagid = 9 ORDER BY random() LIMIT 20",arr]];
    
    while ([res2 next]) {
        
        [arr addObject:[res2 stringForColumn:@"bankid"]];
    }
    
    FMResultSet *res3 = [_db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT bankid FROM classifyfristbean WHERE bankid not in %@ AND tagid = 19 ORDER BY random() LIMIT 5",arr]];
    
    while ([res3 next]) {
        
        [arr addObject:[res3 stringForColumn:@"bankid"]];
    }
    
    
    FMResultSet *res4 = [_db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT bankid FROM classifyfristbean WHERE bankid not in %@ ORDER BY random() LIMIT %lu",arr , 100 - arr.count]];
    
    while ([res4 next]) {
        
        [arr addObject:[res4 stringForColumn:@"bankid"]];
    }
    
    [_db close];
    
    return  [NSArray arrayWithArray:arr];
}
@end
