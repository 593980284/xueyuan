//
//  UICustomDatePicker.m
//  LengBaoBao
//
//  Created by mac on 2017/6/25.
//  Copyright © 2017年 leng360. All rights reserved.
//

#import "UICustomDatePicker.h"

@interface UICustomDatePicker()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_dataArr;
    NSString *_selectString;
}

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView        *bottomView;

@property (nonatomic, copy  ) void(^dateBlock)(NSString *date);
@property (nonatomic, copy  ) void(^cancelBlock)();

@end

@implementation UICustomDatePicker

+ (void) showCustomDatePickerAtView:(UIView *)superView choosedDateBlock:(void (^)(NSString *date))date cancelBlock:(void(^)())cancel
{
    if ([superView viewWithTag:1887]) {
        [[superView viewWithTag:1887] removeFromSuperview];
    }
    UICustomDatePicker *picker = [[NSBundle mainBundle] loadNibNamed:@"UICustomDatePicker" owner:nil options:nil][0];
    picker.tag = 1887;
    [superView addSubview:picker];
    picker.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superView
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1.0
                                                        constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    if (date) {
        picker.dateBlock = date;
    }
    if (cancel) {
        picker.cancelBlock = cancel;
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //初始化的工作可以在这里完成
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _dataArr = @[@"上午",@"中午",@"下午"];
    _selectString = _dataArr[0];
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArr.count;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataArr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    _selectString = _dataArr[row];
}

- (IBAction)dismissBtnAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}
- (IBAction)confirmBtnAction:(id)sender {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *string = [fmt stringFromDate:self.datePicker.date];
    
    NSLog(@"%@---------%@",string,_selectString);
    if (self.dateBlock) {
        self.dateBlock([NSString stringWithFormat:@"%@ %@",string,_selectString]);
    }
    [self removeFromSuperview];
}

@end
