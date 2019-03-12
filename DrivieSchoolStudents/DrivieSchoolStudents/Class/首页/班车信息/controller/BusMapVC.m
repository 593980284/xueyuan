//
//  BusMapVC.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/2/28.
//  Copyright © 2019年 班文政. All rights reserved.
//

#import "BusMapVC.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import "CarLocationRequest.h"
@interface BusMapVC ()<BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) NSMutableArray <BMKPointAnnotation*> *annotations;
@property (nonatomic, strong) NSArray <CarLocationModel *>* lastarr;
@property (nonatomic, strong) NSArray <CarLocationModel *>* arr;

@end

@implementation BusMapVC
{
    NSTimer *timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.annotations = [NSMutableArray new];
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.zoomLevel = 8;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    self.title = @"班车地图";
    [self getRequest];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [timer invalidate];
    timer = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self getRequest];
    }];
    
//          __block  CGFloat i = 0;
//          timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//                i = i + 0.001;
//               NSMutableArray *arr = [NSMutableArray new];
//              CarLocationModel *model = [CarLocationModel new];
//              model.longitude = 116.404 + i;
//              model.latitude = 39.925;
//              model.carNo=@"1111";
//              CarLocationModel *model2 = [CarLocationModel new];
//              model2.longitude = 116.404 + i;
//              model2.latitude = 39.950;
//              model2.carNo=@"2222";
//              model2.direction = M_PI_2;
//               [arr addObject:model];
//               [arr addObject:model2];
//                self.arr = arr;
//            }];
}

- (void)getRequest
{
    CarLocationRequest * request = [CarLocationRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict,   NSArray <CarLocationModel *>* model) {
        self.arr = model;
    } failureBlock:^(NSError *error) {
        
    }];
    request.busId = self.busId;
    [request startRequest];
}
- (void)setArr:(NSArray<CarLocationModel *> *)arr
{
    
    _arr = arr;
    if (arr.count > 0) {
        int count = arr.count;
        [_mapView removeAnnotations:self.annotations];
        [self.annotations removeAllObjects];
        for (int i = 0; i < count ; i++) {
            CLLocationCoordinate2D coords[2] = {0};
            int j = 0;
            if (self.lastarr && i<self.lastarr.count) {
                coords[j].latitude = self.lastarr[i].latitude;
                coords[j].longitude = self.lastarr[i].longitude;
                j++;
            }
            coords[j].latitude = arr[i].latitude;
            coords[j].longitude = arr[i].longitude;
            BMKPolyline* polyLine = [BMKPolyline polylineWithCoordinates:coords count:j+1];
            [_mapView addOverlay:polyLine];
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = coords[j];
            //设置标注的标题
            annotation.title = @"公交车";
            annotation.subtitle = arr[i].carNo;
            [self.annotations addObject:annotation];
             [_mapView addAnnotation:annotation];
        }
        self.lastarr = arr;
    }
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
}

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.lineWidth = 5;
        /// 使用分段颜色绘制时，必须设置（内容必须为UIColor）
        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"road_blue_arrow"]];
        return polylineView;
    }
    
    return nil;
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:reuseIndetifier];
            UIImageView * imgView = [UIImageView new];
            imgView.tag = 100;
            imgView.image = [UIImage imageNamed:@"ic-bs"];
            [annotationView addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.mas_equalTo(0);
            }];
           
            
        }
        if (self.arr.count > 0 && [_annotations containsObject:annotation]) {
            UIImageView * imgView = ( UIImageView * )[annotationView viewWithTag:100];
            NSInteger index =  [_annotations indexOfObject:annotation];
            imgView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, self.arr[index].direction);
        }
        annotationView.image = [UIImage imageNamed:@"ic-bs-b"];
        return annotationView;
    }
    return nil;
}
@end
