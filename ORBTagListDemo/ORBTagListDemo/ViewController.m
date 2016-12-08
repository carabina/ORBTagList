//
//  ViewController.m
//  ORBTagListDemo
//
//  Created by Vladislav Averin on 07/12/2016.
//  Copyright © 2016 Vlad Averin (hello@vladaverin.me). All rights reserved.
//

#import "ViewController.h"
#import "ORBTagList.h"

@interface ViewController () <ORBTagListDataSource, ORBTagListDelegate> {
    
}

@property (nonatomic, strong) NSArray *sampleTags;

@end

@implementation ViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    [self buildMinumalUI];
}

#pragma mark - Minimal Demo

- (void)buildMinumalUI {
    self.sampleTags = [self randomTags];
    
    /* Create */
    ORBTagList *tags = [[ORBTagList alloc]
                        initWithFrame:self.view.bounds];
    tags.dataSource = self;
    tags.delegate = self;
    
    /* Optionally customize */
    tags.tagListHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                      tags.bounds.size.width,
                                                                      20)];
    tags.tagListFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                      tags.bounds.size.width,
                                                                      20)];
    
    tags.leftEdgeInset = 20;
    tags.rightEdgeInset = 20;
    
    [self.view addSubview:tags];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        tags.frame = CGRectMake(0, 0,
                                self.view.bounds.size.width / 2,
                                self.view.bounds.size.height / 2);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                

                
            });
        });
    });
}

#pragma mark - ORBTagListDataSource

- (NSUInteger)numberOfItemsInTagList {
    return self.sampleTags.count;
}

- (ORBTagListItem *)tagItemAtIndex:(NSUInteger)tagItemIndex {
    
    /* Use default class */
    ORBTagListItem *tag = [[ORBTagListItem alloc] initWithText:self.sampleTags[tagItemIndex]];
    
    BOOL highlighted = (tagItemIndex % ((arc4random() % 3) + 1) == 0);
    
    tag.tagFont = [UIFont fontWithName:(highlighted) ? @"Courier" : @"Courier-Bold" size:(highlighted) ? 17.0f : 19.0f];
    tag.tagNameColor = [self randomColor];
    tag.tagBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    tag.tagCornerRadius = arc4random() % 15;
    tag.horizontalPadding = 7;
    
    //tag.accessoryView = ORBTagListItemAccessoryViewRemoveItem;
    
    tag.accessoryView = ORBTagListItemAccessoryViewCustom;
    
    UIImageView *accessoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross"]];
    accessoryImage.frame = CGRectMake(0, 0,
                                      20, 20);
    
    tag.customAccessoryView = accessoryImage;
    
    /* Or whatever subclass you want */
    
    return tag;
}

- (CGFloat)heightForAllItemsInTagList {
    return 40;
}

- (CGFloat)horizontalSpaceBetweenItemsInTagList {
    return 10;
}

- (CGFloat)verticalSpaceBetweenItemsInTagList {
    return 10;
}

#pragma mark - ORBTagListDelegate

- (void)tagListItemTappedAtIndex:(NSUInteger)tagItemIndex {
    NSLog(@"Tapped tag #%lu", (unsigned long)tagItemIndex);
}

- (void)tagListItemAccessoryButtonTappedAtIndex:(NSUInteger)tagItemIndex {
    NSLog(@"Tapped tag accessory #%lu", (unsigned long)tagItemIndex);
}

- (BOOL)shouldRemoveTagListItemAtIndex:(NSUInteger)tagItemIndex {
    return NO;
}

#pragma mark - Sample Data

- (NSArray *)randomTags {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableArray *tags = [NSMutableArray new];
    NSUInteger numberOfTags = 100;
    NSUInteger maxTagLength = 20;
    NSUInteger minTagLength = 2;
    
    for (NSUInteger i = 0; i < numberOfTags; i++) {
        int randomLength = (int)((arc4random() % (maxTagLength - minTagLength)) + minTagLength);
        NSMutableString *randomString = [NSMutableString stringWithCapacity:randomLength];
        
        for (int j = 0; j < randomLength; j++) {
            [randomString appendFormat: @"%C",
             [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
        }
        
        [tags addObject:randomString];
    }
    
    return tags;
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue
                                saturation:saturation
                                brightness:brightness alpha:1];
}

@end
