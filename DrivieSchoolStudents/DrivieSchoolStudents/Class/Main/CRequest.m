//
//  CRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "CRequest.h"
#import "CModel.h"

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
    if ([data valueForKey:@"topList"]) {
        NSArray<CModel *> *arr = [CModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"topList"]];
        [list addObject:arr];
    }
    
    if ([data valueForKey:@"schoolList"]) {
         NSArray<CModel *> *arr2 = [CModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"schoolList"]];
        [list addObject:arr2];
    }
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, list);
    }
}
@end
