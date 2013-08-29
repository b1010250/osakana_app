//
//  ConfigTimeViewController.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//
//

#import <UIKit/UIKit.h>

@interface ConfigTimeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *conf_time_m;
@property (strong, nonatomic) IBOutlet UILabel *conf_time_h;
@property(nonatomic)IBOutlet UIButton *conf_time_ok;
@property(strong,nonatomic)IBOutlet UIDatePicker *DatePicker;

- (IBAction)changeDatePicker:(id)sender;


@end
