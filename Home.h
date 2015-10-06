//
//  RootViewController.h
//  Cycling
//
//  Created by Rezaul Karim on 24/9/15.
//  Copyright (c) 2015 Rezaul Karim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

@interface Home : UIViewController<MKMapViewDelegate,  CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property(nonatomic, retain) CLLocationManager *locationManager;

@end
