//
//  Data_Transfer.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Travel_Information.h"
#import "Vehicle.h"
#import "SMXMLDocument.h"
#import "Ticket.h"
#import "Journey.h"
@interface Data_Transfer : NSObject
+(NSString*) GetTicketsFromService: (Travel_Information*) userTravelInfo URLString: (NSString*) Uri;
+(NSString*) GetNiluferTicketsFromService: (Travel_Information*) userTravelInfo;
+(NSString*) GetAnadoluTicketsFromService: (Travel_Information*) userTravelInfo;
+(NSString*) GetKamilKocTicketsFromService: (Travel_Information*) userTravelInfo;
+(NSString*) GetTHYTicketsFromService: (Travel_Information*) userTravelInfo;
+(NSString*) GetOATicketsFromService: (Travel_Information*) userTravelInfo;
+(NSMutableArray*) postValuesToService: (Travel_Information*) userTravelInfo selectedVehicle: (Vehicle*) vec;
+(void) parseResponseString: (NSString*)response;
+(NSMutableArray*) FillTicketInformations: (NSMutableArray*) serverResponseString;
+(NSMutableArray*) SortTicketsByPrice: (NSMutableArray*) sTickets;
@end
