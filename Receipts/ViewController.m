//
//  ViewController.m
//  Receipts
//
//  Created by Andrew on 2017-10-27.
//  Copyright © 2017 hearthedge. All rights reserved.
//

#import "ViewController.h"
#import "AddReceiptViewController.h"

@interface ViewController ()
- (IBAction)addReceiptButtonPress:(UIBarButtonItem *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}





- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"receiptCell"];
    Receipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = receipt.note;

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchedResultsController fetchedObjects].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (IBAction)addReceiptButtonPress:(UIBarButtonItem *)sender {

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddReceiptSegue"]) {
        AddReceiptViewController *newReceiptVC = (AddReceiptViewController *)segue.destinationViewController;
        newReceiptVC.managedObjectContext = self.managedObjectContext;
    }
}


@end
