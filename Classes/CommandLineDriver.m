//
//  CommandLineDriver.m
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//
//  Heavily inspired by Marc Liyanage's CommandLineDriver class in CoreImageTool:
//  http://github.com/liyanage/coreimagetool
//

#import "CommandLineDriver.h"
#import "Version.h"
#import "Action.h"
#import "LoadAction.h"
#import "PDFDocumentManager.h"


@implementation CommandLineDriver

+ (int)runWithArguments:(const char*[])argv count:(int)argc
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CommandLineDriver *driver = [CommandLineDriver driverForArguments:argv count:argc];
	int result = [driver run];
	[pool release];
	
	return result;
}

+ (CommandLineDriver *)driverForArguments:(const char*[])argv count:(int)argc
{
	return [[[CommandLineDriver alloc] initWithArguments:argv count:argc] autorelease];
}

- (CommandLineDriver *)initWithArguments:(const char*[])argv count:(int)argc
{
	self = [super init];
	if (!self) return nil;
	
	arguments = [[NSMutableArray alloc] init];
	programName = [[NSString stringWithUTF8String:argv[0]] retain];
	
	for (int i = 1; i < argc; i++) {
		[arguments addObject:[NSString stringWithUTF8String:argv[i]]];
	}	
	
	return self;
}

- (void)dealloc
{
	[programName release];
	[arguments release];
	[super dealloc];
}

- (int)run 
{
	NSUInteger count = [arguments count];
		
	if (count < 1) {
		fprintf(stderr, "PDFKitTool %s - a command interface end to Apple’s PDF Kit framework.\n", VERSION);
		fprintf(stderr, "Usage: PDFKitTool action parameters [action parameters ...]\n");
		fprintf(stderr, "See http://github.com/fjoachim/pdfkittool for details.\n");
		return 1;
	}
	
	PDFDocumentManager *processor = [PDFDocumentManager processor];
	for (NSUInteger i = 0; i < count; i++) {
		NSString *actionKey = [arguments objectAtIndex:i];
		Action *action = [Action actionForKey:actionKey];
		if (!action) {
			if ([LoadAction isLoadableParameter:actionKey]) {
				action = [[[LoadAction alloc] init] autorelease];
				i--;
			} else {
				fprintf(stderr, "[error] action '%s' is not valid\n", [actionKey UTF8String]);
				continue;
			}
		}
	
		NSUInteger availableArguments = count - (i + 1);
		NSArray *lookaheadArguments = (availableArguments > 0) ? 
			[arguments subarrayWithRange:NSMakeRange(i + 1, availableArguments)] : [NSArray array];
		NSUInteger requiredParameterCount = [action requiredParameterCount:lookaheadArguments];
		if (availableArguments < requiredParameterCount) {
			fprintf(stderr, "[error] action '%s' expects %d parameters but only %d arguments remain\n",
					[actionKey UTF8String], (int)requiredParameterCount, (int)availableArguments);
			return 1;
		}
		
		NSMutableArray *actionParameters = [NSMutableArray array];
		for (NSUInteger j = 0; j < requiredParameterCount; j++) {
			i++;
			[actionParameters addObject:[arguments objectAtIndex:i]];
		}
		
		BOOL result = [action runWithParameters:actionParameters processor:processor];
		if (!result) {
			NSLog(@"action '%@' failed", actionKey);
			return 1;
		}		
	}
	
	return 0;
}

@end
