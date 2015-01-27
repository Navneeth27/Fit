//
//  WLIChooseVideoViewController.m
//  Fitovate
//
//  Created by Benjamin Harvey on 1/9/15.
//  Copyright (c) 2015 Goran Vuksic. All rights reserved.
//

#import "WLIChooseVideoViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AWSiOSSDKv2/S3.h>
#import <AWSiOSSDKv2/AWSCore.h>

@interface WLIChooseVideoViewController ()

@end

@implementation WLIChooseVideoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [picker setMediaTypes: [NSArray arrayWithObject:kUTTypeMovie]];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
        [picker dismissViewControllerAnimated:YES completion:NULL];
    
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSString *path = [videoURL path];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    AWSStaticCredentialsProvider *credentialsProvider = [AWSStaticCredentialsProvider credentialsWithAccessKey:@"AKIAI2TXM2GGTX5OF2HA" secretKey:@"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"];
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSEast1
                                                                          credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
        //upload video in background
        AWSS3TransferManager *transferManager = [[AWSS3TransferManager alloc]initWithConfiguration:configuration identifier:@"transfermgr"];
        AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
        uploadRequest.bucket = @"fitovatevideoss";
        uploadRequest.key = @"somehowaddtheusersname.mp4";
        uploadRequest.body = videoURL;
        uploadRequest.contentLength = [NSNumber numberWithUnsignedLongLong:[data length]];
        NSLog(@"HERE");
    
    uploadRequest.uploadProgress =  ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend){
        dispatch_async(dispatch_get_main_queue(), ^{
            int progress = (int)(totalBytesSent * 100.0 / totalBytesExpectedToSend);
            NSLog([NSString stringWithFormat:@"%d",progress]);
        });};
    
    
    [[transferManager upload:uploadRequest] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id(BFTask *task) {
        if (task.error != nil) {
            NSLog(@"Error: %@", task.error);
        } else {
            NSLog(@"Success!");
        }
        return nil;
    }];
    
}





- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
