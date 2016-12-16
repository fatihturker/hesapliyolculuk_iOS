//
//  Vehicle.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle
NSString *vehicleType;

-(NSString *) getType{
    return vehicleType;
}
-(void) setType: (NSString *) vt{
    vehicleType = vt;
}
@end
