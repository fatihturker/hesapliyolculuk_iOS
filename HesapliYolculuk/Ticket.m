//
//  Ticket.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 06.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
@synthesize companyName,departHour,arrivalHour,estimatedTravelTimeM,estimatedTravelTimeH,ticketDate,reducedTicketPrice,businessPrice,flightNo,ticketPrice,vehicleID;
-(id) init{
    self = [super init];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.companyName forKey:@"companyName"];
    [encoder encodeObject:self.departHour forKey:@"departHour"];
    [encoder encodeObject:self.arrivalHour forKey:@"arrivalHour"];
    [encoder encodeObject:self.estimatedTravelTimeH forKey:@"estimatedTravelTimeH"];
    [encoder encodeObject:self.estimatedTravelTimeM forKey:@"estimatedTravelTimeM"];
    [encoder encodeObject:self.ticketDate forKey:@"ticketDate"];
    [encoder encodeObject:self.flightNo forKey:@"flightNo"];
    [encoder encodeObject:self.businessPrice forKey:@"businessPrice"];
    [encoder encodeObject:self.reducedTicketPrice forKey:@"reducedTicketPrice"];
    [encoder encodeObject:[NSNumber numberWithFloat:self.ticketPrice] forKey:@"ticketPrice"];
    [encoder encodeObject:[NSNumber numberWithInt:self.vehicleID] forKey:@"vehicleID"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if( self != nil ){
        //decode properties, other class vars
        self.companyName = [decoder decodeObjectForKey:@"companyName"];
        self.departHour = [decoder decodeObjectForKey:@"departHour"];
        self.arrivalHour = [decoder decodeObjectForKey:@"arrivalHour"];
        self.estimatedTravelTimeH = [decoder decodeObjectForKey:@"estimatedTravelTimeH"];
        self.estimatedTravelTimeM = [decoder decodeObjectForKey:@"estimatedTravelTimeM"];
        self.ticketDate = [decoder decodeObjectForKey:@"ticketDate"];
        self.flightNo = [decoder decodeObjectForKey:@"flightNo"];
        self.businessPrice = [decoder decodeObjectForKey:@"businessPrice"];
        self.reducedTicketPrice = [decoder decodeObjectForKey:@"reducedTicketPrice"];
        self.ticketPrice = [[decoder decodeObjectForKey:@"ticketPrice"] floatValue];
        self.vehicleID = [[decoder decodeObjectForKey:@"vehicleID"] integerValue];
    }
    return self;
}

@end
