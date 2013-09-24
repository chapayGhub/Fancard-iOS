//
//  ETMacro.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#ifndef Fancard_ETMacro_h
#define Fancard_ETMacro_h

#define iOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7)
#define iPhone5 ([UIScreen mainScreen].bounds.size.height > 480)
#define alert(__X__) [[[UIAlertView alloc] initWithTitle:@"attention" \
message:__X__ \
delegate:nil \
cancelButtonTitle:@"OK" \
otherButtonTitles: nil] show]

#define kDefaultFont @"Nunito-Regular"
#endif
