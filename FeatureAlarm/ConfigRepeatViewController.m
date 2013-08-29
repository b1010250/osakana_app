//
//  ConfigRepeatViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//
//

#import "ConfigRepeatViewController.h"

@interface ConfigRepeatViewController ()


@end


/*
 毎日の場合、グローバル変数で定義された各曜日はYESとなっていればよい。
 ひとつでも曜日にNOがあったら繰り返し設定の下にYESになっている曜日を表示する。
 
 
 */

@implementation ConfigRepeatViewController{
    IBOutlet UIButton *conf_every;//アラーム設定を毎日にするボタン
    IBOutlet UIButton *go_conf_day;//アラームの曜日指定画面へ遷移するボタン
    IBOutlet UILabel *conf_day_bor;//ページタイトルラベル
    
    //月曜日から日曜日までのラベル
    IBOutlet UILabel *conf_day_1;
    IBOutlet UILabel *conf_day_2;
    IBOutlet UILabel *conf_day_3;
    IBOutlet UILabel *conf_day_4;
    IBOutlet UILabel *conf_day_5;
    IBOutlet UILabel *conf_day_6;
    IBOutlet UILabel *conf_day_7;
    
    
    NSUserDefaults *defaults;//ユーザデフォルト領域のための変数
    
}
@synthesize conf_day_7;
@synthesize conf_day_6;
@synthesize conf_day_5;
@synthesize conf_day_4;
@synthesize conf_day_3;
@synthesize conf_day_2;
@synthesize conf_day_1;
@synthesize go_conf_day;
@synthesize conf_every;


/*
 *毎日ボタンを押したときのイベント
 */
- (IBAction)ConfEvery:(id)sender{
    //全ての曜日をYESに切り替える
    [defaults setBool:YES forKey:@"ConfDayMon"];
    [defaults setBool:YES forKey:@"ConfDayTue"];
    [defaults setBool:YES forKey:@"ConfDayWed"];
    [defaults setBool:YES forKey:@"ConfDayThu"];
    [defaults setBool:YES forKey:@"ConfDayFri"];
    [defaults setBool:YES forKey:@"ConfDaySat"];
    [defaults setBool:YES forKey:@"ConfDaySun"];
    //切り替えた分の曜日の色を変える
    [self TextColor];

    
}

/*
 *アラーム設定状況によって曜日のカラーを変える
 */
- (void)TextColor{
    if([defaults boolForKey:@"ConfDayMon"]==YES)conf_day_1.textColor=[UIColor blackColor];
    else conf_day_1.textColor=[UIColor lightGrayColor];
    
    if([defaults boolForKey:@"ConfDayTue"]==YES)conf_day_2.textColor=[UIColor blackColor];
    else conf_day_2.textColor=[UIColor lightGrayColor];
    
    if([defaults boolForKey:@"ConfDayWed"]==YES)conf_day_3.textColor=[UIColor blackColor];
    else conf_day_3.textColor=[UIColor lightGrayColor];
    
    if([defaults boolForKey:@"ConfDayThu"]==YES)conf_day_4.textColor=[UIColor blackColor];
    else conf_day_4.textColor=[UIColor lightGrayColor];
    
    if([defaults boolForKey:@"ConfDayFri"]==YES)conf_day_5.textColor=[UIColor blackColor];
    else conf_day_5.textColor=[UIColor lightGrayColor];
    
    if([defaults boolForKey:@"ConfDaySat"]==YES)conf_day_6.textColor=[UIColor blackColor];
    else conf_day_6.textColor=[UIColor lightGrayColor];
    
    if([defaults boolForKey:@"ConfDaySun"]==YES)conf_day_7.textColor=[UIColor blackColor];
    else conf_day_7.textColor=[UIColor lightGrayColor];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //ユーザデフォルト領域へのアクセス
    defaults = [NSUserDefaults standardUserDefaults];
    conf_day_1.text = @"月曜日";
    conf_day_2.text = @"火曜日";
    conf_day_3.text = @"水曜日";
    conf_day_4.text = @"木曜日";
    conf_day_5.text = @"金曜日";
    conf_day_6.text = @"土曜日";
    conf_day_7.text = @"日曜日";
    [self TextColor];
}

- (void)viewDidUnload
{
    [self setConf_every:nil];
    [self setGo_conf_day:nil];
    [self setConf_day_1:nil];
    [self setConf_day_2:nil];
    [self setConf_day_3:nil];
    [self setConf_day_4:nil];
    [self setConf_day_5:nil];
    [self setConf_day_6:nil];
    [self setConf_day_7:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
