//
//  BurstAction.m
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//

#import "BurstAction.h"


@implementation BurstAction

- (BOOL)run
{
	return [self.processor burstDocuments];
}

- (NSUInteger)requiredParameterCount:(NSArray *)lookaheadArguments
{
	return 0;
}

@end
