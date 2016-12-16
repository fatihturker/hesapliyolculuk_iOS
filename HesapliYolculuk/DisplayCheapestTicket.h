//
//  DisplayCheapestTicket.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 06.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"
#import "Travel_Information.h"
#import <iAd/iAd.h>
@interface DisplayCheapestTicket : UIViewController <ADBannerViewDelegate>
@property (weak, nonatomic) NSString *returningFromOtherPage;
@property (weak, nonatomic) IBOutlet UILabel *ticketPrice;
@property (weak, nonatomic) IBOutlet UILabel *ticketArrivalHour;
@property (weak, nonatomic) IBOutlet UILabel *ticketDepartHour;
@property (weak, nonatomic) IBOutlet UILabel *ticketCompanyName;
@property (weak, nonatomic) IBOutlet UIImageView *ticketCompanyIcon;
@property (weak,nonatomic) NSString *sDate;
@property (weak, nonatomic) IBOutlet UILabel *varisLabel;
@property (retain,nonatomic) NSMutableArray *tickets;
-(IBAction) geriDon;
-(IBAction)showDetails;
-(IBAction)displayOtherTickets;
@end
