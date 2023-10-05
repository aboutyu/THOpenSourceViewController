import XCTest
@testable import THOpenSourceViewController

final class THOpenSourceViewControllerTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(THOpenSourceViewController(setItems()))
    }
    
    private func setItems() -> [THLicensesKeyEntity] {
        var items: [THLicensesKeyEntity] = []
        items.append(THLicensesKeyEntity(name: "ChannelIOSDK", license: .mit))
        items.append(THLicensesKeyEntity(name: "MessageKit", license: .mit, year: "2017-2022"))
        items.append(THLicensesKeyEntity(name: "Nuke", license: .mit, year: "2015-2022", licenseName: "Alexander Grebenyuk"))
        items.append(THLicensesKeyEntity(name: "AmazonChimeSDK-Bitcode", license: .apache2, licenseName: "Amazon.com, Inc. or its affiliates"))
        items.append(THLicensesKeyEntity(name: "Charts", license: .apache2, year: "2016", licenseName: "Daniel Cohen Gindi & Philipp Jahoda"))
        items.append(THLicensesKeyEntity(name: "DateToolsSwift", license: .mit, year: "2014", licenseName: "Matthew York"))
        items.append(THLicensesKeyEntity(name: "FSPagerView", license: .mit))
        items.append(THLicensesKeyEntity(name: "Moya", license: .mit, year: "2014-present", licenseName: "Artsy, Ash Furrow"))
        items.append(THLicensesKeyEntity(name: "SwiftGifOrigin", license: .mit, year: "2016", licenseName: "Arne Bahlo"))
        items.append(THLicensesKeyEntity(name: "SwiftLint", license: .mit, year: "2020", licenseName: "Realm Inc."))
        items.append(THLicensesKeyEntity(name: "SwiftyJSON", license: .mit, year: "2017", licenseName: "Ruoyu Fu"))
        items.append(THLicensesKeyEntity(name: "TagListView", license: .mit, year: "2015", licenseName: "LIU Dongyuan"))
        items.append(THLicensesKeyEntity(name: "Firebase", license: .apache2))
        items.append(THLicensesKeyEntity(name: "KakaoSDKCommon", license: .apache2))
        items.append(THLicensesKeyEntity(name: "KakaoSDKAuth", license: .apache2))
        items.append(THLicensesKeyEntity(name: "KakaoSDKUser", license: .apache2))
        items.append(THLicensesKeyEntity(name: "naveridlogin-sdk-ios", license: .apache2))
        items.append(THLicensesKeyEntity(name: "NMapsMap", license: .apache2))
        items.append(THLicensesKeyEntity(name: "IQKeyboardManager", license: .mit, year: "2013-2017", licenseName: "Iftekhar Qurashi"))
        items.append(THLicensesKeyEntity(name: "ExyteGrid", license: .mit, year: "2020", licenseName: "Denis Obukhov <denis.obukhov@exyte.com>"))
        items.append(THLicensesKeyEntity(name: "FSCalendar", license: .mit, year: "2013-2016", licenseName: "Iftekhar Qurashi"))
        items.append(THLicensesKeyEntity(name: "Kingfisher", license: .mit, year: "2019", licenseName: "Wei Wang"))
        items.append(THLicensesKeyEntity(name: "ReactorKit", license: .mit, year: "2017", licenseName: "Suyeol Jeon (xoul.kr)"))
        items.append(THLicensesKeyEntity(name: "RxDataSources", license: .mit, year: "2017", licenseName: "RxSwift Community"))
        items.append(THLicensesKeyEntity(name: "RxExpect", license: .mit, year: "2016", licenseName: "Suyeol Jeon (xoul.kr)"))
        items.append(THLicensesKeyEntity(name: "RxGesture", license: .mit, licenseName: "RxSwiftCommunity"))
        items.append(THLicensesKeyEntity(name: "RxOptional", license: .mit, year: "2016", licenseName: "Thane Gill <me@thanegill.com>"))
        items.append(THLicensesKeyEntity(name: "RxSwift", license: .mit, year: "2015", licenseName: "Krunoslav Zaher, Shai Mishali"))
        items.append(THLicensesKeyEntity(name: "RxViewController", license: .mit, year: "2017", licenseName: "Suyeol Jeon (xoul.kr)"))
        items.append(THLicensesKeyEntity(name: "SnapKit", license: .mit, year: "2011-Present", licenseName: "SnapKit Team - https://github.com/SnapKit"))
        items.append(THLicensesKeyEntity(name: "Then", license: .mit, year: "2015", licenseName: "Suyeol Jeon (xoul.kr)"))
        items.append(THLicensesKeyEntity(name: "Toast-Swift", license: .mit, year: "2015-2019", licenseName: "Charles Scalesse"))
        items.append(THLicensesKeyEntity(name: "keychain-swift", license: .mit, year: "2015-2021", licenseName: "Evgenii Neumerzhitckii"))
        items.append(THLicensesKeyEntity(name: "RSKPlaceholderTextView", license: .apache2, year: "2015-present", licenseName: "Ruslan Skorb"))
        
        return items
    }
}
