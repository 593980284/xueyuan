//
//  CRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "CRequest.h"
#import "CModel.h"
NSString *const CYPinyinGroupResultArray = @"CYPinyinGroupResultArray";
NSString *const CYPinyinGroupCharArray = @"CYPinyinGroupCharArray";
@implementation CRequest
- (NSString *)requestURLPath
{
    return @"/app/lexiang/complaint/findComplaintList";
}

- (NSDictionary *)requestArguments
{
    return @{@"phone": [EDSSave account].phone};
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSMutableArray  *list =[NSMutableArray new];
    NSMutableArray *alphabetArray  =[NSMutableArray new];
    if ([data valueForKey:@"topList"]) {
        NSArray<CModel *> *arr = [CModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"topList"]];
        [list addObject:arr];
        [alphabetArray addObject: @"热"];
    }
    
    if ([data valueForKey:@"schoolList"]) {
         NSArray<CModel *> *arr2 = [CModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"schoolList"]];
        NSDictionary *dcit= [self sortObjectsAccordingToInitialWith:arr2 SortKey:@"name"];
        NSArray * addressBookArray = dcit[CYPinyinGroupResultArray];//排好顺序Model数组
        [alphabetArray addObjectsFromArray:dcit[CYPinyinGroupCharArray]];//排好顺序的首字母数组
        [list addObjectsFromArray:addressBookArray];
    }
    
    if (self.successBlock) {
        
        self.successBlock(resCode, @{@"sectionList": alphabetArray}, list);
    }
}

#pragma mark - 字母排列
- (NSDictionary *)sortObjectsAccordingToInitialWith:(NSArray *)willSortArr SortKey:(NSString *)sortkey {
    
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //得出collation索引的数量
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //初始化空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    NSMutableArray *firstChar = [NSMutableArray arrayWithCapacity:10];
    
    //将每个名字分到某个section下
    for (id Model in willSortArr) {
        //获取name属性的值所在的位置
        NSInteger sectionNumber = [collation sectionForObject:Model collationStringSelector:NSSelectorFromString(sortkey)];
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:Model];
        
        //取出每名字的首字母
        NSString *str= collation.sectionTitles[sectionNumber];
        [firstChar addObject:str];
    }
    
    //返回首字母排好序的数据
    NSArray *firstCharResult = [self sortFirstChar:firstChar];
    
    //对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    //删除空的数组
    NSMutableArray *finalArr = [NSMutableArray new];
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        if (((NSMutableArray *)(newSectionsArray[index])).count != 0) {
            [finalArr addObject:newSectionsArray[index]];
        }
    }
    return @{CYPinyinGroupResultArray:finalArr,CYPinyinGroupCharArray:firstCharResult};
}

- (NSArray *)sortFirstChar:(NSArray *)firstChararry {
    //数组去重复
    NSMutableArray *noRepeat = [[NSMutableArray alloc]initWithCapacity:8];
    NSMutableSet *set = [[NSMutableSet alloc]initWithArray:firstChararry];
    [set enumerateObjectsUsingBlock:^(id obj , BOOL *stop){
        [noRepeat addObject:obj];
    }];
    //字母排序
    NSArray *resultkArrSort1 = [noRepeat sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //把”#“放在最后一位
    NSMutableArray *resultkArrSort2 = [[NSMutableArray alloc]initWithArray:resultkArrSort1];
    if ([resultkArrSort2 containsObject:@"#"]) {
        
        [resultkArrSort2 removeObject:@"#"];
        [resultkArrSort2 addObject:@"#"];
    }
    return resultkArrSort2;
}
@end
