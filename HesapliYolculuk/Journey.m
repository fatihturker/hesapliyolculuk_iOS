//
//  Journey.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 06.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "Journey.h"

@implementation Journey

-(id) initWithDeparture: (NSString*) dep wDestination:(NSString*) dest wETH:(NSString*) eth wETM:(NSString*) etm{
    self = [super init];
    if(self){
        self.Departure=dep;
        self.Destination=dest;
        self.EstimatedTimeHour=eth;
        self.EstimatedTimeMinute=etm;
    }
    return self;
}

@end