//
//  AppDelegate.h
//  Receipts
//
//  Created by Andrew on 2017-10-27.
//  Copyright © 2017 hearthedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

