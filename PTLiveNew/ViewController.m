//
//  ViewController.m
//  PTLiveNew
//
//  Created by Saravanakumar on 15/06/17.
//  Copyright © 2017 NuaTransMedia. All rights reserved.
//

#import "ViewController.h"
#import "MFSideMenu.h"
#import "TTScrollSlidingPagesController.h"
#import "TTSlidingPage.h"
#import "TTSlidingPageTitle.h"
@interface ViewController ()
@property (strong, nonatomic) TTScrollSlidingPagesController *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
    // Do any additional setup after loading the view, typically from a nib.
    
    
    viewPagerTitleName = @[@"TOP STORIES", @"LATEST NEWS", @"TAMIL NADU",@"INDIA",@"INTERNATIONAL",@"SPORTS",@"CINEMA",@"TECHNOLOGY",@"PROGRAMMES",@"INFOTAINMENT PROGRAMMES"];
    
    //ViewPager
    
    [self funcSliderViewPager];
    
    
}


-(void)funcSliderViewPager{
    
    
    self.slider = [[TTScrollSlidingPagesController alloc] init];
    self.slider.titleScrollerInActiveTextColour = [UIColor whiteColor];
    //self.slider.titleScrollerBottomEdgeColour = [UIColor colorWithRed:0.867 green:0.459 blue:0.063 alpha:1];
    ;
    self.slider.titleScrollerTextColour=[UIColor whiteColor];
    //self.slider.titleScrollerBottomEdgeHeight = 200;
    
    
    
    self.slider.hideStatusBarWhenScrolling = NO;
    
    self.slider.titleScrollerHeight = 50;
    
    
    
    //self.slider.titleScrollerBackgroundColour = [UIColor colorWithRed: 0.0 green:0.0 blue:0.0 alpha:0.0];
    self.slider.titleScrollerBackgroundColour = [UIColor colorWithRed:(174.0/255.0) green:(7.0/255.0) blue:(14.0/255.0) alpha:1];
    self.slider.disableTitleScrollerShadow = YES;
    self.slider.disableUIPageControl = YES;
    self.slider.initialPageNumber = 0;
    self.slider.zoomOutAnimationDisabled = YES;
    self.slider.disableTitleShadow = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
        self.slider.hideStatusBarWhenScrolling = YES;//this property normally only makes sense on
    }
    
    
    self.slider.dataSource = self;
    
    self.slider.view.frame = CGRectMake(0,0,_ViewPager.frame.size.width,_ViewPager.frame.size.height);
    [_ViewPager addSubview:self.slider.view];
    [self addChildViewController:self.slider];
    
}
#pragma mark TTSlidingPagesDataSource methods
-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 10; //just return 7 pages as an example
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    UIStoryboard *mainStoryboards;
    UIViewController *viewController;
        mainStoryboards =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        if (index == 0)
        { //just an example, alternating views between one example table view and another.
            viewController =  [mainStoryboards instantiateViewControllerWithIdentifier:@"TopNews"];
        }
        else if (index == 1)
        {
            viewController = [mainStoryboards instantiateViewControllerWithIdentifier:@"LatestView"];
        }
        else if (index == 2)
        {
            viewController = [mainStoryboards instantiateViewControllerWithIdentifier:@"statenews"];
        }
        else if (index == 3)
        {
            //cinemanews
            
            viewController = [mainStoryboards instantiateViewControllerWithIdentifier:@"TopNews"];
        }
        else if (index == 4)
        {
            viewController = [mainStoryboards instantiateViewControllerWithIdentifier:@"TopNews"];
        }
        else if(index == 5)
        { //namadhulivetv
            viewController = [mainStoryboards instantiateViewControllerWithIdentifier:@"TopNews"];
            
        }
        else if(index == 6)
        { //namadhulivetv
            viewController = [mainStoryboards instantiateViewControllerWithIdentifier:@"TopNews"];
            
        }
        
    
    
    
    
    return [[TTSlidingPage alloc] initWithContentViewController:viewController];
}
-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    TTSlidingPageTitle *title;
    
    if (index == 0){
         title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"TOP STORIES"];
    }
    else
    {
  
        switch (index) {
            case 1:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"LATEST NEWS"];
                // title = [[TTSlidingPageTitle alloc] initWithHeaderText:str_two];
                break;
            case 2:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"TAMIL NADU"];
                break;
            case 3:
                //  title = [[TTSlidingPageTitle alloc] initWithHeaderText:str_four];
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"INDIA"];
                break;
            case 4:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"INTERNATIONAL"];
                break;
            case 5:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"SPORTS"];
                break;
            case 6:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"CINEMA"];
                break;
            case 7:
                 title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"TECHNOLOGY"];
                break;
            case 8:
                 title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"PROGRAMMES"];
                break;
            case 9:
                  title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"INFOTAINMENT"];
                break;
                
        
        }
    }
    return title;
}




- (IBAction)btnMenu:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}


@end
