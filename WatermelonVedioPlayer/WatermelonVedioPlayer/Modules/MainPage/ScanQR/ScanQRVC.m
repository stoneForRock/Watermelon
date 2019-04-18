//
//  ScanQRVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/18.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "ScanQRVC.h"
#import <QuartzCore/QuartzCore.h>
#import "HUDHelper.h"

#define kScanRegionWidth  260
#define kScanRegionHeight 110

@interface ScanQRVC ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIView *contentView;
}

@property (strong, nonatomic) AVCaptureDevice *captureDevice;
@property (strong, nonatomic) AVCaptureDeviceInput *inputDevice;
@property (strong, nonatomic) AVCaptureMetadataOutput *outputDevice;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIView *maskLayerView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSTimer *maskTimer;
@property (nonatomic, assign) BOOL pause;

@property (strong, nonatomic) UIImageView *boxView;//扫描框
@property (strong, nonatomic) UIImageView *scanLayer;//扫描线
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *backV;
@end

@implementation ScanQRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.captureSession startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
}

- (void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusDenied) || ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusRestricted)) {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"未获得授权使用摄像头或受限制" message:@"请在手机设置/隐私/相机/中打开" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alt show];
        return;
    }
    CGFloat topOffset = 120.0f;
    self.scanRegionRect = CGRectMake((self.view.bounds.size.width - kScanRegionWidth) / 2, topOffset, kScanRegionWidth, kScanRegionHeight);
    self.scanRegionRect = self.view.bounds;
    self.title = @"扫描二维码";
    contentView = [[UIView alloc]initWithFrame:self.view.bounds];
    contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    [self.view addSubview:contentView];
    [self performSelector:@selector(setupSystemQRCodeScaner) withObject:nil afterDelay:0.00f];
}

- (void)setupSystemQRCodeScaner {
    self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
    
    self.outputDevice = [[AVCaptureMetadataOutput alloc] init];
    [self.outputDevice setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    if ([self.captureSession canAddInput:self.inputDevice]) {
        [self.captureSession addInput:self.inputDevice];
    } else {
        NSLog(@"addInput fail");
        return;
    }
    if ([self.captureSession canAddOutput:self.outputDevice]) {
        [self.captureSession addOutput:self.outputDevice];
    } else {
        NSLog(@"addOutput fail");
        return;
    }
    self.outputDevice.metadataObjectTypes = @[AVMetadataObjectTypeQRCode]; //canAddOutput后才能设置,模拟器暂不支持
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.scanRegionRect;
    
    AVCaptureConnection *captureConnection = self.previewLayer.connection;
    captureConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    [contentView.layer insertSublayer:self.previewLayer atIndex:0];
    
    ///////////////////////
    
    //从相册选择
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"chat_img_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(openAlbum)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //设置扫描范围
    self.outputDevice.rectOfInterest = CGRectMake(168 / ScreenFullHeight, 0.15, ScreenFullWidth * 0.7 / ScreenFullHeight, 0.7);
    
    //扫描框
    _boxView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenFullWidth * 0.3) / 2, 200 - 32, ScreenFullWidth * 0.7, ScreenFullWidth * 0.7)];
    _boxView.image = [UIImage imageNamed:@"pick_bg"];
    [contentView addSubview:_boxView];
    [self createBackView];
    
    //扫描线
    _scanLayer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, ScreenFullWidth * 0.7, 1)];
    _scanLayer.image = [UIImage imageNamed:@"line"];
    [_boxView addSubview:_scanLayer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [self.timer fire];
    
    //开始扫秒
    [self.captureSession startRunning];
}

- (void)createBackView {
    CGFloat width = ScreenFullHeight + SafeTopHeight;
    
    self.backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    self.backV.center = self.boxView.center;
    self.backV.backgroundColor = [UIColor clearColor];
    
    self.backV.alpha = 0.5;
    contentView.clipsToBounds = YES;
    [contentView addSubview:self.backV];
    
    CALayer *layer = [self.backV layer];
    layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    layer.borderWidth = (width - ScreenFullWidth * 0.7) / 2;
}

- (void)openAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{}];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        [self getURLWithImage:image];
        [self.timer invalidate];
        self.timer = nil;
    }];
}

- (void)getURLWithImage:(UIImage *)img {
    /*
     下面方法  ZXing 解析率不高换了原生解析二维码图片方法
     */
    //NSString *contents = [[self class] getQRStringFromImage:img];
    
    NSString *contents = [[self class] getQRStringFromImageByNative:img];
    
    NSLog(@" get QR string ===================================== :\n %@ \n", contents);
    
    if (contents && ![contents isEqualToString:@""]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contents] options:@{} completionHandler:nil];
    } else {
        UIAlertView *alter1 = [[UIAlertView alloc] initWithTitle:@"没有找到相关二维码信息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter1 show];
    }
}

//实现计时器方法moveScanLayer:(NSTimer *)timer
- (void)moveScanLayer:(NSTimer *)timer {
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = 10;
        _scanLayer.frame = frame;
    } else {
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

- (CGRect)renderFrame {
    return CGRectMake(20, 120, 280, 280);
}

- (void)analysisQRScanString:(NSString *)string {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [av show];
    //[self restartScan];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (!metadataObjects) return;
    
    AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
    NSString *resultString = metadataObject.stringValue;
    NSLog(@" get QR string ===================================== :\n %@ \n", resultString);
    [self.timer invalidate];
    self.timer = nil;
    [self.captureSession stopRunning];
    [self handleQRRawString:resultString];
}

- (void)handleQRRawString:(NSString *)qrString {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:qrString] options:@{} completionHandler:nil];
}

- (void)reStartRunning
{
    [self.captureSession startRunning];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [self.timer fire];
}

#pragma mark - 识别相册的二维码图片
//原生解析二维码方法
+ (NSString *)getQRStringFromImageByNative:(UIImage *)image
{
    // 1.取出选中的图片
    UIImage *pickImage = image;
    NSData *imageData = UIImagePNGRepresentation(pickImage);
    
    CIImage *ciImage = [CIImage imageWithData:imageData];
    
    // 2.从选中的图片中读取二维码数据
    // 2.1创建一个探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy: CIDetectorAccuracyLow }];
    
    // 2.2利用探测器探测数据
    NSArray *feature = [detector featuresInImage:ciImage];
    
    NSString *urlStr;
    // 2.3取出探测到的数据
    for (CIQRCodeFeature *result in feature) {
        urlStr = result.messageString;
    }
    
    return urlStr;
}


@end
