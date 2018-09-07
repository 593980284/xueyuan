//
//  EDSDataBase.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/7.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDataBase.h"
#import <FMDB.h>

#import "EDSQuestionModel.h"

static EDSDataBase *_DBCtl = nil;

@interface EDSDataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}
@end

@implementation EDSDataBase

+ (instancetype)sharedDataBase
{
    if (_DBCtl == nil) {
        
        _DBCtl = [[EDSDataBase alloc] init];
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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"db"];
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:path];
}


- (EDSQuestionModel *)getRandomSubjectFirst
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT *FROM onebankbean ORDER BY random() LIMIT 1"];
    while ([res next]) {
        
        questionModel.questionTitle = [res stringForColumn:@"title"];
        questionModel.questionPictureUrl = [res stringForColumn:@"id"];
        questionModel.isMultiple = YES;
        
        NSDictionary *listdict = [[res stringForColumn:@"options"] mj_JSONObject];
        NSMutableArray *answelists = [[NSMutableArray alloc] init];
        NSArray *arrayList = [listdict allValues];
        for (int i = 0 ; i < arrayList.count; i ++) {
            
            EDSAnswerModel *model = [[EDSAnswerModel alloc] init];
            model.answerR = [NSString stringWithFormat:@"%d",i];
            model.answerTitle = arrayList[i];
            [answelists addObject:model];
        }
        
        questionModel.answerlists = answelists;
        DLog(@"%@",questionModel.answerlists);
    }
    [_db close];
    
    return questionModel;
}


@end
