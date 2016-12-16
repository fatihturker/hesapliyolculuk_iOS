//
//  Travel_Information.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 06.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "Travel_Information.h"

@implementation Travel_Information
@synthesize DepartureYear,DepartureMonth,Destination,Departure,DepartureDay,ReturnDay,ReturnMonth,ReturnYear,TripType;
-(id) init{
    self = [super init];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.DepartureDay forKey:@"DepartureDay"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if( self != nil ){
        //decode properties, other class vars
        self.DepartureDay= [decoder decodeObjectForKey:@"DepartureDay"];
    }
    return self;
}
@end
