//
//  WLINearbyViewController.m
//  WeLike
//
//  Created by Planet 1107 on 20/11/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import "WLINearbyViewController.h"
#import "WLIProfileViewController.h"
#import "WLIUser.h"
#import "GlobalDefines.h"

@implementation WLINearbyViewController


#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Nearby";
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.adjustsImageWhenHighlighted = NO;
    reloadButton.frame = CGRectMake(0.0f, 0.0f, 40.0f, 30.0f);
    [reloadButton setImage:[UIImage imageNamed:@"nav-btn-reload.png"] forState:UIControlStateNormal];
    [reloadButton addTarget:self action:@selector(barButtonItemReloadTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:reloadButton];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Data loading methods

- (void)reloadData {
    
    
}


#pragma mark - Actions methods

- (void)barButtonItemReloadTouchUpInside:(UIBarButtonItem*)barButtonItemSave {
    
    if (!loading) {
        [self reloadData];
    }
}

@end
