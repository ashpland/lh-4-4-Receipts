//
//  ViewController.h
//  Receipts
//
//  Created by Andrew on 2017-10-27.
//  Copyright © 2017 hearthedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipt+CoreDataClass.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<Receipt *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

