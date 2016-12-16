//
//  VehicleSelect.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"
@interface VehicleSelect : UIViewController
@property (retain,nonatomic) Vehicle *selectedVehicle;
-(IBAction) selectBus;
-(IBAction) selectPlane;

@end
