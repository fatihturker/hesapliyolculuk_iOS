//
//  AllTickets.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 10.03.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "AllTickets.h"
#import "Ticket.h"
#import "InformationGathering.h"
#import "DisplayCheapestTicket.h"
#import "Details.h"
@interface AllTickets ()

@end

@implementation AllTickets
@synthesize tickets,ticketCompanyIcon,ticketDepartHour,ticketArrivalHour,ticketArrivalHourBaslik,ticketCompanyName,ticketPrice,tmpTicketArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) geriDon{
    DisplayCheapestTicket *DCT = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_DisplayCheapestTicket"];
    DCT.returningFromOtherPage = @"YES";
    [self.navigationController pushViewController:DCT animated:YES];
}
- (void)viewDidLoad
{
    tmpTicketArray=[[NSMutableArray alloc] init];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey: [NSString stringWithFormat:@"ticketArray"]];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    tickets = [[NSMutableArray alloc] initWithArray:decodedArray];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tickets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ticketCell";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lstv.png"]]];
    
    Ticket *tTicket = [tickets objectAtIndex:indexPath.row];
    if([InformationGathering isPlane]){
        if(tTicket.vehicleID==2){
            ticketCompanyIcon = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"peg" ofType:@"png"]];
        }else if(tTicket.vehicleID==1){
            ticketCompanyIcon = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"thy" ofType:@"png"]];
        }else if(tTicket.vehicleID==4){
            ticketCompanyIcon = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"oaoa" ofType:@"png"]];
        }else if(tTicket.vehicleID==5){
            ticketCompanyIcon = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"aj" ofType:@"png"]];
        }
        
        NSArray *CTDepartHour = [tTicket.departHour componentsSeparatedByString:@":"];
        NSString *dptHour,*dptMin;
        
        NSScanner *scanner = [NSScanner scannerWithString:[CTDepartHour objectAtIndex:0]];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&dptHour];
        
        scanner = [NSScanner scannerWithString:[CTDepartHour objectAtIndex:1]];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&dptMin];
        
        ticketDepartHour = [NSString stringWithFormat:@"%@:%@",dptHour,dptMin];
        
        NSArray *CTArrivalHour = [tTicket.arrivalHour componentsSeparatedByString:@":"];
        NSString *arvHour,*arvMin;
        
        scanner = [NSScanner scannerWithString:[CTArrivalHour objectAtIndex:0]];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&arvHour];
        
        scanner = [NSScanner scannerWithString:[CTArrivalHour objectAtIndex:1]];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&arvMin];
        
        ticketArrivalHour = [NSString stringWithFormat:@"%@:%@",arvHour,arvMin];
    }else if([InformationGathering isBus]){
        if(tTicket.vehicleID==2){
            ticketCompanyIcon = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"anadolu" ofType:@"png"]];
        }else if(tTicket.vehicleID==1){
            ticketCompanyIcon = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"nilufer" ofType:@"png"]];
        }else{
            ticketCompanyIcon = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"resim" ofType:@"png"]];
        }
        NSArray *CTDepartHour = [tTicket.departHour componentsSeparatedByString:@":"];
        NSString *dptHour,*dptMin;
        
        NSScanner *scanner = [NSScanner scannerWithString:[CTDepartHour objectAtIndex:0]];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&dptHour];
        
        scanner = [NSScanner scannerWithString:[CTDepartHour objectAtIndex:1]];
        
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        [scanner scanCharactersFromSet:numbers intoString:&dptMin];
        
        ticketDepartHour = [NSString stringWithFormat:@"%@:%@",dptHour,dptMin];
        
       
        ticketArrivalHourBaslik=@"";
        ticketArrivalHour=@"";
        
    }
    ticketCompanyName = tTicket.companyName;
    ticketPrice = [NSString stringWithFormat:@"%.2f TL",tTicket.ticketPrice];
    
    UIImage *image=ticketCompanyIcon;
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [buyButton setBackgroundImage:image forState:UIControlStateNormal];
    image =  [UIImage imageWithCGImage:image.CGImage scale:2.0 orientation:image.imageOrientation];
    buyButton.frame = CGRectMake(10,15, image.size.width, image.size.height);
    buyButton.enabled=NO;
    [cell.contentView addSubview:buyButton];
    
    
   
    UIFont *detailFont = [UIFont fontWithName:@"Verdana-Bold" size:14.0];
    UIFont *detailFontPrice = [UIFont fontWithName:@"Verdana-Bold" size:13.0];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(115, 5, 179, 21)];
    label.text = ticketCompanyName;
    label.font = detailFont;
    [cell.contentView addSubview:label];
     
    UIFont *detailFont2 = [UIFont fontWithName:@"Verdana" size:12.0];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(115, 29, 91, 20)];
    label2.text = [NSString stringWithFormat:@"Kalkış: %@",ticketDepartHour];
    label2.font = detailFont2;
    [cell.contentView addSubview:label2];
    if([InformationGathering isBus]){
        NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
        BOOL isValid = [[tTicket.estimatedTravelTimeH stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
        if(![tTicket.estimatedTravelTimeH isEqual:@"-"]&&isValid){
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(115, 52, 91, 20)];
            label3.text = [NSString stringWithFormat:@"Varış: %@",ticketArrivalHour];
            label3.font = detailFont2;
            [cell.contentView addSubview:label3];
        }
    }else{
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(115, 52, 91, 20)];
        label3.text = [NSString stringWithFormat:@"Varış: %@",ticketArrivalHour];
        label3.font = detailFont2;
        [cell.contentView addSubview:label3];
    }
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(220, 35, 91, 20)];
    label4.text = ticketPrice;
    label4.font = detailFontPrice;
    [cell.contentView addSubview:label4];
    
    Ticket *tmpTicket = [[Ticket alloc] init];
    tmpTicket.ticketPrice=tTicket.ticketPrice;
    tmpTicket.departHour=ticketDepartHour;
    tmpTicket.arrivalHour=ticketArrivalHour;
    tmpTicket.companyName=ticketCompanyName;
    tmpTicket.flightNo=tTicket.flightNo;
    tmpTicket.ticketDate=tTicket.ticketDate;
    tmpTicket.estimatedTravelTimeH=tTicket.estimatedTravelTimeH;
    tmpTicket.estimatedTravelTimeM=tTicket.estimatedTravelTimeM;
    
    [tmpTicketArray addObject:tmpTicket];
    /*
    UIFont *detailFont3 = [UIFont fontWithName:@"Georgia" size:10.0];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(115, 45, 100, 25)];
    label3.textColor=[UIColor grayColor];
    label3.text = [maczamanlari objectAtIndex:indexPath.row];
    label3.font = detailFont3;
    [cell.contentView addSubview:label3];
    
    UIImage *image2=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[rakiplogo objectAtIndex:indexPath.row]]]];
    UIButton *buyButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [buyButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    buyButton2.frame = CGRectMake(230, 5, 50, 50);
    [cell.contentView addSubview:buyButton2];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(230, 55, 75, 17)];
    label4.text = [rakiptakimlar objectAtIndex:indexPath.row];
    label4.font = detailFont;
    [cell.contentView addSubview:label4];
    
    if([[status objectAtIndex:indexPath.row ] rangeOfString:@"deplasman"].location != NSNotFound){
        buyButton.frame = CGRectMake(230, 5, 50, 50);
        label.frame=CGRectMake(230, 55, 75, 17);
        label4.frame=CGRectMake(25, 55, 75, 17);
        buyButton2.frame=CGRectMake(25, 5, 50, 50);
    }
     */
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Ticket *t = [tmpTicketArray objectAtIndex:indexPath.row];
    Details *Dets = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_Details"];
    Dets.tPrice = [NSString stringWithFormat:@"%.2f TL", t.ticketPrice];
    Dets.tCompanyName = t.companyName;
    Dets.tDepartHour = t.departHour;
    Dets.tArrivalHour = t.arrivalHour;
    Dets.tFlightNo = t.flightNo;
    Dets.tDate=t.ticketDate;
    Dets.tEstimatedTimeH=t.estimatedTravelTimeH;
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    BOOL isValid = [[t.estimatedTravelTimeH stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    
    if(![t.estimatedTravelTimeH isEqual:@"-"]&&isValid){
        Dets.tEstimatedTime = [NSString stringWithFormat:@"%@ saat %@ dakika",t.estimatedTravelTimeH,t.estimatedTravelTimeM];
    }
    Dets.returnPageType=@"AT";
    [self.navigationController pushViewController:Dets animated:YES];
}
//----------------------TABLEVIEWCELL HEIGHT -------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
