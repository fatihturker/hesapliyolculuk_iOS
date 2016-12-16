//
//  AllTickets.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 10.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
@interface AllTickets : UIViewController<UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>{
    NSMutableArray *tickets;
    UIImage *ticketCompanyIcon;
    NSString *ticketDepartHour,*ticketArrivalHour,*ticketArrivalHourBaslik,*ticketCompanyName,*ticketPrice;
    NSMutableArray *tmpTicketArray;
}
@property (retain,nonatomic) NSMutableArray *tickets,*tmpTicketArray;
@property (retain,nonatomic) UIImage *ticketCompanyIcon;
@property (retain,nonatomic) NSString *ticketDepartHour,*ticketArrivalHour,*ticketArrivalHourBaslik,*ticketCompanyName,*ticketPrice;

-(IBAction) geriDon;
@end
