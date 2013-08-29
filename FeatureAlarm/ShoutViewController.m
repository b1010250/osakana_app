//
//  ShoutViewController.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/16.
//
//

#import "ShoutViewController.h"

@interface ShoutViewController ()




@end

@implementation ShoutViewController{
    
     Audio *sound;
    
    
    int alarmhour,alarmmin;
    int hour,min,sec;
    NSTimer*myTicker;

    
    //ユーザデフォルト領域のための変数
    NSUserDefaults *defaults;
    
    //回答文字配列の添字となる変数
    int random_char1;
    int random_char2;
    int random_char3;
    
    //正答回数をカウントする変数
    float quest_count;
    //回答回数をカウントする変数
    float ans_count;
    //現在のスコアをカウントする変数（ゲージに影響）
    int score;
    
    //回答文字を格納する配列
    NSMutableArray *char_list1;
    NSMutableArray *char_list2;
    NSMutableArray *char_list3;
    
    //問題を表示するラベル
    IBOutlet UILabel *quest;
    
    //回答する文字を表示するラベル
    IBOutlet UILabel *char_box1;
    IBOutlet UILabel *char_box2;
    IBOutlet UILabel *char_box3;
    
    //回答ボタン
    IBOutlet UIButton *go_shout;
    
    //回答する文字を選択するためのボタン
    IBOutlet UIButton *char_box1_up;
    IBOutlet UIButton *char_box2_up;
    IBOutlet UIButton *char_box3_up;
    IBOutlet UIButton *char_box1_down;
    IBOutlet UIButton *char_box2_down;
    IBOutlet UIButton *char_box3_down;
    
}
@synthesize char_box3;
@synthesize char_box2;
@synthesize char_box1;
@synthesize go_shout;
@synthesize char_box3_down;
@synthesize char_box2_down;
@synthesize char_box1_down;
@synthesize char_box3_up;
@synthesize char_box2_up;
@synthesize char_box1_up;
@synthesize shout_frame;
@synthesize quest;
@synthesize char_list1;
@synthesize char_list2;
@synthesize char_list3;



/*
 *ボタンが押されたら正否判定
 */
-(IBAction)GoShoutPush:(id)sender{
    
    //回答された文字を文字列に結合する
    NSString *ans;
    ans = [NSString stringWithFormat:@"%@%@%@",char_box1.text,char_box2.text,char_box3.text];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@",char_box1.text,char_box2.text,char_box3.text]);
    
    //問題の文字列を変数に格納する
    NSString *tem = quest.text;
    
    //回答と問題の文字列を比較する
    bool x = 0;
    x = [tem isEqualToString:ans];
    
    //回答された回数をカウントする
    ans_count = ans_count+1.0;
    NSLog(@"ans=%f",ans_count);
    
    int score_lv;
    if([defaults integerForKey:@"LV"]<15) score_lv=5;
    else score_lv=8;
    
    if(x){
        NSLog(@"ansx=%d",x);
        quest_count=quest_count+1.0;//回答があっていたら加点する
        [sound seikai];
        //スコアが１０点以下なら問題を続ける、終わったら経験値を算出して画面遷移する
        if(score<5){
            [self ShoutRandom];
            [self score];
        }else{
            [defaults setFloat:ans_count forKey:@"ans_count"];
            [defaults setFloat:quest_count forKey:@"quest_count"];
            
            ShoutViewController *ShoutVC;
            ShoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WakeUpViewController"];
            
            [self presentModalViewController:ShoutVC animated:NO];
            //printf("PushCount");
            [myTicker invalidate];
            [alarmPlayer stop];
            
            // [self exp];
        }
        
        
    }else{//回答が間違っていたら減点する
        if(quest_count>0){
            quest_count=quest_count-1;
            [sound miss];
        }
    }
    NSLog(@"count=%f",quest_count);
}



/*
 *問題のランダム表示（メソッドをランダムに指定）
 */
