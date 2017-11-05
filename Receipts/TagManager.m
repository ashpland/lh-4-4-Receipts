//
//  TagManager.m
//  Receipts
//
//  Created by Andrew on 2017-11-05.
//  Copyright © 2017 hearthedge. All rights reserved.
//

#import "TagManager.h"
#import <UIKit/UIKit.h>

@implementation TagManager

+ (instancetype)sharedTagManager {
    static TagManager *theTagManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theTagManager = [self new];
    });
    return theTagManager;
}

-(NSInteger)numberOfTags {
    return [self.fetchedResultsController fetchedObjects].count;
}

-(Tag *)getTagForTagNumber:(NSInteger)tagNumber {
    NSIndexPath *tagPath = [NSIndexPath indexPathForRow:tagNumber inSection:0];
    return [self.fetchedResultsController objectAtIndexPath: tagPath];
}

-(NSSet<Receipt *> *)receiptsForTagNumber:(NSInteger)tagNumber {
    return [self getTagForTagNumber:tagNumber].taggedReceipts;
}

-(NSInteger)numberOfReceiptsForTag:(NSInteger)tagNumber {
    return [self receiptsForTagNumber:tagNumber].count;
}

-(NSString *)tagNameForTag:(NSInteger)tagNumber {
    return [self getTagForTagNumber:tagNumber].tagName;
}

-(Tag *)tagAtIndexPath:(NSIndexPath *)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

-(Receipt *)receiptAtIndexPath:(NSIndexPath *)indexPath {
    return [[[self receiptsForTagNumber:indexPath.section] allObjects] objectAtIndex:indexPath.row];
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController<Tag *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<Tag *> *fetchRequest = [Tag fetchRequest];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tagName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Tag *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}




@end
