//
//  AddReceiptViewController.m
//  Receipts
//
//  Created by Andrew on 2017-10-27.
//  Copyright © 2017 hearthedge. All rights reserved.
//

#import "AddReceiptViewController.h"

@interface AddReceiptViewController ()
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) UIDatePicker *datePicker;
- (IBAction)addTagButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)clearInputButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableSet *selectedTags;

@end

@implementation AddReceiptViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatePicker];
    [self setupTextFields];
}

- (void)setupDatePicker {
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    //self.datePicker
    
    self.dateTextField.inputView = self.datePicker;
    
    // TODO: Set delegate
}

- (void)setupTextFields {
    self.descriptionTextField.delegate = self;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"Picker View Called");
    // TODO: update self.dateTextField.text with input
}

- (IBAction)addTagButtonPressed:(UIBarButtonItem *)sender {
    UIAlertController *newTagAlert = [UIAlertController alertControllerWithTitle:@"What's your new tag?"
                                                                         message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [newTagAlert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"New Tag";
    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        NSString *newTagName = newTagAlert.textFields[0].text;
                                        if (newTagName) {
                                            NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
                                            Tag *newTag = [[Tag alloc] initWithContext:context];
                                            newTag.tagName = newTagName;
                                            NSError *error = nil;
                                            if (![context save:&error]) {
                                                // Replace this implementation with code to handle the error appropriately.
                                                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                                                abort();
                                            }
                                        }
                                     }];
    
    [newTagAlert addAction:defaultAction];
    [self presentViewController:newTagAlert animated:YES completion:nil];

}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    self.receiptToAdd.amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
    self.receiptToAdd.note = self.descriptionTextField.text;
    self.receiptToAdd.timestamp = [NSDate date];
    self.receiptToAdd.receiptTags = self.selectedTags;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.descriptionTextField]) {
        [textField resignFirstResponder];
    }
    return YES;
}


- (IBAction)clearInputButton:(UIButton *)sender {
    [self.view endEditing:YES];
}


# pragma mark - Tag Table View


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *theCell = [tableView cellForRowAtIndexPath:indexPath];
    
    UITableViewCellAccessoryType checkmark = theCell.accessoryType;
    
    switch (checkmark) {
        case UITableViewCellAccessoryCheckmark:
            theCell.accessoryType = UITableViewCellAccessoryNone;
            [self.selectedTags removeObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            break;
        default:
            theCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.selectedTags addObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            break;
    }
    theCell.selected = NO;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tagCell"];
    Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = tag.tagName;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchedResultsController fetchedObjects].count;
}

- (void)configureCell:(UITableViewCell *)cell withTag:(Tag *)tag {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withTag:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withTag:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}



@end
