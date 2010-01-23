//
//  OutputAction.m
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//

#import "OutputAction.h"


@implementation OutputAction

- (BOOL)run
{
	NSString *fileName = [self.parameters objectAtIndex:0];
	return [self.processor writeDocumentsToFile:fileName];
}

- (NSUInteger)requiredParameterCount:(NSArray *)lookaheadArguments
{
	return 1;
}

@end
