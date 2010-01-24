//
//  CatAction.m
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//

#import "CatAction.h"


@implementation CatAction

- (BOOL)run
{
	if ([self.processor documentCount] > 1) {
		return [self.processor catDocuments];
	} else {
		return NO;
	}
}

- (NSUInteger)requiredParameterCount:(NSArray *)lookaheadArguments
{
	return 0;
}

@end
