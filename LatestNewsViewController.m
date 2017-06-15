//
//  LatestNewsViewController.m
//  PTLiveNew
//
//  Created by Saravanakumar on 15/06/17.
//  Copyright © 2017 NuaTransMedia. All rights reserved.
//

#import "LatestNewsViewController.h"
#import "Constant.h"
@interface LatestNewsViewController ()

@end

@implementation LatestNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    muarrLatestNews = [NSMutableArray new];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self funcLatesNewsAndURL];
}
#pragma mark ---------- Get Top News -------
-(void)funcLatesNewsAndURL
{
    NSURL *strUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",PT_LATESTNEWS_URL]];
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
            //NSLog(@"str_imageSmall:%@",str_imageSmall);
            
            
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
            
            
            
                tempDictLatestNews = [NSDictionary dictionaryWithObjectsAndKeys:str_title,@"title",str_description,@"description",str_entryid,@"entry_id",str_date,@"strdate",str_imageSmall,@"smallimage",str_imageMedium,@"mediumimage",str_imageLarge,@"largeimage",str_video,@"videos", nil];
                
                [muarrLatestNews addObject:tempDictLatestNews];
           
            
        }
        
         [_LatestView reloadData];
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [muarrLatestNews count];
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
    NSString *strArrVal = [NSString stringWithFormat:@"%@",[[muarrLatestNews objectAtIndex:indexPath.row] valueForKey:@"mediumimage"]];
    
    [imgmenu sd_setImageWithURL:[NSURL URLWithString:strArrVal]
               placeholderImage:[UIImage imageNamed:@"Water146x169.png"]];
    
    
    lblmenu.text = [NSString stringWithFormat:@"%@",[[muarrLatestNews objectAtIndex:indexPath.row] valueForKey:@"title"]];
    
    
    
    return cell;
}



@end