-(void)ShoutRandom{
    int random_shout;
    //レベルによって問題数を変化させる。
    if([defaults integerForKey:@"LV"]<15){
        //ランダムに問題を表示させる
        for(int i=0;i<10;i++){
            random_shout = arc4random() % 4;
            //NSLog(@"%d",random_shout);
        }
    }else{
        for(int i=0;i<10;i++){
            random_shout = arc4random() % 9;
            //NSLog(@"%d",random_shout);
        }
    }
    if(random_shout==0) [self shout_item_0];
    else if(random_shout==1) [self shout_item_1];
    else if(random_shout==2) [self shout_item_2];
    else if(random_shout==3) [self shout_item_3];
    else if(random_shout==4) [self shout_item_4];
    else if(random_shout==5) [self shout_item_5];
    else if(random_shout==6) [self shout_item_6];
    else if(random_shout==7) [self shout_item_7];
    else if(random_shout==8) [self shout_item_8];
    else if(random_shout==9) [self shout_item_9];

    //回答欄の文字をランダムに表示させる
    for(int i=0;i<7;i++){
        random_char1 = arc4random() % 4;
        //NSLog(@"%d",random_char1);
    }
    char_box1.text=[char_list1 objectAtIndex:random_char1];
    
    for(int i=0;i<8;i++){
        random_char2 = arc4random() % 4;
        //NSLog(@"%d",random_char2);
    }
    char_box2.text=[char_list2 objectAtIndex:random_char2];
    
    for(int i=0;i<5;i++){
        random_char3 = arc4random() % 4;
        //NSLog(@"%d",random_char3);
    }
    char_box3.text=[char_list3 objectAtIndex:random_char3];
    
}

/*
 *スコア管理するメソッド
 */

- (void)score{
    if([defaults integerForKey:@"LV"]<15){
        score = 10/3*quest_count;
    }else if([defaults integerForKey:@"LV"]>=15){
        score = 10/6*quest_count;
    }
}

/*
 *経験値を計算し、ユーザデフォルトに書き込む
 */
/*
-(void)exp{
    //現在の経験値を取得
    float exp_old=[defaults floatForKey:@"EXP"];
    NSLog(@"%f",exp_old);
    //今回の経験値とこれまでの経験値を足す
    float exp=(50.0/(ans_count/quest_count))+exp_old;
    NSLog(@"%f",exp);
    //合計経験値をユーザデフォルトに格納
    [defaults setFloat:exp forKey:@"EXP"];
}
*/


/*
 *問題：起きろ
 */
-(void)shout_item_0{
    //ラベルに問題を表示
    quest.text = @"起きろ";
    
    //配列の要素を初期化
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];

    [char_list1 insertObject:@"追" atIndex:0];
    [char_list1 insertObject:@"遅" atIndex:1];
    [char_list1 insertObject:@"進" atIndex:2];
    [char_list1 insertObject:@"起" atIndex:3];
    [char_list1 insertObject:@"超" atIndex:4];
    
    [char_list2 insertObject:@"な" atIndex:0];
    [char_list2 insertObject:@"さ" atIndex:1];
    [char_list2 insertObject:@"ち" atIndex:2];
    [char_list2 insertObject:@"つ" atIndex:3];
    [char_list2 insertObject:@"き" atIndex:4];
    
    [char_list3 insertObject:@"な" atIndex:0];
    [char_list3 insertObject:@"よ" atIndex:1];
    [char_list3 insertObject:@"る" atIndex:2];
    [char_list3 insertObject:@"ろ" atIndex:3];
    [char_list3 insertObject:@"て" atIndex:4];
}


/*
 *問題：遅刻だ
 */
-(void)shout_item_1{
    quest.text = @"遅刻だ";
    
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"週" atIndex:0];
    [char_list1 insertObject:@"進" atIndex:1];
    [char_list1 insertObject:@"朝" atIndex:2];
    [char_list1 insertObject:@"遅" atIndex:3];
    [char_list1 insertObject:@"起" atIndex:4];
    
    [char_list2 insertObject:@"坊" atIndex:0];
    [char_list2 insertObject:@"延" atIndex:1];
    [char_list2 insertObject:@"刻" atIndex:2];
    [char_list2 insertObject:@"床" atIndex:3];
    [char_list2 insertObject:@"就" atIndex:4];
    
    [char_list3 insertObject:@"な" atIndex:0];
    [char_list3 insertObject:@"だ" atIndex:1];
    [char_list3 insertObject:@"ち" atIndex:2];
    [char_list3 insertObject:@"よ" atIndex:3];
    [char_list3 insertObject:@"ね" atIndex:4];
    
}

