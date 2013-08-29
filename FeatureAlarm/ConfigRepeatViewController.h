//
//  ConfigRepeatViewController.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//
//


#import <UIKit/UIKit.h>

@interface ConfigRepeatViewController : UIViewController
@property (nonatomic) IBOutlet UILabel *conf_day_7;
@property (nonatomic) IBOutlet UILabel *conf_day_6;
@property (nonatomic) IBOutlet UILabel *conf_day_5;
@property (nonatomic) IBOutlet UILabel *conf_day_4;
@property (nonatomic) IBOutlet UILabel *conf_day_3;
@property (nonatomic) IBOutlet UILabel *conf_day_2;
@property (nonatomic) IBOutlet UILabel *conf_day_1;
@property (nonatomic) IBOutlet UIButton *go_conf_day;
@property (nonatomic) IBOutlet UIButton *conf_every;
- (IBAction)ConfEvery:(id)sender;
- (void)TextColor;
@end


