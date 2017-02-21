#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import "RNKeyboardViewManager.h"
#import "RNKeyboardHostView.h"

@implementation RNKeyboardViewManager
{
      NSHashTable *_hostViews;
}


RCT_EXPORT_MODULE()

- (UIView *)view
{
    RNKeyboardHostView *view = [[RNKeyboardHostView alloc] initWithBridge:self.bridge];
    
    if (!_hostViews) {
        _hostViews = [NSHashTable weakObjectsHashTable];
    }
    [_hostViews addObject:view];
    
    return view;
}


- (void)invalidate
{
    for (RNKeyboardHostView *hostView in _hostViews) {
        [hostView invalidate];
    }
    [_hostViews removeAllObjects];
}

RCT_EXPORT_VIEW_PROPERTY(stickyViewInside, BOOL)
RCT_EXPORT_VIEW_PROPERTY(containerHeight, CGFloat)

RCT_EXPORT_METHOD(openKeyboard:(nonnull NSNumber *)reactTag)
{
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        RNKeyboardHostView *view = viewRegistry[reactTag];
    }];
}

RCT_EXPORT_METHOD(closeKeyboard:(nonnull NSNumber *)reactTag)
{
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        RNKeyboardHostView *view = viewRegistry[reactTag];
        [view closeKeyboard];
    }];
}

RCT_EXPORT_METHOD(showKeyboard:(nonnull NSNumber *)reactTag)
{
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        RNKeyboardHostView *view = viewRegistry[reactTag];
        [view showKeyboard];
    }];
}

RCT_EXPORT_METHOD(hideKeyboard:(nonnull NSNumber *)reactTag)
{
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        RNKeyboardHostView *view = viewRegistry[reactTag];
        [view hideKeyboard];
    }];
}

RCT_EXPORT_METHOD(toggleKeyboard:(nonnull NSNumber *)reactTag)
{
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        RNKeyboardHostView *view = viewRegistry[reactTag];
        [view toggleKeyboard];
    }];
}

@end