/*
 *問題：寝るな
 */
-(void)shout_item_2{
    quest.text = @"寝るな";

    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"遅" atIndex:0];
    [char_list1 insertObject:@"寝" atIndex:1];
    [char_list1 insertObject:@"起" atIndex:2];
    [char_list1 insertObject:@"遊" atIndex:3];
    [char_list1 insertObject:@"朝" atIndex:4];
    
    [char_list2 insertObject:@"お" atIndex:0];
    [char_list2 insertObject:@"る" atIndex:1];
    [char_list2 insertObject:@"よ" atIndex:2];
    [char_list2 insertObject:@"ろ" atIndex:3];
    [char_list2 insertObject:@"た" atIndex:4];

    [char_list3 insertObject:@"よ" atIndex:0];
    [char_list3 insertObject:@"な" atIndex:1];
    [char_list3 insertObject:@"か" atIndex:2];
    [char_list3 insertObject:@"の" atIndex:3];
    [char_list3 insertObject:@"た" atIndex:4];
}

/*
 *問題：朝だよ
 */
-(void)shout_item_3{
    quest.text = @"朝だよ";
    
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"寝" atIndex:0];
    [char_list1 insertObject:@"起" atIndex:1];
    [char_list1 insertObject:@"遅" atIndex:2];
    [char_list1 insertObject:@"朝" atIndex:3];
    [char_list1 insertObject:@"朗" atIndex:4];
    
    [char_list2 insertObject:@"だ" atIndex:0];
    [char_list2 insertObject:@"か" atIndex:1];
    [char_list2 insertObject:@"で" atIndex:2];
    [char_list2 insertObject:@"な" atIndex:3];
    [char_list2 insertObject:@"た" atIndex:4];

    [char_list3 insertObject:@"の" atIndex:0];
    [char_list3 insertObject:@"す" atIndex:1];
    [char_list3 insertObject:@"ね" atIndex:2];
    [char_list3 insertObject:@"お" atIndex:3];
    [char_list3 insertObject:@"よ" atIndex:4];
}

/*
 *問題：遅れる
 */
-(void)shout_item_4{
    quest.text = @"遅れる";
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"遥" atIndex:0];
    [char_list1 insertObject:@"遅" atIndex:1];
    [char_list1 insertObject:@"逆" atIndex:2];
    [char_list1 insertObject:@"達" atIndex:3];
    [char_list1 insertObject:@"遠" atIndex:4];
    
    [char_list2 insertObject:@"わ" atIndex:0];
    [char_list2 insertObject:@"い" atIndex:1];
    [char_list2 insertObject:@"お" atIndex:2];
    [char_list2 insertObject:@"う" atIndex:3];
    [char_list2 insertObject:@"れ" atIndex:4];
    
    [char_list3 insertObject:@"ろ" atIndex:0];
    [char_list3 insertObject:@"な" atIndex:1];
    [char_list3 insertObject:@"る" atIndex:2];
    [char_list3 insertObject:@"よ" atIndex:3];
    [char_list3 insertObject:@"た" atIndex:4];
}


//以下、LVup時に追加される問題
/*
 *問題：頑張れ
 */
-(void)shout_item_5{
    quest.text = @"頑張れ";
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"須" atIndex:0];
    [char_list1 insertObject:@"頑" atIndex:1];
    [char_list1 insertObject:@"額" atIndex:2];
    [char_list1 insertObject:@"頬" atIndex:3];
    [char_list1 insertObject:@"順" atIndex:4];
    
    [char_list2 insertObject:@"帳" atIndex:0];
    [char_list2 insertObject:@"頂" atIndex:1];
    [char_list2 insertObject:@"弧" atIndex:2];
    [char_list2 insertObject:@"隊" atIndex:3];
    [char_list2 insertObject:@"張" atIndex:4];
    
    [char_list3 insertObject:@"よ" atIndex:0];
    [char_list3 insertObject:@"わ" atIndex:1];
    [char_list3 insertObject:@"れ" atIndex:2];
    [char_list3 insertObject:@"ら" atIndex:3];
    [char_list3 insertObject:@"お" atIndex:4];
}

