//
//  EDSDataPickerView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDataPickerView.h"

@interface EDSDataPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *_selectString;
    NSArray *_dataArr;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPickView;

@end

@implementation EDSDataPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSDataPickerView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)awakeFromNib
{
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

- (IBAction)cancleClick:(id)sender {
    
    [self removeFromSuperview];
}
- (IBAction)submitClick:(id)sender {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *string = [fmt stringFromDate:self.dataPickView.date];
    
    if (self.dataPickerViewBackString) {
        
        self.dataPickerViewBackString([NSString stringWithFormat:@"%@ %@",string,_selectString]);
    }
    [self removeFromSuperview];
}

@end
