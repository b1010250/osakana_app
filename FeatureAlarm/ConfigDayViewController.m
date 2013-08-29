//
//  ConfigDayViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//
//

#import "ConfigDayViewController.h"

@interface ConfigDayViewController ()

@end

@implementation ConfigDayViewController{
    IBOutlet UILabel *conf_day_tit;
    //各曜日のラベル
    IBOutlet UILabel *conf_mon;
    IBOutlet UILabel *conf_tue;
    IBOutlet UILabel *conf_wed;
    IBOutlet UILabel *conf_thu;
    IBOutlet UILabel *conf_fri;
    IBOutlet UILabel *conf_sat;
    IBOutlet UILabel *conf_sun;
    //曜日設定のSwitch
    IBOutlet UISwitch *conf_day_mon;
    IBOutlet UISwitch *conf_day_tue;
    IBOutlet UISwitch *conf_day_wed;
    IBOutlet UISwitch *conf_day_thu;
    IBOutlet UISwitch *conf_day_fri;
    IBOutlet UISwitch *conf_day_sat;
    IBOutlet UISwitch *conf_day_sun;
    
    
    IBOutlet UIButton *conf_day_ok;
    NSUserDefaults *defaults;//ユーザデフォルト領域のための変数
    
}

@synthesize conf_day_ok;
@synthesize conf_day_sun;
@synthesize conf_day_sat;
@synthesize conf_day_fri;
@synthesize conf_day_thu;
@synthesize conf_day_wed;
@synthesize conf_day_tue;
@synthesize conf_day_mon;
@synthesize conf_sun;
@synthesize conf_sat;
@synthesize conf_fri;
@synthesize conf_thu;
@synthesize conf_wed;
@synthesize conf_tue;
@synthesize conf_mon;


//OKボタンが押されたら、月曜日から日曜日までがtureかNOか判別し設定に反映させる
- (IBAction)ConfDayOkPush{
    if(conf_day_mon.on==YES)[defaults setBool:YES forKey:@"ConfDayMon"];
    else [defaults setBool:NO forKey:@"ConfDayMon"];
    
    if(conf_day_tue.on==YES)[defaults setBool:YES forKey:@"ConfDayTue"];
    else [defaults setBool:NO forKey:@"ConfDayTue"];
    
    if(conf_day_wed.on==YES)[defaults setBool:YES forKey:@"ConfDayWed"];
    else [defaults setBool:NO forKey:@"ConfDayWed"];
    
    if(conf_day_thu.on==YES)[defaults setBool:YES forKey:@"ConfDayThu"];
    else [defaults setBool:NO forKey:@"ConfDayThu"];
    
    if(conf_day_fri.on==YES)[defaults setBool:YES forKey:@"ConfDayFri"];
    else [defaults setBool:NO forKey:@"ConfDayFri"];
    
    if(conf_day_sat.on==YES)[defaults setBool:YES forKey:@"ConfDaySat"];
    else [defaults setBool:NO forKey:@"ConfDaySat"];
    
    if(conf_day_sun.on==YES)[defaults setBool:YES forKey:@"ConfDaySun"];
    else [defaults setBool:NO forKey:@"ConfDaySun"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //ユーザデフォルト領域へのアクセス
    defaults = [NSUserDefaults standardUserDefaults];
}

- (void)viewDidUnload
{
    
    [self setConf_mon:nil];
    [self setConf_tue:nil];
    [self setConf_wed:nil];
    [self setConf_thu:nil];
    [self setConf_fri:nil];
    [self setConf_sat:nil];
    [self setConf_sun:nil];
    [self setConf_day_mon:nil];
    [self setConf_day_tue:nil];
    [self setConf_day_wed:nil];
    [self setConf_day_thu:nil];
    [self setConf_day_fri:nil];
    [self setConf_day_sat:nil];
    [self setConf_day_sun:nil];
    [self setConf_day_ok:nil];
     
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
