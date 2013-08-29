//
//  PunchViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PunchViewController.h"
#import "MoleView.h" //追加行
#import "AppDelegate.h"
#import <mach/mach_time.h>
#define RANDOM_SEED()srandom((unsigned)(mach_absolute_time() & 0xFFFFFFFF))
#define RANDOM_FLOAT()((float)random()/(float)INT32_MAX)


@interface PunchViewController ()


@end


@implementation PunchViewController{
    Audio *sound;
}
    NSUserDefaults *defaults;//ユーザデフォルト領域のための変数
int PushCount = 0;
int PushCountH = 0;
int alarmhour,alarmmin;
int hour,min,sec;

@synthesize	moleImageView;
@synthesize scoreLabel;






- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

//時計表示
- (void)viewDidLoad
{
    AppDelegate*appDelegate = 0;
    PushCount = 0;
    PushCountH = 0;
    
    sound = [Audio initAudio];
    
    RANDOM_SEED(); //乱数初期化
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //ユーザデフォルト領域へのアクセス
    defaults = [NSUserDefaults standardUserDefaults];
    
    //時計の更新。0.5秒ごとにshowDateメソッドを呼び出す
    myTicker = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                target:self
                                              selector:@selector(driveClock:)
                                              userInfo:nil
                                               repeats:YES];
    
    
    //0.1秒ごとにShowScoreを呼び出す(爆)。レベル設定はここも変えてね。    
    myTicker = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                target:self
                                              selector:@selector(showScore)
                                              userInfo:nil
                                               repeats:YES];
    //時計とスコアのリフレッシュに同じタイマー使ってます(更新周期が違うだけ)
    
    
    //ターゲット(！マーク)のセットをさせる
	for ( MoleView *view in gameView.subviews )
	{
		[view setup];
	}
	
    
    //ターゲットを呼び出すタイマー
    moleTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self 
                                               selector:@selector(showMole) userInfo:nil repeats:YES];
    
    
    //アラーム鳴らす
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ro1_003" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    alarmPlayer.numberOfLoops = -1;
    [alarmPlayer play];
    
    /*
    NSString *pathp = [[NSBundle mainBundle] pathForResource:@"sen_ge_panchi12" ofType:@"mp3"];
    NSURL *urlp = [NSURL fileURLWithPath:pathp];
    punchPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlp error:nil];
    punchPlayer.numberOfLoops = 0;
    */
    
    
    
    
}


//スコア表示のリフレッシュ(力技)。クリア判定もここでします。
-(void)showScore{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    PushCount = appDelegate.scoreLabel;
    scoreLabel.text = [NSString stringWithFormat:@"%d",appDelegate.scoreLabel];
    
   // PushCount = PushCount ;//難易度設定はこの辺に記述
    
    int randompunch;
    if(PushCount>PushCountH){
        for(int i=0; i<2; i++){
            randompunch = arc4random() % 2 + 1;//1~3の数値をランダムに取得
            NSLog(@"%d",randompunch);
        }
        if(randompunch == 1){
            [sound punchi02];
        }else {
            [sound punchi01];
        }
        PushCountH = PushCount;
    }
    
    
    
    //設定数値になったらゲーム終了。起きた画面に遷移
    if (PushCount>=10) {
        
        [defaults setInteger:PushCount forKey:@"quest_count"];
        [defaults setInteger:PushCount forKey:@"ans_count"];
        
        PunchViewController *PunchVC;
        PunchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WakeUpViewController"];
        [self presentModalViewController:PunchVC animated:NO];
        
        //printf("PushCount");
        
        [myTicker invalidate];
        [alarmPlayer stop];
        [self resetCount];
        
    }
    
    
}

- (void)resetCount{
    AppDelegate*appDelegate = 0;
    PushCount = 0;
    PushCountH = 0;
}


//ターゲット表示
- (void)showMole {
	NSUInteger  index = RANDOM_FLOAT() * [gameView.subviews count];// 乱数をindexに代入
	MoleView  *view = [gameView.subviews objectAtIndex:index];// 任意のMoleViewオブジェクトを取得
    
	if ( [view.moleImageView isAnimating] == NO ) // アニメーションが止まっていたら
		[view.moleImageView startAnimating]; // アニメーション開始
}



//時計表示
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



/*
//NSDateから取得したデータを必要な形式にするメソッド
-(void)showDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSDate *date = [NSDate date];
    
	// initialize locale
	[formatter setLocale:[NSLocale currentLocale]];  
	
	// update clockTime label
	[formatter setTimeStyle:NSDateFormatterShortStyle]; 
	[timeLabelH setText:[formatter stringFromDate:date]];
}

*/


- (void)viewDidUnload
{
    // [self setScoreLabel:nil];
    [super viewDidUnload];
  
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
