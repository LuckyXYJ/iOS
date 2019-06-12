//
//  ContactsVC.m
//  BaseProject
//
//  Created by ios on 2019/3/25.
//  Copyright © 2019 ios. All rights reserved.
//

#import "ContactsVC.h"
#import <Contacts/Contacts.h>
@interface ContactsVC ()

@end

@implementation ContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(kScreenWidth/2.0 - 100 , 200, 200, 50);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(requestContactAuthorAfterSystemVersion9) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

//请求通讯录权限
#pragma mark 请求通讯录权限
- (void)requestContactAuthorAfterSystemVersion9{
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
            if (error) {
                NSLog(@"授权失败");
            }else {
                NSLog(@"成功授权");
            }
        }];
    }
    else if(status == CNAuthorizationStatusRestricted)
    {
        NSLog(@"用户拒绝");
        [self showAlertViewAboutNotAuthorAccessContact];
    }
    else if (status == CNAuthorizationStatusDenied)
    {
        NSLog(@"用户拒绝");
        [self showAlertViewAboutNotAuthorAccessContact];
    }
    else if (status == CNAuthorizationStatusAuthorized)//已经授权
    {
        //有通讯录权限-- 进行下一步操作
        [self openContact];
    }
    
}

//有通讯录权限-- 进行下一步操作
- (void)openContact{
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSLog(@"-------------------------------------------------------");
        
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
        //拼接姓名
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        
        //        CNPhoneNumber  * cnphoneNumber = contact.phoneNumbers[0];
        
        //        NSString * phoneNumber = cnphoneNumber.stringValue;
        
        for (CNLabeledValue *labelValue in phoneNumbers) {
            //遍历一个人名下的多个电话号码
            NSString *label = labelValue.label;
            //   NSString *    phoneNumber = labelValue.value;
            CNPhoneNumber *phoneNumber = labelValue.value;
            
            NSString * string = phoneNumber.stringValue ;
            
            //去掉电话中的特殊字符
            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSLog(@"姓名=%@, 电话号码是=%@", nameStr, string);
            
            
            
        }
        
        //    *stop = YES; // 停止循环，相当于break；
        
    }];
    
}




//提示没有通讯录权限
- (void)showAlertViewAboutNotAuthorAccessContact{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"请授权通讯录权限"
                                          message:@"请在iPhone的\"设置-隐私-通讯录\"选项中,允许访问你的通讯录"
                                          preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 //标识符
 CONTACTS_EXTERN NSString * const CNContactIdentifierKey                      NS_AVAILABLE(10_11, 9_0);
 //姓名前缀
 CONTACTS_EXTERN NSString * const CNContactNamePrefixKey                      NS_AVAILABLE(10_11, 9_0);
 //姓名
 CONTACTS_EXTERN NSString * const CNContactGivenNameKey                       NS_AVAILABLE(10_11, 9_0);
 //中间名
 CONTACTS_EXTERN NSString * const CNContactMiddleNameKey                      NS_AVAILABLE(10_11, 9_0);
 //姓氏
 CONTACTS_EXTERN NSString * const CNContactFamilyNameKey                      NS_AVAILABLE(10_11, 9_0);
 //之前的姓氏(ex:国外的女士)
 CONTACTS_EXTERN NSString * const CNContactPreviousFamilyNameKey              NS_AVAILABLE(10_11, 9_0);
 //姓名后缀
 CONTACTS_EXTERN NSString * const CNContactNameSuffixKey                      NS_AVAILABLE(10_11, 9_0);
 //昵称
 CONTACTS_EXTERN NSString * const CNContactNicknameKey                        NS_AVAILABLE(10_11, 9_0);
 //公司(组织)
 CONTACTS_EXTERN NSString * const CNContactOrganizationNameKey                NS_AVAILABLE(10_11, 9_0);
 //部门
 CONTACTS_EXTERN NSString * const CNContactDepartmentNameKey                  NS_AVAILABLE(10_11, 9_0);
 //职位
 CONTACTS_EXTERN NSString * const CNContactJobTitleKey                        NS_AVAILABLE(10_11, 9_0);
 //名字的拼音或音标
 CONTACTS_EXTERN NSString * const CNContactPhoneticGivenNameKey               NS_AVAILABLE(10_11, 9_0);
 //中间名的拼音或音标
 CONTACTS_EXTERN NSString * const CNContactPhoneticMiddleNameKey              NS_AVAILABLE(10_11, 9_0);
 //形式的拼音或音标
 CONTACTS_EXTERN NSString * const CNContactPhoneticFamilyNameKey              NS_AVAILABLE(10_11, 9_0);
 //公司(组织)的拼音或音标(iOS10 才开始存在的呢)
 CONTACTS_EXTERN NSString * const CNContactPhoneticOrganizationNameKey        NS_AVAILABLE(10_12, 10_0);
 //生日
 CONTACTS_EXTERN NSString * const CNContactBirthdayKey                        NS_AVAILABLE(10_11, 9_0);
 //农历
 CONTACTS_EXTERN NSString * const CNContactNonGregorianBirthdayKey            NS_AVAILABLE(10_11, 9_0);
 //备注
 CONTACTS_EXTERN NSString * const CNContactNoteKey                            NS_AVAILABLE(10_11, 9_0);
 //头像
 CONTACTS_EXTERN NSString * const CNContactImageDataKey                       NS_AVAILABLE(10_11, 9_0);
 //头像的缩略图
 CONTACTS_EXTERN NSString * const CNContactThumbnailImageDataKey              NS_AVAILABLE(10_11, 9_0);
 //头像是否可用
 CONTACTS_EXTERN NSString * const CNContactImageDataAvailableKey              NS_AVAILABLE(10_12, 9_0);
 //类型
 CONTACTS_EXTERN NSString * const CNContactTypeKey                            NS_AVAILABLE(10_11, 9_0);
 //电话号码
 CONTACTS_EXTERN NSString * const CNContactPhoneNumbersKey                    NS_AVAILABLE(10_11, 9_0);
 //邮箱地址
 CONTACTS_EXTERN NSString * const CNContactEmailAddressesKey                  NS_AVAILABLE(10_11, 9_0);
 //住址
 CONTACTS_EXTERN NSString * const CNContactPostalAddressesKey                 NS_AVAILABLE(10_11, 9_0);
 //其他日期
 CONTACTS_EXTERN NSString * const CNContactDatesKey                           NS_AVAILABLE(10_11, 9_0);
 //url地址
 CONTACTS_EXTERN NSString * const CNContactUrlAddressesKey                    NS_AVAILABLE(10_11, 9_0);
 //关联人
 CONTACTS_EXTERN NSString * const CNContactRelationsKey                       NS_AVAILABLE(10_11, 9_0);
 //社交
 CONTACTS_EXTERN NSString * const CNContactSocialProfilesKey                  NS_AVAILABLE(10_11, 9_0);
 //即时通信
 CONTACTS_EXTERN NSString * const CNContactInstantMessageAddressesKey         NS_AVAILABLE(10_11, 9_0);
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
