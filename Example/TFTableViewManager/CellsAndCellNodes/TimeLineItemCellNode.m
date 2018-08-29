//
//  TimeLineItemCell.m
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//

#import "TimeLineItemCellNode.h"
#import "TextStyle.h"
#import "LikesNode.h"
#import "CommentsNode.h"


@interface TimeLineItemCellNode()<ASTextNodeDelegate,ASNetworkImageNodeDelegate>

@property (nonatomic, strong) ASTextNode *nickNameNode;
@property (nonatomic, strong) ASTextNode *timeNode;
@property (nonatomic, strong) ASTextNode *fromNode;
@property (nonatomic, strong) ASNetworkImageNode *avatarNode;
@property (nonatomic, strong) ASNetworkImageNode *mediaNode;
@property (nonatomic, strong) ASTextNode          *titleNode;
@property (nonatomic, strong) ASTextNode          *contentNode;
@property (nonatomic, strong) ASNetworkImageNode  *backgroundMediaNode;

@property (nonatomic, strong) LikesNode           *likesNode;
@property (nonatomic, strong) CommentsNode        *commentsNode;

@end

@implementation TimeLineItemCellNode
@dynamic tableViewItem;


- (void)cellLoadSubNodes {
    [super cellLoadSubNodes];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _nickNameNode = [[ASTextNode alloc] init];
    _nickNameNode.attributedText = [[NSAttributedString alloc] initWithString:[[self.tableViewItem.data objectForKey:@"author"] objectForKey:@"nickName"]
                                                                   attributes:[TextStyle nameStyle]];
    _nickNameNode.maximumNumberOfLines = 1;
    
//    _nickNameNode.placeholderEnabled = YES;
//    _nickNameNode.placeholderFadeDuration = 2;
    
    [self addSubnode:_nickNameNode];
    
    _timeNode = [[ASTextNode alloc] init];
    _timeNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[self.tableViewItem.data objectForKey:@"date"]]
                                                               attributes:[TextStyle usernameStyle]];
    _timeNode.truncationMode = NSLineBreakByTruncatingTail;
    _timeNode.maximumNumberOfLines = 1;
    
    
//    _timeNode.placeholderEnabled = YES;
//    _timeNode.placeholderFadeDuration = 2;
    
    [self addSubnode:_timeNode];
    
    _fromNode = [[ASTextNode alloc] init];
    _fromNode.attributedText = [[NSAttributedString alloc] initWithString:@"来自iPhone 6S Plus"
                                                               attributes:[TextStyle usernameStyle]];
    _fromNode.truncationMode = NSLineBreakByTruncatingTail;
    _fromNode.maximumNumberOfLines = 1;
    [self addSubnode:_fromNode];
    
    
    _avatarNode = [[ASNetworkImageNode alloc] init];
    _avatarNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
    _avatarNode.style.width = ASDimensionMakeWithPoints(44);
    _avatarNode.style.height = ASDimensionMakeWithPoints(44);
    _avatarNode.cornerRadius = 22.0;
    _avatarNode.URL = [NSURL URLWithString:[[self.tableViewItem.data objectForKey:@"author"] objectForKey:@"avatar"]];
//    _avatarNode.placeholderEnabled = YES;
//    _avatarNode.placeholderFadeDuration = 2;
    _avatarNode.imageModificationBlock = ^UIImage *(UIImage *image) {
        
        UIImage *modifiedImage;
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
        
        [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:44.0] addClip];
        [image drawInRect:rect];
        modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return modifiedImage;
        
    };
    [self addSubnode:_avatarNode];
    
    
    // title node
    _titleNode = [[ASTextNode alloc] init];
    _titleNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[self.tableViewItem.data objectForKey:@"timeTitle"]]
                                                                attributes:[TextStyle titleStyle]];
    _titleNode.style.flexShrink = YES; //if name and username don't fit to cell width, allow username shrink
    _titleNode.truncationMode = NSLineBreakByTruncatingTail;
    _titleNode.userInteractionEnabled = YES;

    _titleNode.maximumNumberOfLines = 1;
    
//    _titleNode.placeholderEnabled = YES;
//    _titleNode.placeholderFadeDuration = 2;
    
    [self addSubnode:_titleNode];
    
    // post node
    _contentNode = [[ASTextNode alloc] init];
    _contentNode.maximumNumberOfLines = 4;
    
    
