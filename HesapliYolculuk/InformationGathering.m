//
//  InformationGathering.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "InformationGathering.h"
#import "DisplayCheapestTicket.h"
#import "Reachability.h"
@interface InformationGathering ()

@end

@implementation InformationGathering
@synthesize selectedVehicle,neredenLabel,nereyeLabel,spinnerMenu,biletAraButton,spinnerView,cityPicker,tarihLabel,datePicker,alert;
UIAlertView *ticketsAreLoadingAlert, *wrongDateAlert, *sameDepAndArrAlert, *noTicketAlert, *noConnectionAlert;
static NSString *selectedVehicleType;
static NSMutableArray *cityArray;
static NSString *selectedActivity;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSString*)selectedVehicleTypeUD
{
    NSString* SV = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedVehicleType"];
    return SV;
}
-(IBAction) tarihSec{
    spinnerView.hidden=NO;
    spinnerMenu.hidden=NO;
    datePicker.hidden=NO;
    biletAraButton.userInteractionEnabled=NO;
    selectedActivity=@"Tarih";
}
-(IBAction) activateNeredenSpinner{
    spinnerMenu.hidden=NO;
    spinnerView.hidden=NO;
    cityPicker.hidden=NO;
    biletAraButton.userInteractionEnabled=NO;
    selectedActivity=@"Nereden";
    [cityPicker selectRow:[cityArray indexOfObject:neredenLabel.text] inComponent:0 animated:YES];
}
-(IBAction) activateNereyeSpinner{
    spinnerMenu.hidden=NO;
    spinnerView.hidden=NO;
    cityPicker.hidden=NO;
    biletAraButton.userInteractionEnabled=NO;
    selectedActivity=@"Nereye";
    [cityPicker selectRow:[cityArray indexOfObject:nereyeLabel.text] inComponent:0 animated:YES];
}
-(IBAction) passiveSpinner{
    spinnerMenu.hidden=YES;
    spinnerView.hidden=YES;
    biletAraButton.userInteractionEnabled=YES;
    datePicker.hidden=YES;
    cityPicker.hidden=YES;
}
-(IBAction) SelectFromSpinner{
    if([selectedActivity isEqual:@"Nereden"]){
        NSInteger row = [cityPicker selectedRowInComponent:0];
        NSString *selectedCity = [cityArray objectAtIndex:row];
        neredenLabel.text=selectedCity;
    }else if ([selectedActivity isEqual:@"Nereye"]){
        NSInteger row = [cityPicker selectedRowInComponent:0];
        NSString *selectedCity = [cityArray objectAtIndex:row];
        nereyeLabel.text=selectedCity;
    }else if([selectedActivity isEqual:@"Tarih"]){
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *selectedDate = [outputFormatter stringFromDate:self.datePicker.date];
        tarihLabel.text=selectedDate;
    }
    spinnerMenu.hidden=YES;
    spinnerView.hidden=YES;
    biletAraButton.userInteractionEnabled=YES;
    datePicker.hidden=YES;
    cityPicker.hidden=YES;
}
+(BOOL) isBus{
    if([selectedVehicleType isEqual:@"isBus"]){
        return YES;
    }
    return NO;
}
+(BOOL) isPlane{
    if([selectedVehicleType isEqual:@"isPlane"]){
        return YES;
    }
    return NO;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [cityArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [cityArray objectAtIndex:row];
}
-(void) setupCityArray{
    if([InformationGathering isPlane]){
        [cityArray addObject:@"Ankara"];
        [cityArray addObject:@"İzmir"];
        [cityArray addObject:@"İstanbul"];
        [cityArray addObject:@"Bursa"];
        [cityArray addObject:@"Adapazarı"];
        [cityArray addObject:@"Aydın"];
        [cityArray addObject:@"Afyon"];
        [cityArray addObject:@"Antalya"];
        [cityArray addObject:@"Eskişehir"];
        
        [cityArray addObject:@"Adana"];
        [cityArray addObject:@"Amasya"];
        [cityArray addObject:@"Denizli"];
        [cityArray addObject:@"Diyarbakır"];
        [cityArray addObject:@"Elazığ"];
        [cityArray addObject:@"Gaziantep"];
        [cityArray addObject:@"Hatay"];
        [cityArray addObject:@"Kayseri"];
        [cityArray addObject:@"Van"];
        [cityArray addObject:@"Konya"];
        
        [cityArray addObject:@"Kütahya"];
        [cityArray addObject:@"Malatya"];
        [cityArray addObject:@"Sivas"];
        [cityArray addObject:@"Dalaman"];
        [cityArray addObject:@"Alanya"];
        [cityArray addObject:@"Trabzon"];
        [cityArray addObject:@"Erzincan"];
        [cityArray addObject:@"Batman"];
        [cityArray addObject:@"Samsun"];
        
        [cityArray addObject:@"Şanlıurfa"];
        [cityArray addObject:@"Muş"];
        [cityArray addObject:@"Bodrum"];
        [cityArray addObject:@"Lefkoşa"];
        [cityArray addObject:@"Erzurum"];
        [cityArray addObject:@"Gence"];
        [cityArray addObject:@"Odessa"];
        
        [cityArray addObject:@"Balıkesir"];
        [cityArray addObject:@"Adıyaman"];
        [cityArray addObject:@"Ağrı"];
        [cityArray addObject:@"Çanakkale"];
        [cityArray addObject:@"Gökçeada"];
        [cityArray addObject:@"Iğdır"];
        [cityArray addObject:@"Isparta"];
        [cityArray addObject:@"Kahramanmaraş"];
        [cityArray addObject:@"Kars"];
        [cityArray addObject:@"Kocaeli"];
        
        [cityArray addObject:@"Mardin"];
        [cityArray addObject:@"Nevşehir"];
        [cityArray addObject:@"Siirt"];
        [cityArray addObject:@"Sinop"];
        [cityArray addObject:@"Tekirdağ"];
        [cityArray addObject:@"Tokat"];
        [cityArray addObject:@"Uşak"];
    
    }else if([InformationGathering isBus]){
		[cityArray addObject:@"Sungurlu"];
        [cityArray addObject:@"Susurluk"];
        [cityArray addObject:@"Şarkikaraağaç"];
        [cityArray addObject:@"Turgutlu"];
        [cityArray addObject:@"Uluborlu"];
        [cityArray addObject:@"Yalıkavak"];
        [cityArray addObject:@"Yalvaç"];
        [cityArray addObject:@"Yatağan"];
        [cityArray addObject:@"Yenice"];
        [cityArray addObject:@"Zonguldak"];
        
		[cityArray addObject:@"Köyceğiz"];
        [cityArray addObject:@"Kumluca"];
        [cityArray addObject:@"Küçükkuyu"];
        [cityArray addObject:@"Lapseki"];
        [cityArray addObject:@"Marmaris"];
        [cityArray addObject:@"Mengen"];
        [cityArray addObject:@"Milas"];
        [cityArray addObject:@"Muğla"];
        [cityArray addObject:@"Ortaca"];
        [cityArray addObject:@"Safranbolu"];
        [cityArray addObject:@"Senirkent"];
  		
		[cityArray addObject:@"Gemlik"];
        [cityArray addObject:@"Gönen"];
        [cityArray addObject:@"Gülnar"];
        [cityArray addObject:@"Ilgın"];
        [cityArray addObject:@"Isparta"];
        [cityArray addObject:@"İznik"];
        [cityArray addObject:@"Kalkan"];
        [cityArray addObject:@"Karabük"];
        [cityArray addObject:@"Karacabey"];
        [cityArray addObject:@"Karaman"];
        [cityArray addObject:@"Kastamonu"];
        [cityArray addObject:@"Kaş"];
        [cityArray addObject:@"Kırıkkale"];
        [cityArray addObject:@"Kozcağız"];
        [cityArray addObject:@"Kozlu"];
        
		[cityArray addObject:@"Çay"];
        [cityArray addObject:@"Çaycuma"];
        [cityArray addObject:@"Çine"];
        [cityArray addObject:@"Çorum"];
        [cityArray addObject:@"Dalaman"];
        [cityArray addObject:@"Datça"];
        [cityArray addObject:@"Devrek"];
        [cityArray addObject:@"Düzce"];
        [cityArray addObject:@"Edremit"];
        [cityArray addObject:@"Eğirdir"];
        [cityArray addObject:@"Emirdağ"];
        [cityArray addObject:@"Erdek"];
        [cityArray addObject:@"Ezine"];
        [cityArray addObject:@"Fethiye"];
        [cityArray addObject:@"Finike"];
        [cityArray addObject:@"Gazipaşa"];
        [cityArray addObject:@"Gelibolu"];
        
  		[cityArray addObject:@"Balıkesir"];
        [cityArray addObject:@"Ayvalık"];
        [cityArray addObject:@"Bandırma"];
        [cityArray addObject:@"Bartın"];
        [cityArray addObject:@"Beyşehir"];
        [cityArray addObject:@"Biga"];
        [cityArray addObject:@"Bilecik"];
        [cityArray addObject:@"Bolu"];
        [cityArray addObject:@"Bolvadin"];
        [cityArray addObject:@"Bozdoğan"];
        [cityArray addObject:@"Bozüyük"];
        [cityArray addObject:@"Bozyazı"];
        [cityArray addObject:@"Bucak"];
        [cityArray addObject:@"Burhaniye"];
        [cityArray addObject:@"Cihanbeyli"];
        [cityArray addObject:@"Çan"];
        [cityArray addObject:@"Çanakkale"];
        
        
  		[cityArray addObject:@"Serik"];
        [cityArray addObject:@"Mudanya"];
        [cityArray addObject:@"Turgutreis"];
        [cityArray addObject:@"Selçuk"];
        [cityArray addObject:@"Uzunköprü"];
        [cityArray addObject:@"Havsa"];
        [cityArray addObject:@"Akçakoca"];
        [cityArray addObject:@"Akhisar"];
        [cityArray addObject:@"Alaplı"];
        [cityArray addObject:@"Amasra"];
        [cityArray addObject:@"Anamur"];
        [cityArray addObject:@"Araç"];
        [cityArray addObject:@"Aydıncık"];
        
  		[cityArray addObject:@"Yalova"];
        [cityArray addObject:@"Akçay"];
        [cityArray addObject:@"Altınoluk"];
        [cityArray addObject:@"Menemen"];
        [cityArray addObject:@"Tavşanlı"];
        [cityArray addObject:@"Gerede"];
        [cityArray addObject:@"Kırklareli"];
        [cityArray addObject:@"İnegöl"];
        [cityArray addObject:@"Manavgat"];
        [cityArray addObject:@"Kemer"];
        [cityArray addObject:@"Güzelçamlı"];
        [cityArray addObject:@"Lüleburgaz"];
        
  		[cityArray addObject:@"Gebze"];
        [cityArray addObject:@"İzmit"];
        [cityArray addObject:@"Karahallı"];
        [cityArray addObject:@"Kuşadası"];
        [cityArray addObject:@"Kütahya"];
        [cityArray addObject:@"Manisa"];
        [cityArray addObject:@"Nazilli"];
        [cityArray addObject:@"Polatlı"];
        [cityArray addObject:@"Salihleraltı"];
        [cityArray addObject:@"Sandıklı"];
        [cityArray addObject:@"Sarımsaklı"];
        [cityArray addObject:@"Sivasli"];
        [cityArray addObject:@"Söke"];
        [cityArray addObject:@"Uşak"];
        
  		[cityArray addObject:@"İzmir"];
        [cityArray addObject:@"İstanbul"];
        [cityArray addObject:@"Eskişehir"];
        [cityArray addObject:@"Ankara"];
        [cityArray addObject:@"Antalya"];
        [cityArray addObject:@"Adana"];
        [cityArray addObject:@"Diyarbakır"];
        [cityArray addObject:@"Erzurum"];
        [cityArray addObject:@"Gaziantep"];
        [cityArray addObject:@"Bodrum"];
        [cityArray addObject:@"Alanya"];
        [cityArray addObject:@"Bursa"];
        [cityArray addObject:@"Elazığ"];
        [cityArray addObject:@"Malatya"];
        [cityArray addObject:@"Samsun"];
        [cityArray addObject:@"Trabzon"];
        
        [cityArray addObject:@"Adapazarı"];
        [cityArray addObject:@"Van"];
        [cityArray addObject:@"Afyon"];
        [cityArray addObject:@"Aliağa"];
        [cityArray addObject:@"Altınova"];
        [cityArray addObject:@"Aydın"];
        [cityArray addObject:@"Banaz"];
        [cityArray addObject:@"Bergama"];
        [cityArray addObject:@"Burdur"];
        [cityArray addObject:@"Çandarlı"];
        [cityArray addObject:@"Çivril"];
        [cityArray addObject:@"Denizli"];
        [cityArray addObject:@"Didim"];
        [cityArray addObject:@"Dikili"];
        [cityArray addObject:@"Dinar"];
        [cityArray addObject:@"Edremit"];
    }
    
    NSArray *mycityArray = [cityArray sortedArrayUsingSelector:
                  @selector(localizedCaseInsensitiveCompare:)];
    cityArray = [NSArray arrayWithArray:mycityArray];
}
-(void) setupTheArrays{
    cityArray = [[NSMutableArray alloc]init];
    [self setupCityArray];
}
-(IBAction) biletAra{
    ticketsAreLoadingAlert = [[UIAlertView alloc] initWithTitle:@"Biletler Yükleniyor\nLütfen Bekleyiniz…" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [ticketsAreLoadingAlert show];
    ticketsAreLoadingAlert.delegate=self;
    [NSThread detachNewThreadSelector:@selector(startTheBackgroundJob) toTarget:self withObject:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self viewWillDisappear:YES];
    if(buttonIndex == 912){
        wrongDateAlert = [[UIAlertView alloc] initWithTitle:@"Geçmis bir tarihte arama yapılamaz!" message:nil delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [wrongDateAlert show];
    }else if(buttonIndex == 913){
        sameDepAndArrAlert = [[UIAlertView alloc] initWithTitle:@"Kalkış ve varış yeri aynı olamaz!" message:nil delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [sameDepAndArrAlert show];
    }else if(buttonIndex == 914){
        noTicketAlert = [[UIAlertView alloc] initWithTitle:@"Aradığınız kriterlere uygun bilet bulunamadı!" message:nil delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [noTicketAlert show];
    }else if(buttonIndex == 915){
        noConnectionAlert = [[UIAlertView alloc] initWithTitle:@"Lütfen internete bağlı olduğunuzdan emin olun!" message:nil delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [noConnectionAlert show];
    }
}

-(void) startTheBackgroundJob{
    Travel_Information *userTravelInfo = [[Travel_Information alloc] init];
    NSArray *selectedDate = [tarihLabel.text componentsSeparatedByString:@"/"];
    userTravelInfo.DepartureDay=[selectedDate objectAtIndex:0];
    userTravelInfo.DepartureMonth=[selectedDate objectAtIndex:1];
    userTravelInfo.DepartureYear=[selectedDate objectAtIndex:2];
    userTravelInfo.Departure=neredenLabel.text;
    userTravelInfo.Destination=nereyeLabel.text;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *uDate = [df dateFromString:[NSString stringWithFormat:@"%@-%@-%@", userTravelInfo.DepartureYear,userTravelInfo.DepartureMonth,userTravelInfo.DepartureDay]];
    NSDate *cDate = [NSDate date];
    NSString* finalCurrentDateString = [df stringFromDate:cDate];
    cDate=[df dateFromString:finalCurrentDateString];
    if([uDate compare: cDate] == NSOrderedAscending){
        [ticketsAreLoadingAlert dismissWithClickedButtonIndex:912 animated:YES];
    }
    else{
        if([userTravelInfo.Departure isEqual:userTravelInfo.Destination])
        {
            [ticketsAreLoadingAlert dismissWithClickedButtonIndex:913 animated:YES];
        }
        else{
            if([self InternetConnectionIsAvailable]){
                NSMutableArray *ticketInformations = [Data_Transfer postValuesToService:userTravelInfo selectedVehicle:selectedVehicle];
                NSMutableArray *tickets = [Data_Transfer FillTicketInformations:ticketInformations];
                if([tickets count]>0){
                    tickets = [Data_Transfer SortTicketsByPrice:tickets];
                    for(Ticket *tmptic in tickets){
                        tmptic.ticketDate = [NSString stringWithFormat:@"%@/%@/%@",userTravelInfo.DepartureDay,userTravelInfo.DepartureMonth,userTravelInfo.DepartureYear];
                    }
                    DisplayCheapestTicket *DCT = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_DisplayCheapestTicket"];
                    DCT.sDate = [NSString stringWithFormat:@"%@-%@-%@",userTravelInfo.DepartureYear,userTravelInfo.DepartureMonth,userTravelInfo.DepartureDay];
                    DCT.tickets = tickets;
                    [ticketsAreLoadingAlert dismissWithClickedButtonIndex:0 animated:YES];
                    [self.navigationController pushViewController:DCT animated:YES];
                }else{
                    [ticketsAreLoadingAlert dismissWithClickedButtonIndex:914 animated:YES];
                }
            }else{
                [ticketsAreLoadingAlert dismissWithClickedButtonIndex:915 animated:YES];
            }
        }
    }
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
- (void)viewDidLoad
{
    [self passiveSpinner];
    selectedVehicle = [[Vehicle alloc] init];
    [selectedVehicle setType:[self selectedVehicleTypeUD]];
    selectedVehicleType = [selectedVehicle getType];
    [self setupTheArrays];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *selectedDate = [outputFormatter stringFromDate:[NSDate date]];
    tarihLabel.text=selectedDate;
    NSLog(@"%@",selectedVehicleType);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNeredenLabel:nil];
    [self setNereyeLabel:nil];
    [self setSpinnerMenu:nil];
    [self setBiletAraButton:nil];
    [self setSpinnerView:nil];
    [self setCityPicker:nil];
    [self setTarihLabel:nil];
    [self setDatePicker:nil];
    [super viewDidUnload];
}
@end