/*
 *問題：朝ご飯
 */
-(void)shout_item_6{
    quest.text = @"朝ご飯";
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"韓" atIndex:0];
    [char_list1 insertObject:@"朝" atIndex:1];
    [char_list1 insertObject:@"朗" atIndex:2];
    [char_list1 insertObject:@"起" atIndex:3];
    [char_list1 insertObject:@"都" atIndex:4];
    
    [char_list2 insertObject:@"二" atIndex:0];
    [char_list2 insertObject:@"ご" atIndex:1];
    [char_list2 insertObject:@"御" atIndex:2];
    [char_list2 insertObject:@"こ" atIndex:3];
    [char_list2 insertObject:@"て" atIndex:4];
    
    [char_list3 insertObject:@"板" atIndex:0];
    [char_list3 insertObject:@"坂" atIndex:1];
    [char_list3 insertObject:@"飾" atIndex:2];
    [char_list3 insertObject:@"飯" atIndex:3];
    [char_list3 insertObject:@"版" atIndex:4];
}
/*
 *問題：目覚め
 */
-(void)shout_item_7{
    quest.text = @"目覚め";
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"貝" atIndex:0];
    [char_list1 insertObject:@"目" atIndex:1];
    [char_list1 insertObject:@"日" atIndex:2];
    [char_list1 insertObject:@"口" atIndex:3];
    [char_list1 insertObject:@"眼" atIndex:4];
    
    [char_list2 insertObject:@"冷" atIndex:0];
    [char_list2 insertObject:@"覚" atIndex:1];
    [char_list2 insertObject:@"筧" atIndex:2];
    [char_list2 insertObject:@"ざ" atIndex:3];
    [char_list2 insertObject:@"見" atIndex:4];
    
    [char_list3 insertObject:@"ぬ" atIndex:0];
    [char_list3 insertObject:@"ゆ" atIndex:1];
    [char_list3 insertObject:@"め" atIndex:2];
    [char_list3 insertObject:@"お" atIndex:3];
    [char_list3 insertObject:@"の" atIndex:4];
}


/*
 *問題：SUN
 */
-(void)shout_item_8{
    quest.text = @"ＳＵＮ";
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"Ｆ" atIndex:0];
    [char_list1 insertObject:@"Ｚ" atIndex:1];
    [char_list1 insertObject:@"Ｓ" atIndex:2];
    [char_list1 insertObject:@"Ｅ" atIndex:3];
    [char_list1 insertObject:@"Ｌ" atIndex:4];
    
    [char_list2 insertObject:@"Ｕ" atIndex:0];
    [char_list2 insertObject:@"Ｎ" atIndex:1];
    [char_list2 insertObject:@"Ｏ" atIndex:2];
    [char_list2 insertObject:@"Ａ" atIndex:3];
    [char_list2 insertObject:@"Ｊ" atIndex:4];
    
    [char_list3 insertObject:@"Ｍ" atIndex:0];
    [char_list3 insertObject:@"Ｉ" atIndex:1];
    [char_list3 insertObject:@"Ｄ" atIndex:2];
    [char_list3 insertObject:@"Ａ" atIndex:3];
    [char_list3 insertObject:@"Ｎ" atIndex:4];
}

/*
 *問題：おはよ
 */
-(void)shout_item_9{
    quest.text = @"おはよ";
    [char_list1 removeAllObjects];
    [char_list2 removeAllObjects];
    [char_list3 removeAllObjects];
    
    [char_list1 insertObject:@"ゆ" atIndex:0];
    [char_list1 insertObject:@"あ" atIndex:1];
    [char_list1 insertObject:@"さ" atIndex:2];
    [char_list1 insertObject:@"お" atIndex:3];
    [char_list1 insertObject:@"な" atIndex:4];
    
    [char_list2 insertObject:@"さ" atIndex:0];
    [char_list2 insertObject:@"は" atIndex:1];
    [char_list2 insertObject:@"ぽ" atIndex:2];
    [char_list2 insertObject:@"ぱ" atIndex:3];
    [char_list2 insertObject:@"な" atIndex:4];
    
    [char_list3 insertObject:@"お" atIndex:0];
    [char_list3 insertObject:@"る" atIndex:1];
    [char_list3 insertObject:@"ゆ" atIndex:2];
    [char_list3 insertObject:@"よ" atIndex:3];
    [char_list3 insertObject:@"ぬ" atIndex:4];
}

