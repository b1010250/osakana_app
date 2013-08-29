//
//  ConfigViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/13.
//
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController{
    IBOutlet UILabel *conf_tit;
    IBOutlet UIButton *conf_time;
    IBOutlet UIButton *conf_rep;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)Button_conf_time_push{
}

- (IBAction)Button_conf_rep_push{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
