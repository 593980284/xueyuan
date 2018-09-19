//
//  EDSFourSubjectExamBase.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/19.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFourSubjectExamBase.h"
#import <FMDB.h>

static EDSFourSubjectExamBase *_DBCtl = nil;
static FMDatabaseQueue *_queue = nil;

@interface EDSFourSubjectExamBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}
@end

@implementation EDSFourSubjectExamBase


+ (instancetype)sharedDataBase
{
    if (_DBCtl == nil) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"classify.db"];
        _DBCtl = [[EDSFourSubjectExamBase alloc] init];
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


- (NSArray *)getFourSubjectExam{
    
    [_db open];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM classifyfourbean WHERE tagid = 23 ORDER BY random() LIMIT 10"]];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    while ([res next]) {
        
        [arr addObject:[res stringForColumn:@"bankid"]];
    }
//    SELECT *FROM classifyfourbean WHERE tagid != 23 AND tagid != 24 ORDER BY random() LIMIT 30
    
    FMResultSet *res1 = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM classifyfourbean WHERE tagid != 23 AND tagid != 24 ORDER BY random() LIMIT 30"]];
    
    while ([res1 next]) {
        
        [arr addObject:[res1 stringForColumn:@"bankid"]];
    }
    
    FMResultSet *res2 = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM classifyfourbean WHERE tagid = 24 ORDER BY random() LIMIT 10"]];
    
    while ([res2 next]) {
        
        [arr addObject:[res2 stringForColumn:@"bankid"]];
    }
    
    [_db close];
    
    return  [NSArray arrayWithArray:arr];
}
@end
