//
//  AddReceiptViewController.h
//  Receipts
//
//  Created by Andrew on 2017-10-27.
//  Copyright © 2017 hearthedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Tag+CoreDataClass.h"

@interface AddReceiptViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UITextFieldDelegate>

@end
