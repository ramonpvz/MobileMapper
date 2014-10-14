//
//  ViewController.m
//  MobileMapper
//
//  Created by GLBMXM0002 on 10/14/14.
//  Copyright (c) 2014 asda. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//Represents a pin in the "map"
@property MKPointAnnotation *mobileMakersAnnotation;
@property CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    
    CLLocationCoordinate2D coord;
    coord.latitude = 41.89373984;
    coord.longitude = -87.63532979;
    
    self.mobileMakersAnnotation = [[MKPointAnnotation alloc] init];
    self.mobileMakersAnnotation.coordinate = coord;
    self.mobileMakersAnnotation.title = @"Mobile Makers";
    [self.mapView addAnnotation: self.mobileMakersAnnotation];
    [self addMountRushmorePin];
}

- (void) addMountRushmorePin
{
    CLGeocoder *geocoder =[[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:@"Franklin" completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         for (CLPlacemark *placemark in placemarks) {
             MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
             annotation.coordinate = placemark.location.coordinate;
             [self.mapView addAnnotation:annotation];
         }
     }];
}

//Does not break as the table view (There is no array)
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if (annotation == mapView.userLocation) {
        return nil;
    }

    //pointer to any method...
    MKPinAnnotationView *pin = [[[MKPinAnnotationView alloc] init] initWithAnnotation:annotation reuseIdentifier:@"MyPinID"];
    
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pin.image = [UIImage imageNamed:@"mobilemakers"]; //Images.xcassets deleted but anyways...
    
    return pin;

}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    CLLocationCoordinate2D center = view.annotation.coordinate;
    
    MKCoordinateSpan span;
    span.latitudeDelta  = 0.01;
    span.longitudeDelta = 0.01;
    
    MKCoordinateRegion region;
    region.center = center;
    region.span = span;
    
    [self.mapView setRegion:region animated:YES];
    
}

@end
