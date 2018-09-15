//
//  EDSFourDataBase.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFourDataBase.h"
#import <FMDB.h>

#import "EDSQuestionModel.h"

static EDSFourDataBase *_DBCtl = nil;
static FMDatabaseQueue *_queue = nil;

@interface EDSFourDataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
}
@end

@implementation EDSFourDataBase


+ (instancetype)sharedDataBase
{
    if (_DBCtl == nil) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"bank.db"];
        _DBCtl = [[EDSFourDataBase alloc] init];
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
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"bank.db"];
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:dbPath];
}


/** 科目四根据ID获取题目 */
- (EDSQuestionModel *)getFourSubjectQuestionWithID:(NSString *)ID
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    if (ID.length == 0) {
        
        ID = @"1326";
    }
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM fourbankbean WHERE id = %@ LIMIT 1",ID]];
    
    while ([res next]) {
        
        questionModel.questionTitle = [res stringForColumn:@"title"];
        questionModel.questionPictureUrl = [res stringForColumn:@"id"];
        questionModel.isMultiple = [[res stringForColumn:@"typeid"] isEqualToString:@"3"] ? NO : YES;
        questionModel.answer = [res stringForColumn:@"answer"];
        questionModel.ID = [res stringForColumn:@"id"];
        
        NSString *collection = [res stringForColumn:@"collection"];
        BOOL isCollection = [collection isEqualToString:@"1"] ? YES : NO;
        questionModel.isCollection = isCollection;
        
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
