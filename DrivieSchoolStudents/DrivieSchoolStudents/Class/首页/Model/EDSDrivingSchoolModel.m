//
//  EDSDrivingSchoolModel.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingSchoolModel.h"
#import <CoreLocation/CoreLocation.h>

@implementation EDSDrivingSchoolModel

- (NSString *)schoolPhoto
{
    return [LINEURL stringByAppendingPathComponent:_schoolPhoto];
}

- (NSAttributedString *)showSchoolPrice
{
    NSString *string = _schoolPrice.length > 0 ? @"￥" : @" ";
    _showSchoolPrice = [NSString attributedStringWithColorTitle:_schoolPrice normalTitle:@"" frontTitle:string normalColor:[EDSToolClass getColorWithHexString:@"#FF571D"] diffentColor:[EDSToolClass getColorWithHexString:@"#FF571D"] normalFont:kFont(14) differentFont:kFont(18)];
    return _showSchoolPrice;
}

- (double)lat
{
    NSArray *arr = [_lngLat componentsSeparatedByString:@","];
    return [arr[1] doubleValue];
}


- (double)lng
{
    NSArray *arr = [_lngLat componentsSeparatedByString:@","];
    return [arr[0] doubleValue];
}

- (NSInteger)showScore
{
    return ceil([_starScore integerValue]);
}

- (BOOL)isUnionShow
{
    if ([[NSString stringWithFormat:@"%@",_isUnion] isEqualToString:@"1"]) {
        
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)distance
{
    NSArray *arr = [_lngLat componentsSeparatedByString:@","];
    
    NSDictionary *dict = [UserDefault objectForKey:KuserDefaultsLocation];
    
    double localLng = [dict[@"lng"] doubleValue];
    double localLat = [dict[@"lat"] doubleValue];
    
    double distanceD = [self LantitudeLongitudeDist:localLng other_Lat:localLat self_Lon:[arr[0] doubleValue] self_Lat:[arr[1] doubleValue]];
    
//    double distanceD2 = [self distanceBetweenOrderBy:[EDSSave account].localLat :[arr[1] doubleValue] :[EDSSave account].localLng :[arr[0] doubleValue]];
    
    distanceD = distanceD/1000;
    
    return [NSString stringWithFormat:@"%.0fkm",distanceD];
}

#pragma mark - calculate distance  根据2个经纬度计算距离

-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    
    double  distance  = [curLocation distanceFromLocation:otherLocation];
    
    return  distance;
    
}

#define PI 3.1415926
- (double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist;
}

@end
