//
//  LocationManager.h
//  mapkitExample
//
//  Created by Vishnu on 14/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol LocationManagerProtocol <NSObject>

-(void)locationupdated:(MKCoordinateRegion)region;
-(void)addressFailed;
-(void)addressUpdated;

@end

@interface LocationManager : NSObject<CLLocationManagerDelegate>
@property CLLocationManager* iosLocationManager;
@property CLLocation* defaultLocation;
@property CLLocation* searchLocation;
@property id <LocationManagerProtocol> delegate;
@property BOOL tracker;
+ (id) sharedInstance;
-(void)getLocation:(NSString*)address;
@end
