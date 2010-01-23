//
//  Action.m
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//

#import "Action.h"


@implementation Action

@synthesize parameters;
@synthesize processor;

+ (Action *)actionForKey:(NSString *)key
{
	NSString *className = [NSString stringWithFormat:@"%@Action", [key capitalizedString]];
	Class actionClass = NSClassFromString(className);
	if (!actionClass) {
		return nil;
	}
	return [[[actionClass alloc] init] autorelease];	
}

- (void)dealloc
{
	self.parameters = nil;
	[super dealloc];
}

- (NSUInteger)requiredParameterCount:(NSArray *)lookaheadArguments
{
	return 2;
}

- (BOOL)runWithParameters:(NSArray *)inParameters processor:(PDFDocumentManager *)inProcessor
{
	self.parameters = inParameters;
	self.processor = inProcessor;
	return [self run];
}

- (BOOL)run
{
	[NSException raise:NSGenericException format:@"%@ is abstract", NSStringFromSelector(_cmd)];
	return NO; // not reached
}

@end
