//
//  AlarmViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//
//

#import "AlarmViewController.h"

@interface AlarmViewController (){
    
}

@end

@implementation AlarmViewController{
    NSUserDefaults *defaults;
    
    //IBOutlet UIButton *myButton;
    int alarmhour,alarmmin;
    int hour,min,sec,week;
    
    int onece;
    
}
@synthesize	zzzImageView;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
 //時計表示
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 // Do any additional setup after loading the view.
 
 //時計の更新。0.5秒ごとにshowDateメソッドを呼び出す
 myTicker = [NSTimer scheduledTimerWithTimeInterval:0.5
 target:self
 selector:@selector(testTime)
 userInfo:nil
 repeats:YES];
 
 }
 
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //ユーザデフォルト領域へのアクセス
    defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    
    //タイマーのセット（0.5秒）
    [NSTimer scheduledTimerWithTimeInterval:0.5 //タイマーを発生させる間隔（0.5秒毎）
                                     target:self //メソッドがあるオブジェクト
                                   selector:@selector(driveClock:) //呼び出すメソッド 
                                   userInfo:nil //メソッドに渡すパラメータ 
                                    repeats:YES]; //繰り返し 
    
    //アラーム鳴らす
    NSString *path = [[NSBundle mainBundle] pathForResource:@"otell" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    alarmPlayer.numberOfLoops = -1;
    

    
    
    
    //ボタンテスト
    UIButton* bt_H = [UIButton buttonWithType:UIButtonTypeRoundedRect];//矩形選択
    [bt_H setTitle:@"ホームに戻る" forState:UIControlStateNormal];//ラベル設定
    //[bt setTitle:@"clicked" forState:UIControlStateHighlighted];
    [bt_H setFrame:CGRectMake(93,356,134,50)];//位置サイズ決定
    [bt_H.titleLabel setFont:[UIFont systemFontOfSize:20]];//フォントサイズ決定
    [bt_H addTarget:self action:@selector(button_H_Pushed:) forControlEvents:UIControlEventTouchUpInside];
    //bt.tag = 1;
    [self.view addSubview:bt_H]; //表示
    //[bt release];
    
    
    onece = 0;
}

//button_Hのアクション
-(void)button_H_Pushed:(UIButton*)button{
    AlarmViewController *AlarmVC;
    AlarmVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self presentModalViewController:AlarmVC animated:NO];
    
}

// buttonのアクション

-(void)buttonPushed:(UIButton*)button{
    //ゲームのランダム選択に関する変数
    int Randomgame = 0;
    [alarmPlayer stop];
    
    for(int i=0; i<2; i++){
        Randomgame = arc4random() % 2 + 1;//1~3の数値をランダムに取得
        NSLog(@"%d",Randomgame);
        
    }
    
    // [testLabel setText:[NSString stringWithFormat:@"%d",Randomgame]];//テスト用
    
    
    //テスト用
    // Randomgame=1;
    
    //叩き起こす
    if(Randomgame==1){
        AlarmViewController *AlarmVC;
        AlarmVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PunchViewController"];
        //モーダルの表示
        [self presentModalViewController:AlarmVC animated:NO];
    }
    //呼び起こす
    if(Randomgame==2){
        AlarmViewController *AlarmVC;
        AlarmVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoutViewController"];
        //モーダルの表示
        [self presentModalViewController:AlarmVC animated:NO];
    }
    /*
    //揺さ振り起こす
    if(Randomgame==3){
        AlarmViewController *AlarmVC;
        AlarmVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShakeViewController"];
        //モーダルの表示
        [self presentModalViewController:AlarmVC animated:NO];
    }
     */
    
}


- (void)driveClock:(NSTimer *)timer
{
    NSDate *today = [NSDate date]; //現在時刻を取得
    NSCalendar *calender = [NSCalendar currentCalendar]; //現在時刻の時分秒を取得
    unsigned flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *todayComponents = [calender components:flags fromDate:today];
    hour = [todayComponents hour];
    min = [todayComponents minute];
    sec = [todayComponents second];
    week = [todayComponents weekday];
    
    timeLabelH.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec]; //時間を表示

    
    
    
    int dH = [defaults integerForKey:@"Hour"];
    //NSLog(@"%@",[defaults integerForKey:@"Hour"]);
    int dM = [defaults integerForKey:@"Min"];
    
    /*
    //test用
    dH = 00;
    dM = 00;
    hour = 00;
    min = 00;
*/
    
    int go_week=0;
    if(week==1 && [defaults boolForKey:@"ConfDaySun"]==1) go_week=1;
    else if(week==2 && [defaults boolForKey:@"ConfDayMon"]==1) go_week=1;
    else if(week==3 && [defaults boolForKey:@"ConfDayTue"]==1) go_week=1;
    else if(week==4 && [defaults boolForKey:@"ConfDayWed"]==1) go_week=1;
    else if(week==5 && [defaults boolForKey:@"ConfDayThu"]==1) go_week=1;
    else if(week==6 && [defaults boolForKey:@"ConfDayFri"]==1) go_week=1;
    else if(week==7 && [defaults boolForKey:@"ConfDaySat"]==1) go_week=1;
    NSLog(@"%d",[defaults boolForKey:@"ConfDayMon"]);
    NSLog(@"%d",[defaults boolForKey:@"ConfDayTue"]);
    NSLog(@"%d",[defaults boolForKey:@"ConfDayWed"]);
    NSLog(@"%d",go_week);
    
    
    if(go_week==1){
        if ((hour == dH && min == dM &&sec == 00 && onece == 0)) {
            // alarm start
            [alarmPlayer play];
            //ボタンテスト
            UIButton* bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];//矩形選択
            [bt setTitle:@"起こす!!" forState:UIControlStateNormal];//ラベル設定
            //[bt setTitle:@"clicked" forState:UIControlStateHighlighted];
            [bt setFrame:CGRectMake(93,356,134,50)];//位置サイズ決定
            [bt.titleLabel setFont:[UIFont systemFontOfSize:24]];//フォントサイズ決定
            [bt addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
            //bt.tag = 1;
            [self.view addSubview:bt]; //表示
            //[bt release];
            
            onece = 1;
        }
    }
}

/*
- (void)setup {
    
    //アニメーション処理
    zzzImageView = [[UIImageView alloc] init];
    zzzImageView.frame = self.bounds;//画像を表示するためのクラスであるUIImageViewを作成
    [self addSubview:zzzImageView];//UIImageViewの表示領域を設定
    zzzImageView.animationImages = 
    [NSArray arrayWithObjects:[UIImage imageNamed:@"punchs.png"],//画像の読み込み
     [UIImage imageNamed:@"punchm.png"],
     [UIImage imageNamed:@"punchb.png"],
     [UIImage imageNamed:@"punchs.png"],nil];
    
    zzzImageView.animationDuration = 0.4;//0.4がいい
    // [moleImageView startAnimating];//アニメーションスタート
    zzzImageView.animationRepeatCount = 1; // アニメーションが一回で終わるようにするためのセット
}
*/



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
