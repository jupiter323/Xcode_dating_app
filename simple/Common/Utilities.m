//
//  Utils.m
//  Korte
//
//  Created by Peace on 9/21/18.
//  Copyright © 2018 Peace. All rights reserved.
//
#import "Utilities.h"

static Utilities *sharedMyManager = nil;

@implementation Utilities
@synthesize indexImage;
@synthesize idVerifyStatus;
#pragma mark Singleton Methods
+ (id)sharedUtilities {
    static Utilities *sharedUtilities = nil;
    @synchronized(self) {
        if (sharedUtilities == nil)
            sharedUtilities = [[self alloc] init];
    }
    return sharedUtilities;
}
- (id)init {
    if (self = [super init]) {
        indexImage = 0;
        idVerifyStatus = NO;
    }
    return self;
}
-(void) setIndexImageOfCell:(int)index{
    indexImage = index;
}
-(void) setIdVerifyStatus:(Boolean)idVerifyStatusFrom{
    idVerifyStatus = idVerifyStatusFrom;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
