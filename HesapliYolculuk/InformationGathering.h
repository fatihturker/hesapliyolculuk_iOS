//
//  InformationGathering.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data_Transfer.h"

@interface InformationGathering : UIViewController 
@property (retain,nonatomic) Vehicle *selectedVehicle;
@property (weak, nonatomic) IBOutlet UILabel *neredenLabel;
@property (weak, nonatomic) IBOutlet UILabel *nereyeLabel;
@property (weak, nonatomic) IBOutlet UIView *spinnerView;
@property (weak, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (weak, nonatomic) IBOutlet UINavigationBar *spinnerMenu;
@property (weak, nonatomic) IBOutlet UIButton *biletAraButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *tarihLabel;
@property (retain,nonatomic) UIAlertView *alert;
-(IBAction) biletAra;
-(IBAction) tarihSec;
-(IBAction) activateNeredenSpinner;
-(IBAction) activateNereyeSpinner;
-(IBAction) passiveSpinner;
-(IBAction) SelectFromSpinner;

+(BOOL) isBus;
+(BOOL) isPlane;
@end
