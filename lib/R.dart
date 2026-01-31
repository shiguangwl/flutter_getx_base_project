/// 资源文件管理类
/// 统一管理应用中的图片、字符串等资源
/// 此文件由脚本自动生成，请勿手动修改
/// 生成时间: 2025-09-06T07:17:49Z
class R {
  // 私有构造函数，防止实例化
  R._();

  // 图片资源
  static const String publishActive = 'assets/images/publish_active.png';
  static const String plus = 'assets/images/plus.png';
  static const String support = 'assets/images/support.png';
  static const String aggregatedPayment =
      'assets/images/aggregated_payment.png';
  static const String profileActive = 'assets/images/profile_active.png';
  static const String failed = 'assets/images/failed.png';
  static const String eCny = 'assets/images/e_cny.png';
  static const String imageEmpty = 'assets/images/image_empty.webp';
  static const String cancelled = 'assets/images/cancelled.png';
  static const String imageFail = 'assets/images/image_fail.png';
  static const String account = 'assets/images/account.png';
  static const String gradientBg = 'assets/images/gradient_bg.png';
  static const String usdt = 'assets/images/usdt.png';
  static const String accountActive = 'assets/images/account_active.png';
  static const String accountRecords = 'assets/images/account_records.png';
  static const String completed = 'assets/images/completed.png';
  static const String done = 'assets/images/done.png';
  static const String published = 'assets/images/published.png';
  static const String logo = 'assets/images/logo.png';
  static const String notifications = 'assets/images/notifications.png';
  static const String qrCode = 'assets/images/qr_code.png';
  static const String profile = 'assets/images/profile.png';
  static const String alipay = 'assets/images/alipay.png';
  static const String unionpayQuickpass =
      'assets/images/unionpay_quickpass.png';
  static const String faq = 'assets/images/faq.png';
  static const String income = 'assets/images/income.png';
  static const String expense = 'assets/images/expense.png';
  static const String inviteCode = 'assets/images/invite_code.png';
  static const String feeRate = 'assets/images/fee_rate.png';
  static const String wechat = 'assets/images/wechat.png';
  static const String publish = 'assets/images/publish.png';
  static const String unionpay = 'assets/images/unionpay.png';
  static const String huaBei = 'assets/images/huabei.png';
  static const String baiTiao = 'assets/images/baitiao.png';
  static const String xinyongka = 'assets/images/visa.png';
  static const String otherPayWay = 'assets/images/other_payway.png';
  static const String bad = 'assets/images/bad.png';
  static const String inProgress = 'assets/images/in_progress.png';
  static const String qrCodeActive = 'assets/images/qr_code_active.png';
  static const String selected = 'assets/images/selected.png';
  static const String delete = 'assets/images/delete.png';
  static const String bgCancelOk = 'assets/images/bg_cancel_ok.png';
  static const String bgCancel = 'assets/images/bg_cancel.png';
  static const String bgComplete = 'assets/images/bg_complete.png';
  static const String bgFailed = 'assets/images/bg_failed.png';
  static const String bgInProgress = 'assets/images/bg_in_progress.png';

  /// 获取所有图片资源路径
  static List<String> get allImages => [
        publishActive,
        plus,
        support,
        aggregatedPayment,
        profileActive,
        failed,
        eCny,
        imageEmpty,
        cancelled,
        imageFail,
        account,
        gradientBg,
        expense,
        usdt,
        accountActive,
        accountRecords,
        completed,
        done,
        published,
        logo,
        notifications,
        qrCode,
        profile,
        alipay,
        unionpayQuickpass,
        faq,
        income,
        inviteCode,
        feeRate,
        wechat,
        publish,
        unionpay,
        bad,
        inProgress,
        qrCodeActive,
      ];

  /// 获取所有资源路径
  static List<String> get allResources => [
        publishActive,
        plus,
        support,
        aggregatedPayment,
        profileActive,
        failed,
        eCny,
        imageEmpty,
        cancelled,
        imageFail,
        account,
        gradientBg,
        expense,
        usdt,
        accountActive,
        accountRecords,
        completed,
        done,
        published,
        logo,
        notifications,
        qrCode,
        profile,
        alipay,
        unionpayQuickpass,
        faq,
        income,
        inviteCode,
        feeRate,
        wechat,
        publish,
        unionpay,
        bad,
        inProgress,
        qrCodeActive,
      ];

  /// 根据资源名称获取路径
  static String? getResourcePath(String name) {
    switch (name) {
      case 'publishActive':
        return publishActive;
      case 'plus':
        return plus;
      case 'support':
        return support;
      case 'aggregatedPayment':
        return aggregatedPayment;
      case 'profileActive':
        return profileActive;
      case 'failed':
        return failed;
      case 'eCny':
        return eCny;
      case 'imageEmpty':
        return imageEmpty;
      case 'cancelled':
        return cancelled;
      case 'imageFail':
        return imageFail;
      case 'account':
        return account;
      case 'gradientBg':
        return gradientBg;
      case 'expense':
        return expense;
      case 'usdt':
        return usdt;
      case 'accountActive':
        return accountActive;
      case 'accountRecords':
        return accountRecords;
      case 'completed':
        return completed;
      case 'done':
        return done;
      case 'published':
        return published;
      case 'logo':
        return logo;
      case 'notifications':
        return notifications;
      case 'qrCode':
        return qrCode;
      case 'profile':
        return profile;
      case 'alipay':
        return alipay;
      case 'unionpayQuickpass':
        return unionpayQuickpass;
      case 'faq':
        return faq;
      case 'income':
        return income;
      case 'inviteCode':
        return inviteCode;
      case 'feeRate':
        return feeRate;
      case 'wechat':
        return wechat;
      case 'publish':
        return publish;
      case 'unionpay':
        return unionpay;
      case 'bad':
        return bad;
      case 'inProgress':
        return inProgress;
      case 'qrCodeActive':
        return qrCodeActive;
      default:
        return null;
    }
  }
}
