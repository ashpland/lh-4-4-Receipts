//
//  TagManager.h
//  Receipts
//
//  Created by Andrew on 2017-11-05.
//  Copyright © 2017 hearthedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag+CoreDataClass.h"

@interface TagManager : NSObject <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<Tag *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedTagManager;
- (NSInteger)numberOfTags;
- (NSInteger)numberOfReceiptsForTag:(NSInteger)tagNumber;
- (NSString *)tagNameForTag:(NSInteger)tagNumber;
-(Receipt *)receiptAtIndexPath:(NSIndexPath *)indexPath;

@end
