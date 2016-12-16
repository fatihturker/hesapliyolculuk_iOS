//
//  Ticket.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject{
    NSString *companyName,
    *departHour,
    *arrivalHour,
    *reducedTicketPrice,
    *businessPrice,
    *estimatedTravelTimeH,
    *estimatedTravelTimeM,
    *flightNo,
    *ticketDate;
    
    int vehicleID;
    float ticketPrice;
}

@property (assign)
int vehicleID;
@property (assign)
float ticketPrice;

@property (retain,nonatomic)
NSString *companyName,
*departHour,
*arrivalHour,
*reducedTicketPrice,
*businessPrice,
*estimatedTravelTimeH,
*estimatedTravelTimeM,
*flightNo,
*ticketDate;


@end
