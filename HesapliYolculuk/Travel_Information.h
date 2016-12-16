//
//  Travel_Information.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Travel_Information : NSObject{
    NSString *Departure,
    *Destination,
    *DepartureDay,
    *DepartureMonth,
    *DepartureYear,
    *ReturnDay,
    *ReturnMonth,
    *ReturnYear,
    *TripType;
}

@property (retain,nonatomic)
NSString *Departure,
         *Destination,
         *DepartureDay,
         *DepartureMonth,
         *DepartureYear,
         *ReturnDay,
         *ReturnMonth,
         *ReturnYear,
         *TripType;

@end