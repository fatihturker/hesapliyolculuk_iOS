//
//  Details.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 09.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "Details.h"
#import "DisplayCheapestTicket.h"
#import "InformationGathering.h"
#import "AllTickets.h"
@interface Details ()

@end

@implementation Details
@synthesize ticketDate,ticketPrice,arrivalHour,departHour,flightNoOrEstimatedTime,flightNoOrEstimatedTimeBaslik,companyName,arrivalHourBaslik,tPrice,tCompanyName,tDepartHour,tArrivalHour,tFlightNo,tEstimatedTime,tDate,returnPageType,tEstimatedTimeH;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction) geriDon{
    if([returnPageType isEqual:@"DCT"]){
        DisplayCheapestTicket *DCT = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_DisplayCheapestTicket"];
        DCT.returningFromOtherPage = @"YES";
        [self.navigationController pushViewController:DCT animated:YES];
    }else if([returnPageType isEqual:@"AT"]){
        AllTickets   *AT = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_AllTickets"];
        [self.navigationController pushViewController:AT animated:YES];
    }
}

- (void)viewDidLoad
{
    companyName.text = tCompanyName;
    ticketPrice.text = tPrice;
    departHour.text = tDepartHour;
    ticketDate.text=tDate;
    if([InformationGathering isBus]){
        NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
        BOOL isValid = [[tEstimatedTimeH stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
        if(![tEstimatedTimeH isEqual:@"-"]&&isValid){
            arrivalHour.text=tArrivalHour;
        }else{
            arrivalHour.text=@"";
            arrivalHourBaslik.text=@"";
        }
    }else{
        arrivalHour.text=tArrivalHour;
    }
    
    if(tFlightNo!=nil){
        flightNoOrEstimatedTime.text=tFlightNo;
        flightNoOrEstimatedTimeBaslik.text = @"Uçuş Numarası: ";
    }else if(tEstimatedTime!=nil){
        flightNoOrEstimatedTime.text=tEstimatedTime;
        flightNoOrEstimatedTimeBaslik.text = @"Tahmini Yolculuk Süresi: ";
    }else{
        flightNoOrEstimatedTime.text = @"";
        flightNoOrEstimatedTimeBaslik.text = @"";
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTicketPrice:nil];
    [self setCompanyName:nil];
    [self setTicketDate:nil];
    [self setDepartHour:nil];
    [self setArrivalHour:nil];
    [self setFlightNoOrEstimatedTimeBaslik:nil];
    [self setFlightNoOrEstimatedTime:nil];
    [self setArrivalHourBaslik:nil];
    [super viewDidUnload];
}
@end
