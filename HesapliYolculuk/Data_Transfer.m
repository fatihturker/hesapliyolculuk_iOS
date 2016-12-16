//
//  Data_Transfer.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "Data_Transfer.h"
#import "InformationGathering.h"
@implementation Data_Transfer
static NSMutableArray* responseString;
static NSMutableArray* tickets;
+(NSString*) GetTicketsFromService: (Travel_Information*) userTravelInfo URLString: (NSString*) Uri{
    NSString *post = [NSString stringWithFormat:@"&dep=%@&dest=%@&day=%@&month=%@&year=%@",userTravelInfo.Departure,userTravelInfo.Destination,userTravelInfo.DepartureDay,userTravelInfo.DepartureMonth,userTravelInfo.DepartureYear];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:Uri]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseS = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
   // NSLog(@"%@",responseS);
    return responseS;
}

+(NSString*) GetNiluferTicketsFromService: (Travel_Information*) userTravelInfo{
    NSString *uri = @"http://bettipsapp.com/WebService/Bus/niluferIOS.php";
    NSString* niluferString = [Data_Transfer GetTicketsFromService:userTravelInfo URLString:uri];
    return niluferString;
}

+(NSString*) GetAnadoluTicketsFromService: (Travel_Information*) userTravelInfo{
    NSString *uri = @"http://bettipsapp.com/WebService/Bus/anadoluIOS.php";
    NSString* anadoluString = [Data_Transfer GetTicketsFromService:userTravelInfo URLString:uri];
    return anadoluString;
}
+(NSString*) GetKamilKocTicketsFromService: (Travel_Information*) userTravelInfo{
    NSString *uri = @"http://bettipsapp.com/WebService/Bus/kamilkocIOS.php";
    NSString* kamilkocString = [Data_Transfer GetTicketsFromService:userTravelInfo URLString:uri];
    return kamilkocString;
}
+(NSString*) GetTHYTicketsFromService: (Travel_Information*) userTravelInfo{
    NSString *uri = @"http://bettipsapp.com/WebService/Plane/thyIOS.php";
    NSString* thyString = [Data_Transfer GetTicketsFromService:userTravelInfo URLString:uri];
    return thyString;
}
+(NSString*) GetOATicketsFromService: (Travel_Information*) userTravelInfo{
    NSString *uri = @"http://bettipsapp.com/WebService/Plane/onurairIOS.php";
    NSString* oaString = [Data_Transfer GetTicketsFromService:userTravelInfo URLString:uri];
    return oaString;
}
+(NSString*) GetPEGTicketsFromService: (Travel_Information*) userTravelInfo{
    NSString *uri = @"http://bettipsapp.com/WebService/Plane/pegasusIOS.php";
    NSString* pegString = [Data_Transfer GetTicketsFromService:userTravelInfo URLString:uri];
    return pegString;
}
+(NSMutableArray*) postValuesToService: (Travel_Information*) userTravelInfo selectedVehicle: (Vehicle*) vec{
    responseString=[[NSMutableArray alloc] init];
    if([InformationGathering isBus]){
        NSString* niluferTickets = [Data_Transfer GetNiluferTicketsFromService:userTravelInfo];
        NSString* anadoluTickets = [Data_Transfer GetAnadoluTicketsFromService:userTravelInfo];
        NSString* kamilkocTickets = [Data_Transfer GetKamilKocTicketsFromService:userTravelInfo];
        NSLog(@"%@",anadoluTickets);
        [responseString addObject:niluferTickets];
        [responseString addObject:anadoluTickets];
        [responseString addObject:kamilkocTickets];
        return responseString;
    }else{
        NSString* thyTickets = [Data_Transfer GetTHYTicketsFromService:userTravelInfo];
        NSString* oaTickets = [Data_Transfer GetOATicketsFromService:userTravelInfo];
        NSString* pegTickets = [Data_Transfer GetPEGTicketsFromService:userTravelInfo];
      //  NSLog(@"%@",pegTickets);
        [responseString addObject:thyTickets];
        [responseString addObject:oaTickets];
        [responseString addObject:pegTickets];
        return responseString;
    }
}
+(void) parseResponseString: (NSString*)response{
    
    NSError *error;
    NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
	SMXMLDocument *document = [SMXMLDocument documentWithData:data error:&error];
    
    // check for errors
    if (error) {
        NSLog(@"Error while parsing the document: %@", error);
        return;
    }
    
	//NSLog(@"\nOur Document:\n %@", document);
    
	Ticket *ticketInfo;
    
    if([InformationGathering isBus]){
        for (SMXMLElement *m in [document.root childrenNamed:@"sefer"]){
            ticketInfo = [[Ticket alloc] init];
            
            NSString *sefersaati = [m valueWithPath:@"sefersaati"];
            ticketInfo.departHour = sefersaati;
            
            NSString *vehID = [m valueWithPath:@"id"];
            ticketInfo.vehicleID = [vehID integerValue];
            
            NSString *normalFiyat = [m valueWithPath:@"normalfiyat"];
            NSArray *ticketP = [normalFiyat componentsSeparatedByString:@" "];
            ticketInfo.ticketPrice = [[ticketP objectAtIndex:0] integerValue];
            
            if([vehID integerValue]==1){
                ticketInfo.companyName=@"Nilüfer Turizm";
            }else if([vehID integerValue]==2){
                ticketInfo.companyName=@"Anadolu Turizm";
            }else{
                ticketInfo.companyName=@"Kamil Koç";
            }
            
            [tickets addObject:ticketInfo];
        }
    }else if([InformationGathering isPlane]){
        for (SMXMLElement *m in [document.root childrenNamed:@"sefer"]){
            ticketInfo = [[Ticket alloc] init];
            
            NSString *kalkissaati = [m valueWithPath:@"kalkis"];
            ticketInfo.departHour = kalkissaati;
            
            NSString *vehID = [m valueWithPath:@"id"];
            ticketInfo.vehicleID = [vehID integerValue];
            
            NSString *varissaati = [m valueWithPath:@"varis"];
            ticketInfo.arrivalHour = varissaati;
            
            NSString *ucusNo = [m valueWithPath:@"ucusno"];
            ticketInfo.flightNo=ucusNo;
            
            NSString *normalFiyat = [m valueWithPath:@"ekonomifiyat"];
           
            
            NSScanner *scanner = [NSScanner scannerWithString:normalFiyat];
            NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
            
            // Throw away characters before the first number.
            [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
            
            // Collect numbers.
            [scanner scanCharactersFromSet:numbers intoString:&normalFiyat];
            
            // Result.
             ticketInfo.ticketPrice = [normalFiyat floatValue];
             NSLog(@"%.2f",ticketInfo.ticketPrice);
        
            if([vehID integerValue]==1){
                ticketInfo.companyName=@"Türk Hava Yolları";
            }else if([vehID integerValue]==2){
                ticketInfo.companyName=@"Pegasus";
            }else if([vehID integerValue]==4){
                ticketInfo.companyName=@"Onur Air";
            }else{
                 ticketInfo.companyName=@"Anadolu Jet";
            }
            
            [tickets addObject:ticketInfo];
        }
    }
}
+(NSMutableArray*) FillTicketInformations: (NSMutableArray*) serverResponseString{
    tickets = [[NSMutableArray alloc] init];
    for (int i=0; i<[serverResponseString count];i++){
        [Data_Transfer parseResponseString:[serverResponseString objectAtIndex:i]];
    }
    return tickets;
}
+(NSMutableArray*) SortTicketsByPrice: (NSMutableArray*) sTickets{
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"ticketPrice" ascending:YES selector:@selector(compare:)];
    [sTickets sortUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
    return sTickets;
}
@end
