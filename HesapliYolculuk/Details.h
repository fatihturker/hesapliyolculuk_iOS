//
//  Details.h
//  HesapliYolculuk
//
//  Created by Fatih Türker on 09.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
@interface Details : UIViewController <ADBannerViewDelegate>
-(IBAction) geriDon;
@property (weak,nonatomic) NSString *tPrice,*tCompanyName,*tDepartHour,*tArrivalHour,*tFlightNo,*tEstimatedTime,*tDate,*returnPageType,*tEstimatedTimeH;
@property (weak, nonatomic) IBOutlet UILabel *arrivalHourBaslik;
@property (weak, nonatomic) IBOutlet UILabel *ticketPrice;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *ticketDate;
@property (weak, nonatomic) IBOutlet UILabel *departHour;
@property (weak, nonatomic) IBOutlet UILabel *arrivalHour;
@property (weak, nonatomic) IBOutlet UILabel *flightNoOrEstimatedTimeBaslik;
@property (weak, nonatomic) IBOutlet UILabel *flightNoOrEstimatedTime;
@end