//    _contentNode.placeholderEnabled = YES;
//    _contentNode.placeholderFadeDuration = 2;
    
    // processing URLs in post
    NSString *kLinkAttributeName = @"TextLinkAttributeName";
    
    if(![[self.tableViewItem.data objectForKey:@"content"] isEqualToString:@""]) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[self.tableViewItem.data objectForKey:@"content"]
                                                                                       attributes:[TextStyle postStyle]];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        
        [attrString addAttribute:NSParagraphStyleAttributeName
                           value:paragraphStyle
                           range:NSMakeRange(0, attrString.string.length)];
        NSDataDetector *urlDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        [urlDetector enumerateMatchesInString:attrString.string
                                      options:kNilOptions
                                        range:NSMakeRange(0, attrString.string.length)
                                   usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
         {
             if (result.resultType == NSTextCheckingTypeLink)
             {
                 
                 NSMutableDictionary *linkAttributes = [[NSMutableDictionary alloc] initWithDictionary:[TextStyle postLinkStyle]];
                 linkAttributes[kLinkAttributeName] = [NSURL URLWithString:result.URL.absoluteString];
                 
                 [attrString addAttributes:linkAttributes range:result.range];
             }
         }];
        
        // configure node to support tappable links
        _contentNode.delegate = self;
        _contentNode.userInteractionEnabled = YES;
        _contentNode.linkAttributeNames = @[ kLinkAttributeName ];
        _contentNode.attributedText = attrString;
        
        
    }
    
    [self addSubnode:_contentNode];
    
    
    // media
    NSArray *imageObjList = [self.tableViewItem.data objectForKey:@"imageObjList"];
    NSString *imageURL = @"";
    if ([imageObjList count] > 0) {
        imageURL = [[imageObjList objectAtIndex:0] objectForKey:@"imageUrl"];
    }
    if(![imageURL isEqualToString:@""]) {
        _mediaNode = [[ASNetworkImageNode alloc] init];
        _mediaNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
        _mediaNode.cornerRadius = 4.0;
        _mediaNode.URL = [NSURL URLWithString:imageURL];
        _mediaNode.delegate = self;
//        _mediaNode.placeholderEnabled = YES;
//        _mediaNode.placeholderFadeDuration = 2;
        _mediaNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:8.0] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            return modifiedImage;
            
        };
        [self addSubnode:_mediaNode];
    }
    
    // bottom controls likeCount
    _likesNode = [[LikesNode alloc] initWithLikesCount:[[self.tableViewItem.data objectForKey:@"likeCount"] integerValue]];
    [_likesNode addTarget:self action:@selector(onViewClick:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self addSubnode:_likesNode];
    
    _commentsNode = [[CommentsNode alloc] initWithCommentsCount:[[self.tableViewItem.data objectForKey:@"commentCount"] integerValue]];
    [_commentsNode addTarget:self action:@selector(onViewClick:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self addSubnode:_commentsNode];
    
//    for (ASDisplayNode *node in self.subnodes) {
//        if (node.supportsLayerBacking) {
//            node.layerBacked = YES;
//        }
//    }
}


- (void)onViewClick:(id)sender {
    if ([sender isEqual:_likesNode]) {
        NSLog(@"like click");
    }
    if ([sender isEqual:_commentsNode]) {
        NSLog(@"comment click");
    }
}


#pragma mark - layout cell content
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASLayoutSpec *spacer = [[ASLayoutSpec alloc] init];
    spacer.style.flexGrow = YES;
    
    ASStackLayoutSpec *nameStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                           spacing:8
                                                                    justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                          children:@[_nickNameNode,_timeNode]];
    nameStack.style.alignSelf = ASStackLayoutAlignSelfStretch;
    
    
    
    ASStackLayoutSpec *avatarStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                             spacing:6
                                                                      justifyContent:ASStackLayoutJustifyContentStart
                                                                          alignItems:ASStackLayoutAlignItemsCenter
                                                                            children:@[_avatarNode,nameStack,spacer,_fromNode]];
    avatarStack.style.alignSelf = ASStackLayoutAlignSelfStretch;
    
    NSMutableArray *mainStackContent = [[NSMutableArray alloc] init];
    
    [mainStackContent addObject:avatarStack];
    
    
    
    // bottom controls horizontal stack
    ASStackLayoutSpec *controlsStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                               spacing:10
                                                                        justifyContent:ASStackLayoutJustifyContentStart
                                                                            alignItems:ASStackLayoutAlignItemsCenter
                                                                              children:@[_likesNode, _commentsNode]];
    
    //add more gaps for control line
    controlsStack.style.spacingAfter = 3.0;
    controlsStack.style.spacingBefore = 3.0;
    
    [mainStackContent addObject:_titleNode];
    [mainStackContent addObject:_contentNode];
    
    
    if([[self.tableViewItem.data objectForKey:@"imageObjList"] count] > 0) {
        CGFloat imageRatio;
        if(_mediaNode.image != nil) {
            imageRatio = _mediaNode.image.size.height / _mediaNode.image.size.width;
        }else {
            imageRatio = 0.5;
        }
        ASRatioLayoutSpec *imagePlace = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:imageRatio
                                                                              child:_mediaNode];
        imagePlace.style.spacingAfter = 3.0;
        imagePlace.style.spacingBefore = 3.0;
        [mainStackContent addObject:imagePlace];
    }
    
    [mainStackContent addObject:controlsStack];
    
    //Vertical spec of cell main content
    ASStackLayoutSpec *contentSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                             spacing:8.0
                                                                      justifyContent:ASStackLayoutJustifyContentStart
                                                                          alignItems:ASStackLayoutAlignItemsStart
                                                                            children:mainStackContent];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                  child:contentSpec];
}



#pragma mark - <ASTextNodeDelegate>

- (BOOL)textNode:(ASTextNode *)richTextNode shouldHighlightLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point {
    // Opt into link highlighting -- tap and hold the link to try it!  must enable highlighting on a layer, see -didLoad
    return YES;
}

- (void)textNode:(ASTextNode *)richTextNode tappedLinkAttribute:(NSString *)attribute value:(NSURL *)URL atPoint:(CGPoint)point textRange:(NSRange)textRange {
    // The node tapped a link, open it
    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
        
    }];
}

#pragma mark - ASNetworkImageNodeDelegate methods.

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    [self setNeedsLayout];
}


@end
