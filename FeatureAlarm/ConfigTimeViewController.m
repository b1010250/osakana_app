//
//  ConfigTimeViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//
//

#import "ConfigTimeViewController.h"

@interface ConfigTimeViewController ()

@end

@implementation ConfigTimeViewController{
    NSUserDefaults *defaults;    //ユーザデフォルト領域のための変数
    IBOutlet UIButton *conf_time_ok;//ホーム画面へ遷移する（時間のセットを制御しない）
    IBOutlet UIDatePicker *DatePicker;//日付を取得するためのPicker
    IBOutlet UILabel *conf_time_h;//Pickerから得た値を一時保存するラベル
    IBOutlet UILabel *conf_time_m;//Pickerから得た値を一時保存するラベル
}
@synthesize conf_time_m;
@synthesize conf_time_h;
@synthesize DatePicker;


- (IBAction)changeDatePicker:(id)sender{
    //日付フォーマッターを使って日付の表示形式を用意する
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    //時の取得
    df.dateFormat = @"HH";
    //データを格納するラベルに値を代入する
    conf_time_h.text=[df stringFromDate:DatePicker.date];
    NSLog(@"text=%@",[df stringFromDate:DatePicker.date]);//値の取得状況を確認するためにLogを取る
    //ラベルの値を整数型に直して変数に保存する
    int hour = [conf_time_h.text intValue];
    NSLog(@"hour=%d",hour);//値の取得状況を確認するためにLogを取る

    //分の取得
    df.dateFormat = @"mm";
    //データを格納するラベルに値を代入する
    [conf_time_m setHidden:YES];
    conf_time_m.text = [df stringFromDate:DatePicker.date];
    NSLog(@"text=%@",[df stringFromDate:DatePicker.date]);//値の取得状況を確認するためにLogを取る
    //ラベルの値を整数型に直して変数に保存する
    int min = [conf_time_m.text intValue];
    NSLog(@"min=%d",min);//値の取得状況を確認するためにLogを取る
    
    [defaults setInteger:hour forKey:@"Hour"];//時をユーザデフォルトに書き込む
    [defaults setInteger:min forKey:@"Min"];//分をユーザデフォルトに書き込む
    [defaults synchronize];//設定をすぐに反映させる
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //ユーザデフォルト領域へのアクセス
    defaults = [NSUserDefaults standardUserDefaults];
    //値を一時保存するラベルを非表示にする
        [conf_time_h setHidden:YES];
        [conf_time_m setHidden:YES];
    
}





- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [self setConf_time_h:nil];
    [self setConf_time_m:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
