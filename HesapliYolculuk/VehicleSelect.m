//
//  VehicleSelect.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "VehicleSelect.h"
#import "InformationGathering.h"
@interface VehicleSelect ()

@end

@implementation VehicleSelect
@synthesize selectedVehicle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) selectBus{
    [selectedVehicle setType:@"isBus"];
    InformationGathering *IG = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_InformationGathering"];
    [[NSUserDefaults standardUserDefaults] setObject:[selectedVehicle getType] forKey:@"selectedVehicleType"];
    [self.navigationController pushViewController:IG animated:YES];
}

-(IBAction) selectPlane{
    [selectedVehicle setType:@"isPlane"];
    InformationGathering *IG = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_InformationGathering"];
    [[NSUserDefaults standardUserDefaults] setObject:[selectedVehicle getType] forKey:@"selectedVehicleType"];
    [self.navigationController pushViewController:IG animated:YES];
}

- (void)viewDidLoad
{
    selectedVehicle = [[Vehicle alloc]init];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
