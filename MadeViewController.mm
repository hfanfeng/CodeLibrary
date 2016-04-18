//
//  MadeViewController.m
//  pictureOperate
//
//  Created by hff on 16/3/31.
//  Copyright © 2016年 threeTi. All rights reserved.
//

#import "MadeViewController.h"
#import "opencv2/opencv.hpp"
#import "opencv2/imgcodecs/ios.h"
#import "opencv2/imgcodecs.hpp"
#import "opencv2/imgproc/types_c.h"

@interface MadeViewController ()
{
    cv::Mat startImage;//美容
}

@property (weak, nonatomic) IBOutlet UIImageView *showImage;

- (IBAction)madeBtnClicked:(id)sender;

@end

@implementation MadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"美白美化";
    
    [self.showImage setImage:[UIImage imageNamed:@"4"]];
}


- (IBAction)madeBtnClicked:(id)sender {
    
    
    /**** 磨皮美白过程，图片越大反应越慢 *****/
    UIImage * tempImage = [self meiRongImageWithImage:_showImage.image White:25 filter:5 faceColor:12];
    
    [self.showImage setImage:tempImage];
}


#pragma mark - openCV美容效果
////美白度   磨皮度  肤色
-(UIImage *)meiRongImageWithImage:(UIImage *)curImage White:(float)white  filter:(int)filter  faceColor:(int)faceColor
{
   
    /*********  磨皮开始  *********/
    startImage = cv::Mat(20, 20, CV_8UC3, 1);
    UIImageToMat(curImage, startImage);//UIImage里面导入的是CV_8UC4格式的
    cv::cvtColor(startImage, startImage, CV_RGBA2RGB);
    
    int width = startImage.rows;
    int height = startImage.cols;
    
    cv::Mat endImage = cv::Mat(width, height, CV_8UC4, 1);
    UIImageToMat(curImage, endImage);
    
    
    //双边滤波则可以较好地保持原始图像中的区域信息  cv::BORDER_DEFAULT 6
    cv::bilateralFilter(startImage, endImage, 0, 60, filter, 0);

    //磨皮
    UIImage *resultImage = MatToUIImage(endImage);
    /*********  磨皮结束  *********/
    
    //滤镜美白
//    GPUImageBrightnessFilter *imageFilter = [[GPUImageBrightnessFilter alloc] init];
//    imageFilter.brightness = white;//-1.0~1.0
//    resultImage = [imageFilter imageByFilteringImage:resultImage];

    //滤镜磨皮
    //    GPUImageBilateralFilter  *imageFilter1 = [[GPUImageBilateralFilter alloc] init];
    //    imageFilter1.distanceNormalizationFactor = 5;
    //    imageFilter1.texelSpacingMultiplier = 4;
    //    UIImage *resultImage = [imageFilter1 imageByFilteringImage:curImage];
    
    
    /*********  美白开始  *********/
     UIImageToMat(resultImage, startImage);
     IplImage pI_1 = startImage;
     
     CvScalar s1;
     int i, j;
     int width1 = startImage.rows;
     int height1 = startImage.cols;
     
     //美白度参数
     int light_now = white; //20,30,40,
     
     for(i=0; i<width1; i++){
     for(j=0; j<height1; j++){
     s1 = cvGet2D(&pI_1, i, j);
     s1.val[0] = s1.val[0] + light_now;
     s1.val[1] = s1.val[1] + light_now;
     s1.val[2] = s1.val[2] + light_now;
     cvSet2D(&pI_1, i, j, s1);
     } }
     //美白
     resultImage = MatToUIImage(startImage);
     /*********  美白结束  *********/
     
    
    
    /*********  肤色开始  *********/
     UIImageToMat(resultImage, startImage);
     IplImage pI_3 = startImage;
     
     CvScalar s3;
     int i3, j3;
     int width3 = startImage.rows;
     int height3 = startImage.cols;
     
     //肤色亮度参数
     int R_now = faceColor;
     
     for(i3=0; i3<width3; i3++){
     for(j3=0; j3<height3; j3++){
     s3 = cvGet2D(&pI_3, i3, j3);
     s3.val[2] = s3.val[2] + (R_now * 2);
     
     cvSet2D(&pI_3, i3, j3, s3);
     } }
     //肤色
     resultImage = MatToUIImage(startImage);
    /*********  肤色结束  *********/
    
    
     return resultImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
