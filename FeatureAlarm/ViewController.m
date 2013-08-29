//
//  ViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
//#import "ConfigRepeatViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    //ユーザデフォルト領域のための変数
    NSUserDefaults *defaults;
   // ConfigRepeatViewController *ConfigRepeat;
    IBOutlet UILabel *tit_lab;//titleLabel
    IBOutlet UILabel *home_txt_lab;//「現在の設定：」
    IBOutlet UILabel *conf_time_lab;//設定時刻を表示するラベル
    IBOutlet UIButton *config;//設定画面に遷移するボタン
    IBOutlet UIButton *cancel;//設定解除アラートビューを表示させるボタン
    IBOutlet UILabel *state_txt;
    IBOutlet UILabel *lv_txt;
    IBOutlet UILabel *lv;

}



/*
 *アラーム解除ボタンが押された時にアラートビューを表示する
 */
- (IBAction)Button_cancel_push{
    //設定解除ボタンが押された時にアラートビューを表示する
    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:@"設定解除" //アラートビューのタイトル
     message:@"アラーム設定を解除しますか？"//アラートビューの説明（コメント）
     delegate:self//参照するメソッド
     cancelButtonTitle:@"いいえ"//アラート内容（設定解除を行うか）に対するキャンセルボタンのタイトル
     otherButtonTitles:@"はい", nil];//アラート内容（設定解除を行うか）に対するキャンセル以外のボタンのタイトル
    [alert show];//アラートビューを表示する
}


/*
 *アラートビューで「はい」が押された場合の処理
 *2012/09/12 Sayaka Watanabe
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //アラートビューで「はい」が押された場合
        //設定内容を初期化するメソッドconfig_formatに処理を渡す
    if(buttonIndex==1)[self config_format];
    
}


/*
 *設定を初期化するメソッド
 *2012/09/12 Sayaka Watanabe
 */
- (void)config_format{
    //アラーム時刻設定の初期化
    [defaults setInteger:0 forKey:@"Hour"];
    [defaults setInteger:0 forKey:@"Min"];
    //曜日設定の初期化
    [defaults setBool:NO forKey:@"ConfDayMon"];
    [defaults setBool:NO forKey:@"ConfDayTue"];
    [defaults setBool:NO forKey:@"ConfDayWed"];
    [defaults setBool:NO forKey:@"ConfDayThu"];
    [defaults setBool:NO forKey:@"ConfDayFri"];
    [defaults setBool:NO forKey:@"ConfDaySat"];
    [defaults setBool:NO forKey:@"ConfDaySun"];
    [self viewDidLoad];
   // [ConfigRepeat TextColor];
 //   [self TextColor];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //ユーザデフォルト領域へのアクセス
    defaults = [NSUserDefaults standardUserDefaults];
    
    //ユーザデフォルトから時間と分の値をそれぞれ読み出し
    int dH = [defaults integerForKey:@"Hour"];
    int dM = [defaults integerForKey:@"Min"];
    //時分が両方0であればアラーム時刻は設定されていないと判断する
    if(dH<=0&&dM<=0)
        [conf_time_lab setText:@"設定されていません"];
    //時分が両方0でなければ、時分をそれぞれ２桁表示する
    else
        [conf_time_lab setText:[NSString stringWithFormat:@"%02d:%02d",dH,dM]];
    
    //レベル表示。
    int Lv=(int)[defaults floatForKey:@"LV"];
    NSLog(@"Lv=%@",[NSString stringWithFormat:@"%d",Lv]);
    lv.text = [NSString stringWithFormat:@"%d",Lv];
    //float exp=[defaults floatForKey:@"EXP"];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
/*
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
 {
 return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
 }
 */
@end
