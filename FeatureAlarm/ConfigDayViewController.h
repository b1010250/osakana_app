//
//  ConfigDayViewController.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//
//
#import <UIKit/UIKit.h>

@interface ConfigDayViewController : UIViewController
@property (nonatomic) IBOutlet UIButton *conf_day_ok;
@property (nonatomic) IBOutlet UISwitch *conf_day_sun;
@property (nonatomic) IBOutlet UISwitch *conf_day_sat;
@property (nonatomic) IBOutlet UISwitch *conf_day_fri;
@property (nonatomic) IBOutlet UISwitch *conf_day_thu;
@property (nonatomic) IBOutlet UISwitch *conf_day_wed;
@property (nonatomic) IBOutlet UISwitch *conf_day_tue;
@property (nonatomic) IBOutlet UISwitch *conf_day_mon;
@property (nonatomic) IBOutlet UILabel *conf_sun;
@property (nonatomic) IBOutlet UILabel *conf_sat;
@property (nonatomic) IBOutlet UILabel *conf_fri;
@property (nonatomic) IBOutlet UILabel *conf_thu;
@property (nonatomic) IBOutlet UILabel *conf_wed;
@property (nonatomic) IBOutlet UILabel *conf_tue;
@property (nonatomic) IBOutlet UILabel *conf_mon;

- (IBAction)ConfDayOkPush :(id)sender;

@end