/*
 *各boxの文字をひとつ上げる
 */


-(IBAction)CharBox1UpPush:(id)sender{
    if(random_char1==4) random_char1=0;
    else random_char1=random_char1+1;
    char_box1.text=[char_list1 objectAtIndex:random_char1];
    //NSLog(@"%@",[char_list1 objectAtIndex:random_char1]);
    //[PPlayer play];
    [sound pi];
}


-(IBAction)CharBox2UpPush:(id)sender{
    if(random_char2==4) random_char2=0;
    else random_char2=random_char2+1;
    char_box2.text=[char_list2 objectAtIndex:random_char2];
    //[PPlayer play];
    [sound pi];
}


-(IBAction)CharBox3UpPush:(id)sender{
    if(random_char3==4) random_char3=0;
    else random_char3=random_char3+1;
    char_box3.text=[char_list3 objectAtIndex:random_char3];
    //[PPlayer play];
     [sound pi];
}

/*
 *各boxの文字をひとつ下に下げる
 */


-(IBAction)CharBox1DownPush:(id)sender{
    if(random_char1==0) random_char1=4;
    else random_char1=random_char1-1;
    char_box1.text=[char_list1 objectAtIndex:random_char1];
    //[PPlayer play];
    [sound pi];
}


-(IBAction)CharBox2DownPush:(id)sender{
    if(random_char2==0) random_char2=4;
    else random_char2=random_char2-1;
    char_box2.text=[char_list2 objectAtIndex:random_char2];
    //[PPlayer play];
    [sound pi];
}



-(IBAction)CharBox3DownPush:(id)sender{
    if(random_char3==0) random_char3=4;
    else random_char3=random_char3-1;
    char_box3.text=[char_list3 objectAtIndex:random_char3];
    //[PPlayer play];
    [sound pi];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sound = [Audio initAudio];
    
    
    //ユーザデフォルト領域へのアクセス
    defaults = [NSUserDefaults standardUserDefaults];
    //正答回数をカウント
    quest_count = 0;
    ans_count = 0;
    score = 0;
    //各配列の要素を代入しておく
    char_list1 = [NSMutableArray arrayWithObjects:@"叫",@".",@".",@".",@".", nil];
    char_list2 = [NSMutableArray arrayWithObjects:@"べ",@".",@".",@".",@".", nil];
    char_list3 = [NSMutableArray arrayWithObjects:@"！",@".",@".",@".",@".", nil];
    //各ラベルに配列の値が入っている状態にする
    char_box1.text=[char_list1 objectAtIndex:0];
    char_box2.text=[char_list2 objectAtIndex:0];
    char_box3.text=[char_list3 objectAtIndex:0];
    //最初の問題を表示する
    [self ShoutRandom];
    
    
    //時計の更新。0.5秒ごとにshowDateメソッドを呼び出す
    myTicker = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                target:self
                                              selector:@selector(driveClock:)
                                              userInfo:nil
                                               repeats:YES];
    
    
    //アラーム鳴らす
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ro1_003" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    alarmPlayer.numberOfLoops = -1;
    [alarmPlayer play];
    
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"ta_ta_pi03" ofType:@"mp3"];
    NSURL *url2 = [NSURL fileURLWithPath:path2];
    PPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    PPlayer.numberOfLoops = 0;
    
    

}

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
    [self setQuest:nil];
    [self setShout_frame:nil];
    [self setChar_box1_up:nil];
    [self setChar_box2_up:nil];
    [self setChar_box3_up:nil];
    [self setChar_box1_down:nil];
    [self setChar_box2_down:nil];
    [self setChar_box3_down:nil];
    [self setGo_shout:nil];
    [self setChar_box1:nil];
    [self setChar_box2:nil];
    [self setChar_box3:nil];
    [self setChar_list1:nil];
    [self setChar_list2:nil];
    [self setChar_list3:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
