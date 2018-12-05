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
static FMDatabaseQueue *_queue = nil;

@interface EDSDataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
}
@end

@implementation EDSDataBase

+ (instancetype)sharedDataBase
{
    if (_DBCtl == nil) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"bank.db"];
        _DBCtl = [[EDSDataBase alloc] init];
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
    
//    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString * documentsDirectory =[paths objectAtIndex:0];
//    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//    {
//        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//    }
//
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"bank.db"];
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:dbPath];
}


- (EDSQuestionModel *)getRandomSubjectFirst
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT *FROM onebankbean ORDER BY random() LIMIT 1"];
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



- (EDSQuestionModel *)getSubjectFirstQuestion
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    NSString *ID = [EDSSave account].firstSubjectID;
    NSInteger iD = ID.length > 0 ? [ID integerValue] : 1;
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM onebankbean WHERE id = %ld LIMIT 1",(long)iD]];
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

/** 获取科目一一共多少题 */
- (NSString *)getOneFirstSubjectCount
{
    [_db open];
    
    NSString *count = [NSString stringWithFormat:@"%d",[_db intForQuery:@"SELECT count(*) FROM onebankbean"]];
//    NSString *count = [NSString stringWithFormat:@"%d",[_db intForQuery:@"SELECT count(*) FROM onebankbean where errors = 1"]];
    
    [_db close];
    
    return count;
}



/** 根据id获取科目一题目 */
- (EDSQuestionModel *)getSubjectFirstQuestionWithID:(NSString *)ID
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM onebankbean WHERE id = %@ LIMIT 1",ID]];
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
            model.answerR = [NSString stringWithFormat:@"%c",i + 65];
            model.answerTitle = arrayList[i];
            [answelists addObject:model];
        }
        
        questionModel.answerlists = answelists;
        DLog(@"%@",questionModel.answerlists);
    }
    
    [_db close];
    
    return questionModel;
}

/** 错题数 */
- (NSString *)getOneFirstSubjectErrorCount
{
    
    [_db open];
    
    NSString *count = [NSString stringWithFormat:@"%d",[_db intForQuery:@"SELECT count(*) FROM onebankbean where errors = 1"]];
    
    [_db close];
    
    return count;
}

/** 添加错题 */
- (void)upDateFirstSubjectErrorsWithID:(NSString *)ID;
{
    [_db open];
    
    ID = ID.length > 0 ? ID : @"1";
    
    [_db executeUpdate:@"UPDATE onebankbean SET errors = 1 WHERE id = ?" values:@[ID] error:nil];
    
    [_db close];
}

/** 获取科目一错题题目 */
- (EDSQuestionModel *)getFirstSubjectErrorWithID:(NSString *)ID
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    NSInteger iD = ID.length > 0 ? [ID integerValue] : 0;
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM onebankbean WHERE errors = 1 AND id > %ld LIMIT 1",(long)iD]];
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

//收藏
- (BOOL)upDataFirstSubjectCollectionWithID:(NSString *)ID
{
    [_db open];
    
    ID = ID.length > 0 ? ID : @"1";
    
    BOOL res = [_db executeUpdate:@"UPDATE onebankbean SET collection = 1 WHERE id = ?" values:@[ID] error:nil];
    
    [_db close];
    if (res) {
        return  YES;
    }else{
        return  NO;
    }
}

//取消收藏
- (BOOL)upDataFirstSubjectunCollectionWithID:(NSString *)ID
{
    [_db open];
    
    ID = ID.length > 0 ? ID : @"1";
    
    BOOL res = [_db executeUpdate:@"UPDATE onebankbean SET collection = 0 WHERE id = ?" values:@[ID] error:nil];
    
    [_db close];
    
    if (res) {
        return  YES;
    }else{
        return  NO;
    }
}


/** 获取收藏数量 */
- (NSString *)getFirstSubjectCollectionCount
{
    [_db open];
    
    NSString *count = [NSString stringWithFormat:@"%d",[_db intForQuery:@"SELECT count(*) FROM onebankbean where collection = 1"]];
    
    [_db close];
    
    return count;
}

//获取科目一收藏题目
- (EDSQuestionModel *)getFirstSubjectCollectionWithID:(NSString *)ID
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    NSInteger iD = ID.length > 0 ? [ID integerValue] : 0;
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM onebankbean WHERE collection = 1 AND id > %ld LIMIT 1",(long)iD]];
    while ([res next]) {
        
        questionModel.questionTitle = [res stringForColumn:@"title"];
        questionModel.questionPictureUrl = [res stringForColumn:@"id"];
        questionModel.isMultiple = [[res stringForColumn:@"typeid"] isEqualToString:@"3"] ? NO : YES;
        questionModel.answer = [res stringForColumn:@"answer"];
        questionModel.ID = [res stringForColumn:@"id"];
        
        questionModel.isCollection = YES;
        
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


/** 背题 */
- (EDSQuestionModel *)getFirstSubjectRecitePolitcsWithID:(NSString *)ID
{
    [_db open];
    EDSQuestionModel *questionModel = [[EDSQuestionModel alloc] init];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM onebankbean WHERE id = %@ LIMIT 1",ID]];
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
            
            int index = [[NSString stringWithFormat:@"%ld",(long)i] intValue] ;
            index += 65;
            NSString *answeR = [NSString stringWithFormat:@"%c",index];
            
            if ([questionModel.answer isEqualToString:answeR]) {
                model.isChoose = YES;
                model.isCorrect = YES;
            }
            [answelists addObject:model];
        }
        
        questionModel.answerlists = answelists;
        DLog(@"%@",questionModel.answerlists);
    }
    
    [_db close];
    
    return questionModel;
}

/** 清除科目一所有错题 UPDATE onebankbean SET errors = 0 WHERE errors = 1*/
- (void)clearFirstSubjectAllWrongQuestions
{
    [_db open];
    
    [_db executeUpdate:@"UPDATE onebankbean SET errors = 0 WHERE errors = 1" values:@[] error:nil];
    
    [_db close];
}

@end
