//
//  BaseViewController.m
//  pictureOperate
//
//  Created by hff on 16/3/31.
//  Copyright © 2016年 threeTi. All rights reserved.
//

#import "BaseViewController.h"
#import "TTI_ImageUtils.h"

@interface BaseViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;

//图片位置调整-拍照图片角度问题
- (IBAction)oneBtnClicked:(id)sender;

//图片部分截图
- (IBAction)twoBtnClicked:(id)sender;

//图片合成
- (IBAction)threeBtnClicked:(id)sender;

//图片添加文字
- (IBAction)fourBtnClicked:(id)sender;

//图片添加水印
- (IBAction)fiveBtnClicked:(id)sender;

//图片旋转-角度旋转
- (IBAction)sixBtnClicked:(id)sender;

//图片旋转-弧度旋转
- (IBAction)sevenBtnClicked:(id)sender;

//图片等比例压缩
- (IBAction)eightBtnClicked:(id)sender;

//图片对调
- (IBAction)nineBtnClicked:(id)sender;

//截屏
- (IBAction)tenBtnClicked:(id)sender;

//圆角阴影
- (IBAction)cornerBtnClicked:(id)sender;

//手势
- (IBAction)gestureBtnClicked:(id)sender;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"图片操作";
    
    [_bigImageView setImage:[UIImage imageNamed:@"3"]];
    
    
    [_smallImage setImage:[UIImage imageNamed:@"2"]];
}


#pragma mark - 圆角阴影设置
- (IBAction)cornerBtnClicked:(id)sender
{
    //圆角阴影设置
    [self setCornerShadowWithCurView:_smallImage Radius:_bigImageView.frame.size.width/2 borderColor:[UIColor redColor] borderWidth:2.0 shadowOffset:CGSizeMake(5, 5) shadowRadius:5 shadowOpacity:1 shadowColor:[UIColor redColor]];
}


-(void)setCornerShadowWithCurView:(UIView *)curView Radius:(float)radius borderColor:(UIColor *)borderColor borderWidth:(float)borderWidth shadowOffset:(CGSize )shadowOffset shadowRadius:(float)shadowRadius shadowOpacity:(float)shadowOpacity shadowColor:(UIColor *)shadowColor
{
    //图片圆角设置
    [[curView layer] setCornerRadius:radius];
    [[curView layer] setBorderColor:borderColor.CGColor];
    [[curView layer] setBorderWidth:borderWidth];
    [[curView layer] setMasksToBounds:YES];
    
    
    //图片阴影设置
    //设置阴影起点位置
    [[curView layer] setShadowOffset:shadowOffset];
    //设置阴影扩散程度
    [[curView layer] setShadowRadius:shadowRadius];
    //设置阴影透明度
    [[curView layer] setShadowOpacity:shadowOpacity];
    //设置阴影颜色
    [[curView layer] setShadowColor:shadowColor.CGColor];
}


#pragma mark 手势操作
- (IBAction)gestureBtnClicked:(id)sender
{
    //设置手势
    [_bigImageView setUserInteractionEnabled:YES];
    [self addGestureRecognizer:_bigImageView];
}


- (void)addGestureRecognizer:(UIView *)view
{
    //旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    //缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    //拖拽手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
    
    //单击手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [view addGestureRecognizer:tapGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    NSLog(@"旋转手势");
    
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    NSLog(@"缩放手势");
    
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

//处理单击手势
- (void)tapView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSLog(@"单击手势");
    
    UIView *view = tapGestureRecognizer.view;
    [view.superview bringSubviewToFront:view];
}

//处理拖拽手势
- (void)panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    NSLog(@"拖拽手势");
}


#pragma mark - 拍照图片角度处理
//图片位置调整-拍照图片角度问题
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //获取原始图片
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //拍照原图调整位置
    UIImage *fixImage = [originalImage fixTakePictureOrientation];
}

- (IBAction)oneBtnClicked:(id)sender
{
    NSLog(@"需要拍照");//单独有写
}


#pragma mark - 图片部分截取
//图片部分截图
- (IBAction)twoBtnClicked:(id)sender
{
    
    UIImage *tempImage = [_bigImageView.image subImageAtRect:CGRectMake(20, 20, 80, 80)];
    
    [_bigImageView setImage:tempImage];
}

#pragma mark - 图片合成
//图片合成
- (IBAction)threeBtnClicked:(id)sender
{
    
    UIImage *image1 = [UIImage imageNamed:@"1"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    
    UIImage *tempImage = [image1 addImagetoImage:image2 image1Frame:CGRectMake(0, 0,self.view.frame.size.width-20, 100) image2Frame:CGRectMake(0, 100,self.view.frame.size.width-20, 100)];
    [_bigImageView setImage:tempImage];
}


#pragma mark - view转换image
- (IBAction)tenBtnClicked:(id)sender
{
    UIImage *tempImage = [UIImage getImageFromView:self.view];
    [_bigImageView setImage:tempImage];
}


#pragma mark - 图片添加文字
//图片添加文字
- (IBAction)fourBtnClicked:(id)sender
{
    UIImage *tempImage = [_bigImageView.image imageAddText:@"测试文字"];
    [_bigImageView setImage:tempImage];
}

#pragma mark - 图片添加水印
//图片添加水印
- (IBAction)fiveBtnClicked:(id)sender
{
    UIImage *tempImage = [_bigImageView.image imageAddWaterLogo:[UIImage imageNamed:@"1"]];
    [_bigImageView setImage:tempImage];
}


#pragma mark - 图片角度旋转
//图片旋转-角度旋转
- (IBAction)sixBtnClicked:(id)sender
{
    UIImage *tempImage = [_bigImageView.image imageRotatedByDegrees:90];
    [_bigImageView setImage:tempImage];
}


#pragma mark - 图片弧度旋转
//图片旋转-弧度旋转
- (IBAction)sevenBtnClicked:(id)sender
{
    UIImage *tempImage = [_bigImageView.image imageRotatedByRadians:10];
    [_bigImageView setImage:tempImage];
}


#pragma mark - 图片等比例压缩
//图片等比例压缩
- (IBAction)eightBtnClicked:(id)sender
{
    CGFloat width = CGImageGetWidth(_bigImageView.image.CGImage);
    CGFloat height = CGImageGetHeight(_bigImageView.image.CGImage);
    CGSize size = CGSizeMake(width, height);
    UIImage *tempImage = [_bigImageView.image imageScaledToSize:size];
    [_bigImageView setImage:tempImage];
    
}

#pragma mark - 图片对调
//图片对调
- (IBAction)nineBtnClicked:(id)sender
{
    UIImage *tempImage = [_bigImageView.image imageMirror];
    [_bigImageView setImage:tempImage];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
