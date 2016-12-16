//
//  Journey.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Journey : NSObject

@property (weak,nonatomic)
NSString *Departure,
         *Destination,
         *EstimatedTimeHour,
         *EstimatedTimeMinute;
-(id) initWithDeparture: (NSString*) dep wDestination:(NSString*) dest wETH:(NSString*) eth wETM:(NSString*) etm;
@end
