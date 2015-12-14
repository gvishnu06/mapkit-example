//
//  LocationManager.m
//  mapkitExample
//
//  Created by Vishnu on 14/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import "LocationManager.h"

static LocationManager  *singletonObject = nil;

@implementation LocationManager
{
    CLGeocoder* geocoder;
}
+ (id) sharedInstance
{
    if (! singletonObject) {
        
        singletonObject = [[LocationManager alloc] init];
    }
    return singletonObject;
}

- (id) init
{
    if (! singletonObject) {
        singletonObject = [super init];
        _iosLocationManager = [[CLLocationManager alloc] init];
        _iosLocationManager.delegate = self;
        float version  =  [[[UIDevice currentDevice] systemVersion] floatValue];
        if(version>=8.0)
        {
            [_iosLocationManager requestWhenInUseAuthorization];
        }
        _defaultLocation = [[CLLocation alloc] initWithLatitude:15.354363 longitude:73.930102];
        _tracker = false;
    }
    return singletonObject;
}

-(void)getLocation:(NSString*)address
{
    if (geocoder == nil) {
        geocoder = [[CLGeocoder alloc] init];
    }
    [geocoder geocodeAddressString:address
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if(error!=nil)
                     {
                         [self.delegate addressFailed];
                     }
                     else
                     {
                         CLPlacemark* placemark = placemarks[0];
                         if(placemark!=nil)
                         {
                             _searchLocation = placemark.location;
                             [self.delegate addressUpdated];
                         }
                         else
                         {
                             [self.delegate addressFailed];
                         }
                     }
                 }];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
        } break;
        case kCLAuthorizationStatusDenied: {
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            if(self.tracker)
            {
                [_iosLocationManager startUpdatingLocation];
            }
        } break;
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation* currentLocation = locations.lastObject;
    MKCoordinateRegion region;
    region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 50, 50);
    [self.delegate locationupdated:region];
}
@end
