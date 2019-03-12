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

/** 获取科目四一共多少题 */
- (NSString *)getOneFourSubjectCount
{
    [_db open];
    
    NSString *count = [NSString stringWithFormat:@"%d",[_db intForQuery:@"SELECT count(*) FROM fourbankbean"]];
    
    [_db close];
    
    return count;
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
        NSArray *arrayList = [listdict xx_allValues];
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

/** 添加科目四错题 */
- (void)upDateFourSubjectErrorsWithID:(NSString *)ID{
    
    [_db open];
    
    ID = ID.length > 0 ? ID : @"1";
    
    [_db executeUpdate:@"UPDATE fourbankbean SET errors = 1 WHERE id = ?" values:@[ID] error:nil];
    
    [_db close];
}


/** 错题数 */
- (NSString *)getOneFourSubjectErrorCount{
    
    [_db open];
    
    NSString *count = [NSString stringWithFormat:@"%d",[_db intForQuery:@"SELECT count(*) FROM fourbankbean where errors = 1"]];
    
    [_db close];
    
    return count;
}


/** 获取科目四错题题目 */
- (EDSQuestionModel *)getFourSubjectErrorWithID:(NSString *)ID
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    NSInteger iD = ID.length > 0 ? [ID integerValue] : 0;
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM fourbankbean WHERE errors = 1 AND id > %ld LIMIT 1",(long)iD]];
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
        NSArray *arrayList = [listdict xx_allValues];
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

/** 清除科目四所有错题 */
- (void)clearFourSubjectAllWrongQuestions
{
    
    [_db open];
    
    [_db executeUpdate:@"UPDATE fourbankbean SET errors = 0 WHERE errors = 1" values:@[] error:nil];
    
    [_db close];
}


/** 获取收藏数量 */
- (NSString *)getFourSubjectCollectionCount
{
    [_db open];
    
    NSString *count = [NSString stringWithFormat:@"%d",[_db intForQuery:@"SELECT count(*) FROM fourbankbean where collection = 1"]];
    
    [_db close];
    
    return count;
}


/** 收藏 */
- (BOOL)upDataFourSubjectCollectionWithID:(NSString *)ID
{
    [_db open];
    
    ID = ID.length > 0 ? ID : @"1";
    
    BOOL res =  [_db executeUpdate:@"UPDATE fourbankbean SET collection = 1 WHERE id = ?" values:@[ID] error:nil];
    
    [_db close];
    
    return res ? YES : NO;
}

/** 取消收藏 */
- (BOOL)upDataFourSubjectunCollectionWithID:(NSString *)ID
{
    [_db open];
    
    ID = ID.length > 0 ? ID : @"1";
    
    BOOL res =  [_db executeUpdate:@"UPDATE fourbankbean SET collection = 0 WHERE id = ?" values:@[ID] error:nil];
    
    [_db close];
    
    return res ? YES : NO;
}


/** 获取科目四收藏题目 */
- (EDSQuestionModel *)getFourSubjectCollectionWithID:(NSString *)ID
{
    [_db open];
    
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    NSInteger iD = ID.length > 0 ? [ID integerValue] : 0;
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM fourbankbean WHERE collection = 1 AND id > %ld LIMIT 1",(long)iD]];
    while ([res next]) {
        
        questionModel.questionTitle = [res stringForColumn:@"title"];
        questionModel.questionPictureUrl = [res stringForColumn:@"id"];
        questionModel.isMultiple = [[res stringForColumn:@"typeid"] isEqualToString:@"3"] ? NO : YES;
        questionModel.answer = [res stringForColumn:@"answer"];
        questionModel.ID = [res stringForColumn:@"id"];
        
        questionModel.isCollection = YES;
        
        NSDictionary *listdict = [[res stringForColumn:@"options"] mj_JSONObject];
        NSMutableArray *answelists = [[NSMutableArray alloc] init];
        NSArray *arrayList = [listdict xx_allValues];
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
