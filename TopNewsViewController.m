//
//  TopNewsViewController.m
//  PTLiveNew
//
//  Created by Saravanakumar on 15/06/17.
//  Copyright © 2017 NuaTransMedia. All rights reserved.
//

#import "TopNewsViewController.h"
#import "Constant.h"
#import <AVFoundation/AVFoundation.h>
@interface TopNewsViewController ()
{
    AVPlayer *avPlayer;
}
@end

@implementation TopNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    muarrTopNews = [NSMutableArray new];
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveliveplayer:)
                                                 name:@"songsplaying"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveliveplayerstop:)
                                                 name:@"songsplayingstop"
                                               object:nil];
    
    
    

    
    [self funcHeaderPlayer];
    // Do any additional setup after loading the view.
}


- (void) receiveliveplayer:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"songsplaying"])
    {
        NSLog (@"Successfully received the test notification!");
        
        [self funcHeaderPlayer];
        
    }
    else
    {
        
    }
}

-(void)receiveliveplayerstop:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"songsplayingstop"])
    {
        NSLog (@"Successfully received the test notification!");
        [self funcHeaderPlayerStop];
    }
    else
    {
        
    }
}


-(void)funcHeaderPlayerStop
{
     [avPlayer pause];
}




-(void)funcHeaderPlayer
{
    // *** create AVAsset using URL ***
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:@"http://puthiyathalaimurai.live-s.cdn.bitgravity.com/cdn-live/_definst_/puthiyathalaimurai/live/ptm_mobile.smil/playlist.m3u8"]];
    
    // *** Create AVPlayerItem using AVAsset ***
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    
    // *** Initialise AVPlayer ***
  avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    
    // *** Add AVPlayer to ViewController ***
    AVPlayerLayer *avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    avPlayerLayer.frame = self.viwHeaderPlayer.bounds;
    [avPlayerLayer setBackgroundColor:[UIColor grayColor].CGColor];
    [self.viwHeaderPlayer.layer addSublayer:avPlayerLayer];
    
    // *** Start Playback ***
    [avPlayer play];
    
    // *** Register for playback end notification ***
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avPlayer currentItem]];
    
    // *** Register observer for events of AVPlayer status ***
    [avPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
}


// *** Observe status event and perform actions ***
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == avPlayer && [keyPath isEqualToString:@"status"]) {
        if (avPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (avPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [avPlayer play];
            
            
        } else if (avPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
    }
}





-(void)viewWillAppear:(BOOL)animated
{
     [self funcLatestNewsAndURL];
}


-(void)funcLatestNewsAndURL
{
    
    
    NSURL *strUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",PT_TOPNEWS_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:strUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            // update your UI here
            [self func_reponseLatestNewsData:data];
            
        }];
    }];
    
}

-(void)func_reponseLatestNewsData:(NSData *)response
{
   
    
    if (response!=nil)
    {
        NSDictionary *diJson = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *arr_Contain = [[diJson valueForKey:@"section"] valueForKey:@"news"];
        
        NSInteger arr_containCount = [arr_Contain count]; //Array Count Values
        
        for (int i=0; i<arr_containCount; i++)
        {
            
            NSString *str_title = [NSString stringWithFormat:@"%@",[[arr_Contain objectAtIndex:i] valueForKey:@"title"]];
            NSString *str_description = [NSString stringWithFormat:@"%@",[[arr_Contain objectAtIndex:i] valueForKey:@"description"]];
            NSString *str_entryid = [NSString stringWithFormat:@"%@",[[arr_Contain objectAtIndex:i] valueForKey:@"entry_id"]];
            NSString *str_date = [NSString stringWithFormat:@"%@",[[arr_Contain objectAtIndex:i] valueForKey:@"date"]];
            NSString *str_imageSmall = [NSString stringWithFormat:@"%@",[[[[arr_Contain objectAtIndex:i] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"small"]];
            NSString *str_imageMedium = [NSString stringWithFormat:@"%@",[[[[arr_Contain objectAtIndex:i] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"medium"]];
            NSString *str_imageLarge = [NSString stringWithFormat:@"%@",[[[[arr_Contain objectAtIndex:i] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"large"]];
            
            
            NSArray *splitDate = [str_date componentsSeparatedByString:@","];
            
            NSString *strdateTwo = [NSString stringWithFormat:@"%@",splitDate[0]];
            
            NSArray *splitDateTwo  = [strdateTwo componentsSeparatedByString:@"-"];
            
            
            NSString *strdateSpliteTwo = [NSString stringWithFormat:@"%@-%@-%@",splitDateTwo[1],splitDateTwo[0],splitDate[1]];
            
            
            
            
            NSInteger valCo = [[[arr_Contain objectAtIndex:i] valueForKey:@"video"] count];
            
            NSString *str_video;
            if (valCo!=0)
            {
                str_video = [NSString stringWithFormat:@"%@",[[[[arr_Contain objectAtIndex:i] valueForKey:@"video"] objectAtIndex:0] valueForKey:@"video"]];
                
            }
            else
            {
                str_video = @"";
            }
            
            NSString *str_count = [NSString stringWithFormat:@"%d",i];
            
            
            
            
            
                tempDict = [NSDictionary dictionaryWithObjectsAndKeys:str_title,@"title",str_description,@"description",str_entryid,@"entry_id",strdateSpliteTwo,@"strdate",str_imageSmall,@"smallimage",str_imageMedium,@"mediumimage",str_imageLarge,@"largeimage",str_count,@"countval",str_video,@"videos",nil];
                
                
                
                [muarrTopNews addObject:tempDict];
            
            
            
        }
        [_tableview reloadData];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [muarrTopNews count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *imgmenu = (UIImageView *)[cell viewWithTag:1];
    UILabel *lblmenu = (UILabel *)[cell viewWithTag:2];
    NSString *strArrVal = [NSString stringWithFormat:@"%@",[[muarrTopNews objectAtIndex:indexPath.row] valueForKey:@"mediumimage"]];
    
    [imgmenu sd_setImageWithURL:[NSURL URLWithString:strArrVal]
                       placeholderImage:[UIImage imageNamed:@"Water146x169.png"]];
    
    
    lblmenu.text = [NSString stringWithFormat:@"%@",[[muarrTopNews objectAtIndex:indexPath.row] valueForKey:@"title"]];
    
    
    
    return cell;
}






















@end
