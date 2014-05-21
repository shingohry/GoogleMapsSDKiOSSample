//
//  ViewController.m
//  GoogleMapsSample
//
//  Created by hiraya.shingo on 2014/05/20.
//
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

static NSInteger const markerIdClassmethod      = 1;
static NSInteger const markerIdYodobashi        = 2;
static NSInteger const markerIdAkihabaraStation = 3;
static NSInteger const markerIdDenkigai         = 4;

@interface ViewController () <GMSMapViewDelegate>

@property (strong, nonatomic) GMSMapView *mapView;

@end

@implementation ViewController

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // (1) GMSCameraPositionインスタンスの作成
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.698717
                                                            longitude:139.772900
                                                                 zoom:16.0];
    
    // (2) GMSMapViewインスタンスの作成
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    // (3) myLocationEnabledプロパティ
    self.mapView.myLocationEnabled = YES;
    
    // (4) settings.myLocationButtonプロパティ
    self.mapView.settings.myLocationButton = YES;
    
    // (5) delegateの設定
    self.mapView.delegate = self;
    
    self.view = self.mapView;
    
    [self addMarkers];
}

#pragma mark - private methods

- (void)addMarkers
{
    // (6) デフォルトのマーカー
    GMSMarker *yodobashiMarker = [[GMSMarker alloc] init];
    yodobashiMarker.title = @"ヨドバシAkiba";
    yodobashiMarker.snippet = @"千代田区神田花岡町１−１";
    yodobashiMarker.position = CLLocationCoordinate2DMake(35.698852, 139.774761);
    yodobashiMarker.map = self.mapView;
    yodobashiMarker.userData = [NSNumber numberWithInteger:markerIdYodobashi];
    
    // (7) マーカーのアイコンをカスタム画像にする場合
    GMSMarker *akihabaraStationMarker = [[GMSMarker alloc] init];
    akihabaraStationMarker.title = @"秋葉原駅";
    akihabaraStationMarker.snippet = @"千代田区外神田1丁目";
    akihabaraStationMarker.position = CLLocationCoordinate2DMake(35.698404, 139.773001);
    akihabaraStationMarker.map = self.mapView;
    akihabaraStationMarker.icon = [UIImage imageNamed:@"pin"];
    akihabaraStationMarker.userData = [NSNumber numberWithInteger:markerIdAkihabaraStation];
    
    // (8) マーカーをタップした時に表示されるウィンドウ自体をカスタムビューにする場合
    GMSMarker *classmethodMarker = [[GMSMarker alloc] init];
    classmethodMarker.title = @"クラスメソッド株式会社";
    classmethodMarker.snippet = @"千代田区神田佐久間町1丁目11番地";
    classmethodMarker.position = CLLocationCoordinate2DMake(35.697236, 139.774718);
    classmethodMarker.map = self.mapView;
    classmethodMarker.userData = [NSNumber numberWithInteger:markerIdClassmethod];
    
    // (9) マーカーをタップした時に表示されるウィンドウの中のビューをカスタムビューにする場合
    GMSMarker *denkigaiMarker = [[GMSMarker alloc] init];
    denkigaiMarker.title = @"電気街";
    denkigaiMarker.snippet = @"千代田区外神田２丁目２−１６−２";
    denkigaiMarker.position = CLLocationCoordinate2DMake(35.699649, 139.771419);
    denkigaiMarker.map = self.mapView;
    denkigaiMarker.userData = [NSNumber numberWithInteger:markerIdDenkigai];
}

#pragma mark - GMSMapViewDelegate methods

// ウィンドウを返却する
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    NSInteger markerId = [marker.userData integerValue];
    if (markerId == markerIdClassmethod) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"View"
                                                      owner:self
                                                    options:nil] lastObject];
        return view;
    } else {
        return nil;
    }
}

// ウィンドウ内のコンテンツビューを返却する
- (UIView *)mapView:(GMSMapView *)mapView markerInfoContents:(GMSMarker *)marker
{
    NSInteger markerId = [marker.userData integerValue];
    if (markerId == markerIdDenkigai) {
        UIImage *image = [UIImage imageNamed:@"photo.jpg"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        return imageView;
    } else {
        return nil;
    }
}

@end