//
//  WakeUpViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WakeUpViewController.h"

@interface WakeUpViewController ()

@end

@implementation WakeUpViewController{
    int alarmhour,alarmmin;
    int hour,min,sec;
    
    NSUserDefaults *defaults;//ユーザデフォルト領域のための変数
    IBOutlet UILabel *LV_txt;
    float exp;
    int un_exp;
    int tp_exp;
    NSString *result_txt;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(IBAction)result_pushed{
    UIAlertView*alert =
    [[UIAlertView alloc]
     initWithTitle:@"結果"
     message:(@"%s",result_txt)
     delegate:self
     cancelButtonTitle:@"ホームに戻る"
     otherButtonTitles:@"アプリ終了", nil];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //アプリ終了
    if(buttonIndex==1){
        exit(0);
    }
    //ホームに戻る
    else{
        WakeUpViewController *WakeUpVC;
        WakeUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
        [self presentModalViewController:WakeUpVC animated:NO];
        
    }
}

-(void)LVUP{
    
    for(int i=0; i<100;i++){
        if(exp>=un_exp && exp<tp_exp){
            int lvup=tp_exp/200.0;
            NSLog(@"%d",lvup);
            [defaults setInteger:lvup forKey:@"LV"];
            break;
        }else{
            un_exp=un_exp+200.0;
            tp_exp=tp_exp+200.0;
        }
    }
    [LV_txt setText:[NSString stringWithFormat:@"%d",[defaults integerForKey:@"LV"]]];
    
}



-(void)ExpUp{
    
    float ans_count=[defaults floatForKey:@"ans_count"];
    float quest_count=[defaults floatForKey:@"quest_count"];
    NSLog(@"ans_count=%f",ans_count);
    NSLog(@"quest_count=%f",quest_count);
    float exp_old=[defaults floatForKey:@"EXP"];
    exp=(50.0/(ans_count/quest_count))+exp_old;
    float game_exp=50.0/(ans_count/quest_count);
    NSLog(@"exp=%f",exp);
    [defaults setFloat:exp forKey:@"EXP"];
    
    result_txt = [NSString stringWithFormat:@"%dの経験値を獲得しました！",(int)game_exp];
    
}



//時計表示
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //ユーザデフォルト領域へのアクセス
    defaults = [NSUserDefaults standardUserDefaults];
    exp = (int)[defaults floatForKey:@"EXP"];
    NSLog(@"%f",[defaults floatForKey:@"EXP"]);
    un_exp =0.0;
    tp_exp =200.0;
    [self LVUP];
    [self ExpUp];
    
    //時計の更新。0.5秒ごとにshowDateメソッドを呼び出す
    myTicker = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                target:self
                                              selector:@selector(driveClock:)
                                              userInfo:nil
                                               repeats:YES];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"muci_fan_10" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    funPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    funPlayer.numberOfLoops = 0;
    [funPlayer play];
    
    
    
}

//時計の更新。0.5秒ごとにshowDateメソッドを呼び出す
- (void)driveClock:(NSTimer *)timer
{
    NSDate *today = [NSDate date]; //現在時刻を取得
    
    NSCalendar *calender = [NSCalendar currentCalendar]; //現在時刻の時分秒を取得
    unsigned flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *todayComponents = [calender components:flags fromDate:today];
    hour = [todayComponents hour];
    min = [todayComponents minute];
    sec = [todayComponents second];
    
    timeLabelH.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec]; //時間を表示
    
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
