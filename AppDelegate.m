//
//  AppDelegate.m
//  Cycling
//
//  Created by Rezaul Karim on 24/9/15.
//  Copyright (c) 2015 Rezaul Karim. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self LocationUpdate];
    return YES;
}

-(void)LocationUpdate{
    //Create a new location manager
    _locationManager = [[CLLocationManager alloc] init];
    // Set Location Manager delegate
    [_locationManager setDelegate:self];
    // Set location accuracy levels
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    // Update again when a user moves distance in meters
    [_locationManager setDistanceFilter:1000];
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
        //[_locationManager requestAlwaysAuthorization];
    }
    // Start updating location
    //[_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    CLLocationDegrees lat = newLocation.coordinate.latitude;
    CLLocationDegrees lng = newLocation.coordinate.longitude;
    
    NSLog(@"%f \n  %f", lat, lng);
    
    NSDate *toDay = [[NSDate alloc]init];
    if ([toDay timeIntervalSinceDate:newLocation.timestamp] < 30.0f)
    {
//        [_locationManager stopUpdatingLocation];
//        [_locationManager startMonitoringSignificantLocationChanges];
    }
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"locationManager didChangeAuthorizationStatus");
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"location error: didFailWithError %@",error);
    switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please check your network connection." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
            break;
        case kCLErrorDenied:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You have to enable the Location Service to use this App. To enable, please go to Settings->Privacy->Location Services" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
        {
            
        }
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [_locationManager stopUpdatingLocation];
    // Only monitor significant changes
    [_locationManager startMonitoringSignificantLocationChanges];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //[_locationManager stopMonitoringSignificantLocationChanges];
    //[_locationManager startUpdatingLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
