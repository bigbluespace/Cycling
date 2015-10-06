//
//  RootViewController.m
//  Cycling
//
//  Created by Rezaul Karim on 24/9/15.
//  Copyright (c) 2015 Rezaul Karim. All rights reserved.
//

#import "Home.h"
#import "RESideMenu/RESideMenu.h"

#define METERS_PER_MILE 1609.344
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface Home (){
    MKPlacemark *source;
    double rout_distance;
}
@property (weak, nonatomic) IBOutlet UIView *overlapView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIView *topSpeed;
@property (weak, nonatomic) IBOutlet UIView *avgSpeed;
@property (weak, nonatomic) IBOutlet UIView *distance;
@property (weak, nonatomic) IBOutlet UIView *elapsedTime;
@property (weak, nonatomic) IBOutlet UIView *avgAltitude;
@property (weak, nonatomic) IBOutlet UIView *maxAltitude;

@property (weak, nonatomic) IBOutlet UILabel *distanceLbl;


@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _overlapView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.65];
    _avatarImg.layer.borderWidth =_topSpeed.layer.borderWidth = _avgSpeed.layer.borderWidth = _distance.layer.borderWidth = _elapsedTime.layer.borderWidth = _avgAltitude.layer.borderWidth = _maxAltitude.layer.borderWidth = 1;
    
    _avatarImg.layer.borderColor =_topSpeed.layer.borderColor = _avgSpeed.layer.borderColor = _distance.layer.borderColor = _elapsedTime.layer.borderColor = _avgAltitude.layer.borderColor = _maxAltitude.layer.borderColor = [UIColor lightGrayColor].CGColor;
    

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    #ifdef __IPHONE_8_0
        if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
        }
    #endif
    
    
    _mapview.showsUserLocation = YES;
    [_mapview setMapType:MKMapTypeStandard];
    [_mapview setZoomEnabled:YES];
    [_mapview setScrollEnabled:YES];
    
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouchTap:)];
    [self.view addGestureRecognizer:touchTap];
}


- (IBAction)menuBtn:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}

-(void)tapTouchTap:(UITapGestureRecognizer*)touchGesture
{
   
        CGPoint point = [touchGesture locationInView:_mapview];
        
        CLLocationCoordinate2D tapPoint = [_mapview convertPoint:point toCoordinateFromView:_mapview];
        
        MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
        
        point1.coordinate = tapPoint;
        
        point1.subtitle = [NSString stringWithFormat:@"Lat: %f, Long: %f",tapPoint.latitude, tapPoint.longitude];
        [_mapview addAnnotation:point1];
    
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(tapPoint.latitude, tapPoint.longitude) addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    [self makeLine:destination];
    NSLog(@"%f %f", point1.coordinate.latitude, point1.coordinate.longitude);
}

- (void)viewWillAppear:(BOOL)animated {
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    rout_distance = 0;
}

- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(UIView *)view{
    
    CGPoint annPoint = [_mapview convertCoordinate:coordinate toPointToView:self.view];
    NSLog(@"Destination %f  %f", coordinate.latitude, coordinate.longitude);
    return annPoint;
}

- (IBAction)startBtn:(id)sender {
    if (!_playBtn.isSelected) {
        [_locationManager startUpdatingLocation];
        [_locationManager stopMonitoringSignificantLocationChanges];
    }else{
        [_locationManager stopUpdatingLocation];
        [_locationManager startMonitoringSignificantLocationChanges];
    }
    _playBtn.selected = !_playBtn.isSelected;
    NSLog(@"%@", [self deviceLocation]);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapview setRegion:[self.mapview regionThatFits:region] animated:YES];
    
}

- (NSString *)deviceLocation {
   
    source = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(_locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude) addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)makeLine:(MKPlacemark*)destination{
    
    MKMapItem *srcMapItem = [[MKMapItem alloc]initWithPlacemark:source];
    [srcMapItem setName:@""];
    
    MKMapItem *distMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    [distMapItem setName:@""];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:srcMapItem];
    [request setDestination:distMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        NSLog(@"response = %@",response);
        NSArray *arrRoutes = [response routes];
        [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MKRoute *rout = obj;
            
            MKPolyline *line = [rout polyline];
            [_mapview addOverlay:line];
            NSLog(@"Rout Name : %@",rout.name);
            NSLog(@"Total Distance (in Meters) :%f",rout.distance);
            rout_distance += rout.distance;
            NSString *distanceInMile = [NSString stringWithFormat:@"%.2f miles", (rout_distance*0.000621371)];
            _distanceLbl.text = distanceInMile;
            
            NSArray *steps = [rout steps];
            
            NSLog(@"Total Steps : %lu",(unsigned long)[steps count]);
            
            [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                NSLog(@"Rout Instruction : %@",[obj instructions]);
                NSLog(@"Rout Distance : %@",obj);
                source = destination;
            }];
        }];
    }];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* aView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline*)overlay] ;
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        aView.lineWidth = 10;
        return aView;
    }
    return nil;
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
