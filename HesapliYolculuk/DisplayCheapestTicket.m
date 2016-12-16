//
//  DisplayCheapestTicket.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 06.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "DisplayCheapestTicket.h"
#import "InformationGathering.h"
#import "Details.h"
#import "Reachability.h"
#import "AllTickets.h"
@interface DisplayCheapestTicket ()

@end

@implementation DisplayCheapestTicket
@synthesize sDate,ticketPrice,ticketArrivalHour,ticketCompanyIcon,ticketCompanyName,ticketDepartHour,tickets,varisLabel,returningFromOtherPage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)displayOtherTickets{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tickets];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"ticketArray"]];
    
    AllTickets   *AT = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_AllTickets"];
    [self.navigationController pushViewController:AT animated:YES];
}
-(IBAction) geriDon{
    InformationGathering   *IG = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_InformationGathering"];
    [self.navigationController pushViewController:IG animated:YES];
}
-(IBAction)showDetails{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:tickets];
    [userDefault setObject:myEncodedObject forKey:[NSString stringWithFormat:@"ticketArray"]];
    
    Ticket *cheapestTicket = [tickets objectAtIndex:0];
    Details *Dets = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_Details"];
    Dets.tPrice = ticketPrice.text;
    Dets.tCompanyName = ticketCompanyName.text;
    Dets.tDepartHour = ticketDepartHour.text;
    Dets.tArrivalHour = ticketArrivalHour.text;
    Dets.tFlightNo = cheapestTicket.flightNo;
    Dets.tDate=cheapestTicket.ticketDate;
    Dets.tEstimatedTimeH=cheapestTicket.estimatedTravelTimeH;
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    BOOL isValid = [[cheapestTicket.estimatedTravelTimeH stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    
    if(![cheapestTicket.estimatedTravelTimeH isEqual:@"-"]&&isValid){
    Dets.tEstimatedTime = [NSString stringWithFormat:@"%@ saat %@ dakika",cheapestTicket.estimatedTravelTimeH,cheapestTicket.estimatedTravelTimeM];
    }
    Dets.returnPageType=@"DCT";
    [self.navigationController pushViewController:Dets animated:YES];
}

-(BOOL) InternetConnectionIsAvailable{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    }else{
        return YES;
    }
}
-(NSMutableArray*)ticketArray
{
    NSMutableArray* SV = [[NSUserDefaults standardUserDefaults] objectForKey:@"ticketArray"];
    return SV;
}
- (void)viewDidLoad
{
    if([returningFromOtherPage isEqual:@"YES"]){
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"ticketArray"]];
        NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
        tickets = [[NSMutableArray alloc] initWithArray:decodedArray];
        returningFromOtherPage = @"NO";
        NSLog(@"YEAH");
    }
    Ticket *cheapestTicket = [tickets objectAtIndex:0];
    if([InformationGathering isPlane]){
        if(cheapestTicket.vehicleID==2){
            ticketCompanyIcon.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"peg" ofType:@"png"]];
        }else if(cheapestTicket.vehicleID==1){
            ticketCompanyIcon.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"thy" ofType:@"png"]];
        }else if(cheapestTicket.vehicleID==4){
            ticketCompanyIcon.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"oaoa" ofType:@"png"]];
        }else if(cheapestTicket.vehicleID==5){
            ticketCompanyIcon.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"aj" ofType:@"png"]];
        }
        
        NSArray *CTDepartHour = [cheapestTicket.departHour componentsSeparatedByString:@":"];
        NSString *dptHour,*dptMin;
        
        NSScanner *scanner = [NSScanner scannerWithString:[CTDepartHour objectAtIndex:0]];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&dptHour];
        
        scanner = [NSScanner scannerWithString:[CTDepartHour objectAtIndex:1]];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&dptMin];
        
        ticketDepartHour.text = [NSString stringWithFormat:@"%@:%@",dptHour,dptMin];
        
        NSArray *CTArrivalHour = [cheapestTicket.arrivalHour componentsSeparatedByString:@":"];
        NSString *arvHour,*arvMin;
        
        scanner = [NSScanner scannerWithString:[CTArrivalHour objectAtIndex:0]];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&arvHour];
        
        scanner = [NSScanner scannerWithString:[CTArrivalHour objectAtIndex:1]];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&arvMin];
        
        ticketArrivalHour.text = [NSString stringWithFormat:@"%@:%@",arvHour,arvMin];
    }else if([InformationGathering isBus]){
        if(cheapestTicket.vehicleID==2){
            ticketCompanyIcon.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"anadolu" ofType:@"png"]];
        }else if(cheapestTicket.vehicleID==1){
            ticketCompanyIcon.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"nilufer" ofType:@"png"]];
        }else{
            ticketCompanyIcon.image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"resim" ofType:@"png"]];
        }
        NSArray *CTDepartHour = [cheapestTicket.departHour componentsSeparatedByString:@":"];
        NSString *dptHour,*dptMin;
        
        NSScanner *scanner = [NSScanner scannerWithString:[CTDepartHour objectAtIndex:0]];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&dptHour];
        
        scanner = [NSScanner scannerWithString:[CTDepartHour objectAtIndex:1]];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&dptMin];
        
        ticketDepartHour.text = [NSString stringWithFormat:@"%@:%@",dptHour,dptMin];
        
        varisLabel.text=@"";
        ticketArrivalHour.text=@"";
        
    }
    ticketCompanyName.text = cheapestTicket.companyName;
    ticketPrice.text = [NSString stringWithFormat:@"%.2f TL",cheapestTicket.ticketPrice];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTicketCompanyIcon:nil];
    [self setTicketCompanyName:nil];
    [self setTicketDepartHour:nil];
    [self setTicketArrivalHour:nil];
    [self setTicketPrice:nil];
    [self setVarisLabel:nil];
    [super viewDidUnload];
}
@end
