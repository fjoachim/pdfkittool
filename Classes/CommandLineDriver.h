//
//  CommandLineDriver.h
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//
//  Heavily inspired by Marc Liyanage's CommandLineDriver class in CoreImageTool:
//  http://github.com/liyanage/coreimagetool
//

#import <Foundation/Foundation.h>


@interface CommandLineDriver : NSObject {
	NSString *programName;
	NSMutableArray *arguments;
}

+ (int)runWithArguments:(const char*[])argv count:(int)argc;
+ (CommandLineDriver *)driverForArguments:(const char*[])argv count:(int)argc;
- (CommandLineDriver *)initWithArguments:(const char*[])argv count:(int)argc;
- (int)run;

@end
