//
//  ViewController.h
//  mapkitExample
//
//  Created by Vishnu on 14/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationManager.h"

@interface ViewController : UIViewController<LocationManagerProtocol, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *outLocationField;
@property (weak, nonatomic) IBOutlet UIButton *outTrackBtn;
@property (weak, nonatomic) IBOutlet UIButton *outResetBtn;
@property (weak, nonatomic) IBOutlet UIButton *outTypeBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *outActivityIndicator;

@property (weak, nonatomic) IBOutlet MKMapView *outMapView;
- (IBAction)actionLocationEntered:(id)sender;
- (IBAction)actionTrackMw:(id)sender;
- (IBAction)actionTraffic:(id)sender;
- (IBAction)actionLocation:(id)sender;

@end

