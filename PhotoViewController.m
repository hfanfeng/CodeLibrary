//
//  PhotoViewController.m
//  pictureOperate
//
//  Created by hff on 16/3/31.
//  Copyright © 2016年 threeTi. All rights reserved.
//

#import "PhotoViewController.h"
#import "TTI_Other/TTI_ImagePickerManager.h"

@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
- (IBAction)selectBtnClicked:(id)sender;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.title = @"图片选取";
}


- (IBAction)selectBtnClicked:(id)sender {
    
    [[TTIImagePickerManager shareInstance] imagePickerWithType:TTIImagePickerManagerBoth photoType:TTIImagePickerLibrary enableEditing:YES withDelegate:self comleteBlock:^(UIImage *resultImage, UIImage *orignImage, NSURL *videoPath) {
        
        if (resultImage)
        {
            [self.showImage setImage:resultImage];
        }
        
        if (videoPath)
        {
            NSLog(@"%@",videoPath);
        }
    } failedBlock:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
