
//  Created by Arif on 9/7/14.
//  Copyright (c) 2014 Trena. All rights reserved.
//

#import "LeftMenu.h"
#import "UIViewController+RESideMenu.h"

#define IPAD     UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface LeftMenu (){
    NSMutableArray *titleList;
    NSMutableArray *imageList;
    NSMutableDictionary *user;
  //  SaveSearchList *saveSearchList;
    UILabel *countLabel;
   // NSString *dataType;
///arif//hsbf,jhgjeejhkjktdhgzjkdhgfjshgjkdh tamal
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *companyLogo;

@end


@implementation LeftMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleList = [[NSMutableArray alloc] initWithArray: @[@"Home", @"Tutorial",@"Event List",@"Event Result", @"My Profile", @"Settings",@"About Us"]];
    
    UIView *header = _tableView.tableHeaderView;
    CGRect headerFrame           = header.frame;
    headerFrame.size.height      = IPAD ? 250 : 375;//144
    header.frame            = headerFrame;
    _tableView.tableHeaderView = header;
    _tableView.tableHeaderView = _tableView.tableHeaderView;
    
    
    
    
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Setlogo:) name:@"companyLogo" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"logOut" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SetMsgCount:) name:@"msgCount" object:nil];
    
//    user = [Zonin readData:@"auth"];
//    if (user == nil) {
//        return;
//    }
//       
//    if ([user valueForKey:@"logo"] != [NSNull null]) {
//        [_companyLogo setImageWithURL:[NSURL URLWithString:[user valueForKey:@"logo"]]];
//    }
//    
//    _companyLogo.layer.cornerRadius = IPAD? 75 : 50;
//    _companyLogo.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)Setlogo:(NSNotification*)notification {
//    if([[notification userInfo] valueForKey:@"logo"] != (id)[NSNull null] && ![[[notification userInfo] valueForKey:@"logo"] isEqualToString:@""]){
//        [_companyLogo setImage:nil];
//        [_companyLogo setImageWithURL:[NSURL URLWithString:[[notification userInfo] valueForKey:@"logo"]] placeholderImage:[UIImage imageNamed:@"logoLoading"]];
//         _companyLogo.layer.cornerRadius = IPAD? 75 : 50;
//        
//    }else{
//        [_companyLogo setImage:nil];
//        [_companyLogo setImage:[UIImage imageNamed:@"no_logo"]];
//         _companyLogo.layer.cornerRadius = IPAD? 75 : 50;
//    }
//}



//-(void)SetMsgCount:(NSNotification*)notification {
//    if (countLabel != nil) {
//        if ([[[notification userInfo] valueForKey:@"count"] integerValue]>0) {
//            countLabel.hidden = NO;
//        } else
//            countLabel.hidden = YES;
//        NSLog(@"%@", [[notification userInfo] valueForKey:@"count"]);
//        countLabel.layer.cornerRadius = IPAD? 12 : 8;
//        countLabel.text = [NSString stringWithFormat:@"%@",[[notification userInfo] valueForKey:@"count"]];
//        
//    }
//}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IPAD )
        return 90;
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"leftRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:10];
    titleLabel.text = [titleList objectAtIndex:indexPath.row];
    
   
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"home"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
       /* case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"newslistvc"]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
            break;

        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"addCrimeView"]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"addReViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
            
            break;
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"reportOptonVC"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 5:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 6:
             [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"searchVC"]]
                                                                      animated:YES];
             [self.sideMenuViewController hideMenuViewController];
             break;
        case 7:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"forumViewBoard"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 8:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"about"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 9:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"settings"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
           */
        default:
            break;
            
    }
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([segue.identifier isEqualToString:@"registerTutorial"]) {
//        TutorialViewController *tc = (TutorialViewController*)segue.destinationViewController;
//        //popup.searchData = finalSearchParam;
//        //NSLog(@"param %@", finalSearchParam);
//    }
}


-(void)logout{
    
//    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewStoryboard"];
//    [self.sideMenuViewController hideMenuViewController];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"auth"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"msgObject"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"packageDetails"];   
//    self.sideMenuViewController.panGestureEnabled = NO;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
