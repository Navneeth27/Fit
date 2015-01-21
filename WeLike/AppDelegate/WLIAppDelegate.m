//
//  WLIAppDelegate.m
//  WeLike
//
//  Created by Planet 1107 on 9/20/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import "WLIAppDelegate.h"
#import "WLINewPostViewController.h"
#import "WLINearbyViewController.h"
#import "WLIPopularViewController.h"
#import "WLIProfileViewController.h"
#import "WLITimelineViewController.h"
#import "WLIConnect.h"

@implementation WLIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    CLAuthorizationStatus locationAuthorizationStatus = [CLLocationManager authorizationStatus];
    if (locationAuthorizationStatus != kCLAuthorizationStatusDenied) {
        self.locationManager = [[CLLocationManager alloc] init];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
            [self.locationManager performSelector:@selector(requestWhenInUseAuthorization) withObject:nil];
        }
    }
    
    [self createViewHierarchy];
    
    // navigation bar appearance
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:92.0f/255.0f green:173.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav-back64.png"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    } else {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav-back44.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    // status bar appearance
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    navigationBarAppearance.backgroundColor = [UIColor clearColor];
    [navigationBarAppearance setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    navigationBarAppearance.shadowImage = [[UIImage alloc] init];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    //benmark
    [[ooVooController sharedController] initSdk:@"12349983352060"
     applicationToken:@"MDAxMDAxAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAoE%2FTxwzvba3Wy%2FupvESaKZhg1ngT4E8V7bqvT1RpL5F0UIW8FKbWarcsUJ51Nx%2BGwlHpeETeLbU4B8AYBUSRsopL5aGEZx7OrKL%2B%2B60kOeKuNLZuf%2FTVdRXKNLa1LuXU%3D" baseUrl:[[NSUserDefaults standardUserDefaults] stringForKey:@"production"]];
    
    
    //benmark
    NSUUID *appID = [[NSUUID alloc] initWithUUIDString:@"c6d3dfe6-a1a8-11e4-b169-142b010033d0"];
    self.layerClient = [LYRClient clientWithAppID:appID];
    [self.layerClient connectWithCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Failed to connect to Layer: %@", error);
        } else {
            NSString *userIDString = @"bharv410";
            // Once connected, authenticate user.
            // Check Authenticate step for authenticateLayerWithUserID source
            [self authenticateLayerWithUserID:userIDString completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSLog(@"Failed Authenticating Layer Client with error:%@", error);
                }
            }];
        }
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - UITabBarControllerDelegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController  shouldSelectViewController:(UIViewController *)viewController {
    
    UINavigationController *navigationViewController = (UINavigationController *)viewController;
    if ([navigationViewController.topViewController isKindOfClass:[WLINewPostViewController class]]) {
        WLINewPostViewController *newPostViewController = [[WLINewPostViewController alloc] initWithNibName:@"WLINewPostViewController" bundle:nil];
        UINavigationController *newPostNavigationController = [[UINavigationController alloc] initWithRootViewController:newPostViewController];
        newPostNavigationController.navigationBar.translucent = NO;
        [tabBarController presentViewController:newPostNavigationController animated:YES completion:nil];
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - Other methods

- (void)createViewHierarchy {
    
    WLITimelineViewController *timelineViewController = [[WLITimelineViewController alloc] initWithNibName:@"WLITimelineViewController" bundle:nil];
    UINavigationController *timelineNavigationController = [[UINavigationController alloc] initWithRootViewController:timelineViewController];
    timelineNavigationController.navigationBar.translucent = NO;
    
    WLIPopularViewController *popularViewController = [[WLIPopularViewController alloc] initWithNibName:@"WLIPopularViewController" bundle:nil];
    UINavigationController *popularNavigationController = [[UINavigationController alloc] initWithRootViewController:popularViewController];
    popularNavigationController.navigationBar.translucent = NO;
    
    WLINewPostViewController *newPostViewController = [[WLINewPostViewController alloc] initWithNibName:@"WLINewPostViewController" bundle:nil];
    UINavigationController *newPostNavigationController = [[UINavigationController alloc] initWithRootViewController:newPostViewController];
    newPostNavigationController.navigationBar.translucent = NO;
    
    WLINearbyViewController *nearbyViewController = [[WLINearbyViewController alloc] initWithNibName:@"WLINearbyViewController" bundle:nil];
    UINavigationController *nearbyNavigationController = [[UINavigationController alloc] initWithRootViewController:nearbyViewController];
    nearbyNavigationController.navigationBar.translucent = NO;
    
    WLIProfileViewController *profileViewController = [[WLIProfileViewController alloc] initWithNibName:@"WLIProfileViewController" bundle:nil];
    UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    profileNavigationController.navigationBar.translucent = NO;
    
    self.tabBarController = [[WLITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = @[timelineNavigationController, popularNavigationController,newPostNavigationController, nearbyNavigationController, profileNavigationController];
    
    
    //get white image
    UIImage *source=[UIImage imageNamed:@"tabbar-newpost"];
    // begin a new image context, to draw our colored image onto with the right scale
    UIGraphicsBeginImageContextWithOptions(source.size, NO, [UIScreen mainScreen].scale);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color=[UIColor whiteColor];
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, source.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);
    CGContextDrawImage(context, rect, source.CGImage);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    

    UITabBarItem *timelineTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Timeline" image:[[UIImage imageNamed:@"tabbartimeline"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbartimeline"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    timelineViewController.tabBarItem = timelineTabBarItem;
     UITabBarItem *popularTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Popular" image:[[UIImage imageNamed:@"tabbarpopular"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbarpopular"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    popularViewController.tabBarItem = popularTabBarItem;
       UITabBarItem *newPostTabBarItem = [[UITabBarItem alloc] initWithTitle:@"New post" image:[[UIImage imageNamed:@"tabbarnewpost"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbarnewpost"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    newPostViewController.tabBarItem = newPostTabBarItem;
       UITabBarItem *nearbyTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Nearby" image:[[UIImage imageNamed:@"tabbarnearby"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbarnearby"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    nearbyViewController.tabBarItem = nearbyTabBarItem;
    
       UITabBarItem *profileTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[[UIImage imageNamed:@"tabbarprofile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbarprofile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    profileViewController.tabBarItem = profileTabBarItem;
    
    self.window.rootViewController = self.tabBarController;
}

- (void)authenticateLayerWithUserID:(NSString *)userID completion:(void (^)(BOOL success, NSError * error))completion
{
    // If the user is authenticated you don't need to re-authenticate.
    if (self.layerClient.authenticatedUserID) {
        NSLog(@"Layer Authenticated as User %@", self.layerClient.authenticatedUserID);
        if (completion) completion(YES, nil);
        return;
    }
    
    /*
     * 1. Request an authentication Nonce from Layer
     */
    [self.layerClient requestAuthenticationNonceWithCompletion:^(NSString *nonce, NSError *error) {
        if (!nonce) {
            if (completion) {
                completion(NO, error);
            }
            return;
        }
        
        /*
         * 2. Acquire identity Token from Layer Identity Service
         */
        [self requestIdentityTokenForUserID:userID appID:[self.layerClient.appID UUIDString] nonce:nonce completion:^(NSString *identityToken, NSError *error) {
            if (!identityToken) {
                if (completion) {
                    completion(NO, error);
                }
                return;
            }
            
            /*
             * 3. Submit identity token to Layer for validation
             */
            [self.layerClient authenticateWithIdentityToken:identityToken completion:^(NSString *authenticatedUserID, NSError *error) {
                if (authenticatedUserID) {
                    if (completion) {
                        completion(YES, nil);
                    }
                    NSLog(@"Layer Authenticated as User: %@", authenticatedUserID);
                } else {
                    completion(NO, error);
                }
            }];
        }];
    }];
}
- (void)requestIdentityTokenForUserID:(NSString *)userID appID:(NSString *)appID nonce:(NSString *)nonce completion:(void(^)(NSString *identityToken, NSError *error))completion
{
    NSParameterAssert(userID);
    NSParameterAssert(appID);
    NSParameterAssert(nonce);
    NSParameterAssert(completion);
    
    NSURL *identityTokenURL = [NSURL URLWithString:@"https://layer-identity-provider.herokuapp.com/identity_tokens"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:identityTokenURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *parameters = @{ @"app_id": appID, @"user_id": userID, @"nonce": nonce };
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    request.HTTPBody = requestBody;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        // Deserialize the response
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(![responseObject valueForKey:@"error"])
        {
            NSString *identityToken = responseObject[@"identity_token"];
            completion(identityToken, nil);
        }
        else
        {
            NSString *domain = @"layer-identity-provider.herokuapp.com";
            NSInteger code = [responseObject[@"status"] integerValue];
            NSDictionary *userInfo =
            @{
              NSLocalizedDescriptionKey: @"Layer Identity Provider Returned an Error.",
              NSLocalizedRecoverySuggestionErrorKey: @"There may be a problem with your APPID."
              };
            
            NSError *error = [[NSError alloc] initWithDomain:domain code:code userInfo:userInfo];
            completion(nil, error);
        }
        
    }] resume];
}

@end
