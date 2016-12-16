//
//  MainPage.m
//  HesapliYolculuk
//
//  Created by Fatih Türker on 27.02.2013.
//  Copyright (c) 2013 Reellsoft. All rights reserved.
//

#import "MainPage.h"
#import "VehicleSelect.h"
@interface MainPage ()

@end

@implementation MainPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) switchView{
    VehicleSelect *VS = [self.storyboard instantiateViewControllerWithIdentifier:@"SBID_VehicleSelect"];
    [self.navigationController pushViewController:VS animated:YES];
}

- (void)viewDidLoad
{
    [self performSelector:@selector(switchView) withObject:nil afterDelay:2.0f];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
