//
//  AppDelegate.h
//  Cycling
//
//  Created by Rezaul Karim on 24/9/15.
//  Copyright (c) 2015 Rezaul Karim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end

