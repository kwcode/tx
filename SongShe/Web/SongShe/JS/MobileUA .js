//$(function () {
//    var MobileUA = (function () {
//        var ua = navigator.userAgent.toLowerCase();

//        var mua = {
//            IOS: /ipod|iphone|ipad/.test(ua), //iOS
//            IPHONE: /iphone/.test(ua), //iPhone
//            IPAD: /ipad/.test(ua), //iPad
//            ANDROID: /android/.test(ua), //Android Device
//            WINDOWS: /windows/.test(ua), //Windows Device
//            TOUCH_DEVICE: ('ontouchstart' in window) || /touch/.test(ua), //Touch Device
//            MOBILE: /mobile/.test(ua), //Mobile Device (iPad)
//            ANDROID_TABLET: false, //Android Tablet
//            WINDOWS_TABLET: false, //Windows Tablet
//            TABLET: false, //Tablet (iPad, Android, Windows)
//            SMART_PHONE: false //Smart Phone (iPhone, Android)
//        };

//        mua.ANDROID_TABLET = mua.ANDROID && !mua.MOBILE;
//        mua.WINDOWS_TABLET = mua.WINDOWS && /tablet/.test(ua);
//        mua.TABLET = mua.IPAD || mua.ANDROID_TABLET || mua.WINDOWS_TABLET;
//        mua.SMART_PHONE = mua.MOBILE && !mua.TABLET;

//        return mua;
//    }());

//    //SmartPhone 
//    if (!MobileUA.SMART_PHONE) {
//        // 移动端链接地址
//        document.location.href = '/MobileSongShe/Index.aspx';
//    }
//});

function browserRedirect() {
    var sUserAgent = navigator.userAgent.toLowerCase();
    var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
    var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
    var bIsMidp = sUserAgent.match(/midp/i) == "midp";
    var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
    var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
    var bIsAndroid = sUserAgent.match(/android/i) == "android";
    var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
    var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
    
    if (bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
        //window.location.href = '/MobileSongShe/Index.aspx';//alert("phone");//document.writeln("phone");
    } else {
        window.location.href = '/SongShe/Index.html';//alert("pc"); //document.writeln("pc");
    }
}
browserRedirect();