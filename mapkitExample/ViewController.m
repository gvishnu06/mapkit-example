//
//  ViewController.m
//  mapkitExample
//
//  Created by Vishnu on 14/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    LocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [LocationManager sharedInstance];
    locationManager.delegate = self;
    [_outMapView setShowsUserLocation:false];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(locationManager.defaultLocation.coordinate, 500, 500);
    [_outMapView setRegion:region animated:true];
    _outLocationField.delegate = self;
    self.outActivityIndicator.hidden = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [_outLocationField resignFirstResponder];
}

-(void)locationupdated:(MKCoordinateRegion)region
{
    [_outMapView setRegion:region animated:true];
}

-(void)addressFailed
{
    [self hideProgress];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Invalid address!!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:true completion:^{
        
    }];
}

-(void)addressUpdated
{
    [self hideProgress];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(locationManager.searchLocation.coordinate, 500, 500);
    [_outMapView setRegion:region animated:true];
}

- (IBAction)actionLocationEntered:(id)sender {
}

- (IBAction)actionTrackMw:(id)sender {
    if (_outMapView.showsUserLocation) {
        [locationManager.iosLocationManager stopUpdatingLocation];
        [self.outTrackBtn setTitle:@"Track Me" forState:UIControlStateNormal];
    }
    else
    {
        [locationManager.iosLocationManager startUpdatingLocation];
        [self.outTrackBtn setTitle:@"Stop" forState:UIControlStateNormal];
    }
    locationManager.tracker = !_outMapView.showsUserLocation;
    [_outMapView setShowsUserLocation:!_outMapView.showsUserLocation];
}

- (IBAction)actionTraffic:(id)sender {
    if (_outMapView.mapType == MKMapTypeStandard)
    {
        _outMapView.mapType = MKMapTypeHybrid;
        [self.outTypeBtn setTitle:@"Standard" forState:UIControlStateNormal];
    }
    else
    {
        _outMapView.mapType = MKMapTypeStandard;
        [self.outTypeBtn setTitle:@"Hybrid" forState:UIControlStateNormal];
    }
    _outMapView.mapType = MKMapTypeHybrid;
}

-(void)startProgress
{
    self.outActivityIndicator.hidden = false;
    [_outActivityIndicator startAnimating];
    self.view.userInteractionEnabled = false;
}

-(void)hideProgress
{
    if(_outActivityIndicator != nil)
    {
        [_outActivityIndicator stopAnimating];
        self.outActivityIndicator.hidden = true;
    }self.view.userInteractionEnabled = true;
}

- (IBAction)actionLocation:(id)sender {
    [_outMapView setShowsUserLocation:false];
    [locationManager.iosLocationManager stopUpdatingLocation];
    locationManager.tracker = false;
    [self.outTrackBtn setTitle:@"Track Me" forState:UIControlStateNormal];
    _outMapView.mapType = MKMapTypeStandard;
    [self.outTypeBtn setTitle:@"Hybrid" forState:UIControlStateNormal];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(locationManager.defaultLocation.coordinate, 500, 500);
    [_outMapView setRegion:region animated:true];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.outLocationField resignFirstResponder];
    if (![textField.text isEqualToString:@""]) {
        [self startProgress];
        [locationManager getLocation:textField.text];
    }
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.outLocationField becomeFirstResponder];
}
@end
