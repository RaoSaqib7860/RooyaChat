import 'UserChatModel.dart';

class GroupChatModel {
  int? apiStatus;
  Data? data;

  GroupChatModel({this.apiStatus, this.data});

  GroupChatModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? groupId;
  String? userId;
  String? groupName;
  String? groupType;
  String? groupPrivacy;
  String? groupPassword;
  String? groupCity;
  String? lat;
  String? lng;
  String? avatar;
  String? time;
  String? expiry;
  List<Messages>? messages;

  Data(
      {this.groupId,
        this.userId,
        this.groupName,
        this.groupType,
        this.groupPrivacy,
        this.groupPassword,
        this.groupCity,
        this.lat,
        this.lng,
        this.avatar,
        this.time,
        this.expiry,
        this.messages});

  Data.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'].toString();
    userId = json['user_id'].toString();
    groupName = json['group_name'].toString();
    groupType = json['group_type'].toString();
    groupPrivacy = json['group_privacy'].toString();
    groupPassword = json['group_password'].toString();
    groupCity = json['group_city'].toString();
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    avatar = json['avatar'].toString();
    time = json['time'].toString();
    expiry = json['expiry'].toString();
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['group_name'] = this.groupName;
    data['group_type'] = this.groupType;
    data['group_privacy'] = this.groupPrivacy;
    data['group_password'] = this.groupPassword;
    data['group_city'] = this.groupCity;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['avatar'] = this.avatar;
    data['time'] = this.time;
    data['expiry'] = this.expiry;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReadReceipts {
  String? time;
  String? delivered;
  String? seen;
  User? user;

  ReadReceipts({this.time, this.delivered, this.seen, this.user});

  ReadReceipts.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    delivered = json['delivered'];
    seen = json['seen'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['delivered'] = this.delivered;
    data['seen'] = this.seen;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? userId;
  String? username;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? avatar;
  String? cover;
  String? backgroundImage;
  String? backgroundImageStatus;
  String? relationshipId;
  String? address;
  String? working;
  String? workingLink;
  String? about;
  String? school;
  String? gender;
  String? birthday;
  String? countryId;
  String? website;
  String? facebook;
  String? google;
  String? twitter;
  String? linkedin;
  String? youtube;
  String? vk;
  String? instagram;
  Null? qq;
  Null? wechat;
  Null? discord;
  Null? mailru;
  String? okru;
  String? language;
  String? emailCode;
  String? src;
  String? ipAddress;
  String? followPrivacy;
  String? friendPrivacy;
  String? postPrivacy;
  String? messagePrivacy;
  String? confirmFollowers;
  String? showActivitiesPrivacy;
  String? birthPrivacy;
  String? visitPrivacy;
  String? verified;
  String? lastseen;
  String? showlastseen;
  String? emailNotification;
  String? eLiked;
  String? eWondered;
  String? eShared;
  String? eFollowed;
  String? eCommented;
  String? eVisited;
  String? eLikedPage;
  String? eMentioned;
  String? eJoinedGroup;
  String? eAccepted;
  String? eProfileWallPost;
  String? eSentmeMsg;
  String? eLastNotif;
  String? notificationSettings;
  String? status;
  String? active;
  String? admin;
  String? type;
  String? registered;
  String? startUp;
  String? startUpInfo;
  String? startupFollow;
  String? startupImage;
  String? lastEmailSent;
  String? phoneNumber;
  String? smsCode;
  String? isPro;
  String? proTime;
  String? proType;
  String? joined;
  String? cssFile;
  String? timezone;
  String? referrer;
  String? refUserId;
  Null? refLevel;
  String? balance;
  String? paypalEmail;
  String? notificationsSound;
  String? orderPostsBy;
  String? socialLogin;
  String? androidMDeviceId;
  String? iosMDeviceId;
  String? androidNDeviceId;
  String? iosNDeviceId;
  String? webDeviceId;
  String? wallet;
  String? lat;
  String? lng;
  String? lastLocationUpdate;
  String? shareMyLocation;
  String? lastDataUpdate;
  Details? details;
  String? sidebarData;
  String? lastAvatarMod;
  String? lastCoverMod;
  String? points;
  String? dailyPoints;
  String? pointDayExpire;
  String? lastFollowId;
  String? shareMyData;
  Null? lastLoginData;
  String? twoFactor;
  String? newEmail;
  String? twoFactorVerified;
  String? newPhone;
  String? infoFile;
  String? city;
  String? state;
  String? zip;
  String? schoolCompleted;
  String? weatherUnit;
  String? paystackRef;
  String? codeSent;
  Null? stripeSessionId;
  String? timeCodeSent;
  Null? permission;
  Null? skills;
  Null? languages;
  String? currentlyWorking;
  String? banned;
  String? bannedReason;
  String? coinbaseHash;
  String? coinbaseCode;
  String? yoomoneyHash;
  String? conversationId;
  String? securionpayKey;
  String? avatarPostId;
  String? coverPostId;
  String? avatarOrg;
  String? coverOrg;
  String? coverFull;
  String? avatarFull;
  String? id;
  String? userPlatform;
  String? url;
  String? name;
  APINotificationSettings? aPINotificationSettings;
  int? isNotifyStopped;
  List<String>? followingData;
  List<String>? followersData;
  List<String>? mutualFriendsData;
  String? likesData;
  String? groupsData;
  String? albumData;
  String? lastseenUnixTime;
  String? lastseenStatus;
  bool? isReported;
  bool? isStoryMuted;
  int? isFollowingMe;
  int? isOpenToWork;
  int? isProvidingService;
  int? providingService;
  String? openToWorkData;
  List<Null>? formatedLangs;

  User(
      {this.userId,
        this.username,
        this.email,
        this.password,
        this.firstName,
        this.lastName,
        this.avatar,
        this.cover,
        this.backgroundImage,
        this.backgroundImageStatus,
        this.relationshipId,
        this.address,
        this.working,
        this.workingLink,
        this.about,
        this.school,
        this.gender,
        this.birthday,
        this.countryId,
        this.website,
        this.facebook,
        this.google,
        this.twitter,
        this.linkedin,
        this.youtube,
        this.vk,
        this.instagram,
        this.qq,
        this.wechat,
        this.discord,
        this.mailru,
        this.okru,
        this.language,
        this.emailCode,
        this.src,
        this.ipAddress,
        this.followPrivacy,
        this.friendPrivacy,
        this.postPrivacy,
        this.messagePrivacy,
        this.confirmFollowers,
        this.showActivitiesPrivacy,
        this.birthPrivacy,
        this.visitPrivacy,
        this.verified,
        this.lastseen,
        this.showlastseen,
        this.emailNotification,
        this.eLiked,
        this.eWondered,
        this.eShared,
        this.eFollowed,
        this.eCommented,
        this.eVisited,
        this.eLikedPage,
        this.eMentioned,
        this.eJoinedGroup,
        this.eAccepted,
        this.eProfileWallPost,
        this.eSentmeMsg,
        this.eLastNotif,
        this.notificationSettings,
        this.status,
        this.active,
        this.admin,
        this.type,
        this.registered,
        this.startUp,
        this.startUpInfo,
        this.startupFollow,
        this.startupImage,
        this.lastEmailSent,
        this.phoneNumber,
        this.smsCode,
        this.isPro,
        this.proTime,
        this.proType,
        this.joined,
        this.cssFile,
        this.timezone,
        this.referrer,
        this.refUserId,
        this.refLevel,
        this.balance,
        this.paypalEmail,
        this.notificationsSound,
        this.orderPostsBy,
        this.socialLogin,
        this.androidMDeviceId,
        this.iosMDeviceId,
        this.androidNDeviceId,
        this.iosNDeviceId,
        this.webDeviceId,
        this.wallet,
        this.lat,
        this.lng,
        this.lastLocationUpdate,
        this.shareMyLocation,
        this.lastDataUpdate,
        this.details,
        this.sidebarData,
        this.lastAvatarMod,
        this.lastCoverMod,
        this.points,
        this.dailyPoints,
        this.pointDayExpire,
        this.lastFollowId,
        this.shareMyData,
        this.lastLoginData,
        this.twoFactor,
        this.newEmail,
        this.twoFactorVerified,
        this.newPhone,
        this.infoFile,
        this.city,
        this.state,
        this.zip,
        this.schoolCompleted,
        this.weatherUnit,
        this.paystackRef,
        this.codeSent,
        this.stripeSessionId,
        this.timeCodeSent,
        this.permission,
        this.skills,
        this.languages,
        this.currentlyWorking,
        this.banned,
        this.bannedReason,
        this.coinbaseHash,
        this.coinbaseCode,
        this.yoomoneyHash,
        this.conversationId,
        this.securionpayKey,
        this.avatarPostId,
        this.coverPostId,
        this.avatarOrg,
        this.coverOrg,
        this.coverFull,
        this.avatarFull,
        this.id,
        this.userPlatform,
        this.url,
        this.name,
        this.aPINotificationSettings,
        this.isNotifyStopped,
        this.followingData,
        this.followersData,
        this.mutualFriendsData,
        this.likesData,
        this.groupsData,
        this.albumData,
        this.lastseenUnixTime,
        this.lastseenStatus,
        this.isReported,
        this.isStoryMuted,
        this.isFollowingMe,
        this.isOpenToWork,
        this.isProvidingService,
        this.providingService,
        this.openToWorkData,
        this.formatedLangs});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    cover = json['cover'];
    backgroundImage = json['background_image'];
    backgroundImageStatus = json['background_image_status'];
    relationshipId = json['relationship_id'];
    address = json['address'];
    working = json['working'];
    workingLink = json['working_link'];
    about = json['about'];
    school = json['school'];
    gender = json['gender'];
    birthday = json['birthday'];
    countryId = json['country_id'];
    website = json['website'];
    facebook = json['facebook'];
    google = json['google'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
    vk = json['vk'];
    instagram = json['instagram'];
    qq = json['qq'];
    wechat = json['wechat'];
    discord = json['discord'];
    mailru = json['mailru'];
    okru = json['okru'];
    language = json['language'];
    emailCode = json['email_code'];
    src = json['src'];
    ipAddress = json['ip_address'];
    followPrivacy = json['follow_privacy'];
    friendPrivacy = json['friend_privacy'];
    postPrivacy = json['post_privacy'];
    messagePrivacy = json['message_privacy'];
    confirmFollowers = json['confirm_followers'];
    showActivitiesPrivacy = json['show_activities_privacy'];
    birthPrivacy = json['birth_privacy'];
    visitPrivacy = json['visit_privacy'];
    verified = json['verified'];
    lastseen = json['lastseen'];
    showlastseen = json['showlastseen'];
    emailNotification = json['emailNotification'];
    eLiked = json['e_liked'];
    eWondered = json['e_wondered'];
    eShared = json['e_shared'];
    eFollowed = json['e_followed'];
    eCommented = json['e_commented'];
    eVisited = json['e_visited'];
    eLikedPage = json['e_liked_page'];
    eMentioned = json['e_mentioned'];
    eJoinedGroup = json['e_joined_group'];
    eAccepted = json['e_accepted'];
    eProfileWallPost = json['e_profile_wall_post'];
    eSentmeMsg = json['e_sentme_msg'];
    eLastNotif = json['e_last_notif'];
    notificationSettings = json['notification_settings'];
    status = json['status'];
    active = json['active'];
    admin = json['admin'];
    type = json['type'];
    registered = json['registered'];
    startUp = json['start_up'];
    startUpInfo = json['start_up_info'];
    startupFollow = json['startup_follow'];
    startupImage = json['startup_image'];
    lastEmailSent = json['last_email_sent'];
    phoneNumber = json['phone_number'];
    smsCode = json['sms_code'];
    isPro = json['is_pro'];
    proTime = json['pro_time'];
    proType = json['pro_type'];
    joined = json['joined'];
    cssFile = json['css_file'];
    timezone = json['timezone'];
    referrer = json['referrer'];
    refUserId = json['ref_user_id'];
    refLevel = json['ref_level'];
    balance = json['balance'];
    paypalEmail = json['paypal_email'];
    notificationsSound = json['notifications_sound'];
    orderPostsBy = json['order_posts_by'];
    socialLogin = json['social_login'];
    androidMDeviceId = json['android_m_device_id'];
    iosMDeviceId = json['ios_m_device_id'];
    androidNDeviceId = json['android_n_device_id'];
    iosNDeviceId = json['ios_n_device_id'];
    webDeviceId = json['web_device_id'];
    wallet = json['wallet'];
    lat = json['lat'];
    lng = json['lng'];
    lastLocationUpdate = json['last_location_update'];
    shareMyLocation = json['share_my_location'];
    lastDataUpdate = json['last_data_update'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    sidebarData = json['sidebar_data'];
    lastAvatarMod = json['last_avatar_mod'];
    lastCoverMod = json['last_cover_mod'];
    points = json['points'];
    dailyPoints = json['daily_points'];
    pointDayExpire = json['point_day_expire'];
    lastFollowId = json['last_follow_id'];
    shareMyData = json['share_my_data'];
    lastLoginData = json['last_login_data'];
    twoFactor = json['two_factor'];
    newEmail = json['new_email'];
    twoFactorVerified = json['two_factor_verified'];
    newPhone = json['new_phone'];
    infoFile = json['info_file'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    schoolCompleted = json['school_completed'];
    weatherUnit = json['weather_unit'];
    paystackRef = json['paystack_ref'];
    codeSent = json['code_sent'];
    stripeSessionId = json['StripeSessionId'];
    timeCodeSent = json['time_code_sent'];
    permission = json['permission'];
    skills = json['skills'];
    languages = json['languages'];
    currentlyWorking = json['currently_working'];
    banned = json['banned'];
    bannedReason = json['banned_reason'];
    coinbaseHash = json['coinbase_hash'];
    coinbaseCode = json['coinbase_code'];
    yoomoneyHash = json['yoomoney_hash'];
    conversationId = json['ConversationId'];
    securionpayKey = json['securionpay_key'];
    avatarPostId = json['avatar_post_id'];
    coverPostId = json['cover_post_id'];
    avatarOrg = json['avatar_org'];
    coverOrg = json['cover_org'];
    coverFull = json['cover_full'];
    avatarFull = json['avatar_full'];
    id = json['id'];
    userPlatform = json['user_platform'];
    url = json['url'];
    name = json['name'];
    aPINotificationSettings = json['API_notification_settings'] != null
        ? new APINotificationSettings.fromJson(
        json['API_notification_settings'])
        : null;
    isNotifyStopped = json['is_notify_stopped'];
    followingData = json['following_data'].cast<String>();
    followersData = json['followers_data'].cast<String>();
    mutualFriendsData = json['mutual_friends_data'].cast<String>();
    likesData = json['likes_data'];
    groupsData = json['groups_data'];
    albumData = json['album_data'];
    lastseenUnixTime = json['lastseen_unix_time'];
    lastseenStatus = json['lastseen_status'];
    isReported = json['is_reported'];
    isStoryMuted = json['is_story_muted'];
    isFollowingMe = json['is_following_me'];
    isOpenToWork = json['is_open_to_work'];
    isProvidingService = json['is_providing_service'];
    providingService = json['providing_service'];
    openToWorkData = json['open_to_work_data'];
    // if (json['formated_langs'] != null) {
    //   formatedLangs = <Null>[];
    //   json['formated_langs'].forEach((v) {
    //     formatedLangs!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    data['cover'] = this.cover;
    data['background_image'] = this.backgroundImage;
    data['background_image_status'] = this.backgroundImageStatus;
    data['relationship_id'] = this.relationshipId;
    data['address'] = this.address;
    data['working'] = this.working;
    data['working_link'] = this.workingLink;
    data['about'] = this.about;
    data['school'] = this.school;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['country_id'] = this.countryId;
    data['website'] = this.website;
    data['facebook'] = this.facebook;
    data['google'] = this.google;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['youtube'] = this.youtube;
    data['vk'] = this.vk;
    data['instagram'] = this.instagram;
    data['qq'] = this.qq;
    data['wechat'] = this.wechat;
    data['discord'] = this.discord;
    data['mailru'] = this.mailru;
    data['okru'] = this.okru;
    data['language'] = this.language;
    data['email_code'] = this.emailCode;
    data['src'] = this.src;
    data['ip_address'] = this.ipAddress;
    data['follow_privacy'] = this.followPrivacy;
    data['friend_privacy'] = this.friendPrivacy;
    data['post_privacy'] = this.postPrivacy;
    data['message_privacy'] = this.messagePrivacy;
    data['confirm_followers'] = this.confirmFollowers;
    data['show_activities_privacy'] = this.showActivitiesPrivacy;
    data['birth_privacy'] = this.birthPrivacy;
    data['visit_privacy'] = this.visitPrivacy;
    data['verified'] = this.verified;
    data['lastseen'] = this.lastseen;
    data['showlastseen'] = this.showlastseen;
    data['emailNotification'] = this.emailNotification;
    data['e_liked'] = this.eLiked;
    data['e_wondered'] = this.eWondered;
    data['e_shared'] = this.eShared;
    data['e_followed'] = this.eFollowed;
    data['e_commented'] = this.eCommented;
    data['e_visited'] = this.eVisited;
    data['e_liked_page'] = this.eLikedPage;
    data['e_mentioned'] = this.eMentioned;
    data['e_joined_group'] = this.eJoinedGroup;
    data['e_accepted'] = this.eAccepted;
    data['e_profile_wall_post'] = this.eProfileWallPost;
    data['e_sentme_msg'] = this.eSentmeMsg;
    data['e_last_notif'] = this.eLastNotif;
    data['notification_settings'] = this.notificationSettings;
    data['status'] = this.status;
    data['active'] = this.active;
    data['admin'] = this.admin;
    data['type'] = this.type;
    data['registered'] = this.registered;
    data['start_up'] = this.startUp;
    data['start_up_info'] = this.startUpInfo;
    data['startup_follow'] = this.startupFollow;
    data['startup_image'] = this.startupImage;
    data['last_email_sent'] = this.lastEmailSent;
    data['phone_number'] = this.phoneNumber;
    data['sms_code'] = this.smsCode;
    data['is_pro'] = this.isPro;
    data['pro_time'] = this.proTime;
    data['pro_type'] = this.proType;
    data['joined'] = this.joined;
    data['css_file'] = this.cssFile;
    data['timezone'] = this.timezone;
    data['referrer'] = this.referrer;
    data['ref_user_id'] = this.refUserId;
    data['ref_level'] = this.refLevel;
    data['balance'] = this.balance;
    data['paypal_email'] = this.paypalEmail;
    data['notifications_sound'] = this.notificationsSound;
    data['order_posts_by'] = this.orderPostsBy;
    data['social_login'] = this.socialLogin;
    data['android_m_device_id'] = this.androidMDeviceId;
    data['ios_m_device_id'] = this.iosMDeviceId;
    data['android_n_device_id'] = this.androidNDeviceId;
    data['ios_n_device_id'] = this.iosNDeviceId;
    data['web_device_id'] = this.webDeviceId;
    data['wallet'] = this.wallet;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['last_location_update'] = this.lastLocationUpdate;
    data['share_my_location'] = this.shareMyLocation;
    data['last_data_update'] = this.lastDataUpdate;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['sidebar_data'] = this.sidebarData;
    data['last_avatar_mod'] = this.lastAvatarMod;
    data['last_cover_mod'] = this.lastCoverMod;
    data['points'] = this.points;
    data['daily_points'] = this.dailyPoints;
    data['point_day_expire'] = this.pointDayExpire;
    data['last_follow_id'] = this.lastFollowId;
    data['share_my_data'] = this.shareMyData;
    data['last_login_data'] = this.lastLoginData;
    data['two_factor'] = this.twoFactor;
    data['new_email'] = this.newEmail;
    data['two_factor_verified'] = this.twoFactorVerified;
    data['new_phone'] = this.newPhone;
    data['info_file'] = this.infoFile;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['school_completed'] = this.schoolCompleted;
    data['weather_unit'] = this.weatherUnit;
    data['paystack_ref'] = this.paystackRef;
    data['code_sent'] = this.codeSent;
    data['StripeSessionId'] = this.stripeSessionId;
    data['time_code_sent'] = this.timeCodeSent;
    data['permission'] = this.permission;
    data['skills'] = this.skills;
    data['languages'] = this.languages;
    data['currently_working'] = this.currentlyWorking;
    data['banned'] = this.banned;
    data['banned_reason'] = this.bannedReason;
    data['coinbase_hash'] = this.coinbaseHash;
    data['coinbase_code'] = this.coinbaseCode;
    data['yoomoney_hash'] = this.yoomoneyHash;
    data['ConversationId'] = this.conversationId;
    data['securionpay_key'] = this.securionpayKey;
    data['avatar_post_id'] = this.avatarPostId;
    data['cover_post_id'] = this.coverPostId;
    data['avatar_org'] = this.avatarOrg;
    data['cover_org'] = this.coverOrg;
    data['cover_full'] = this.coverFull;
    data['avatar_full'] = this.avatarFull;
    data['id'] = this.id;
    data['user_platform'] = this.userPlatform;
    data['url'] = this.url;
    data['name'] = this.name;
    if (this.aPINotificationSettings != null) {
      data['API_notification_settings'] =
          this.aPINotificationSettings!.toJson();
    }
    data['is_notify_stopped'] = this.isNotifyStopped;
    data['following_data'] = this.followingData;
    data['followers_data'] = this.followersData;
    data['mutual_friends_data'] = this.mutualFriendsData;
    data['likes_data'] = this.likesData;
    data['groups_data'] = this.groupsData;
    data['album_data'] = this.albumData;
    data['lastseen_unix_time'] = this.lastseenUnixTime;
    data['lastseen_status'] = this.lastseenStatus;
    data['is_reported'] = this.isReported;
    data['is_story_muted'] = this.isStoryMuted;
    data['is_following_me'] = this.isFollowingMe;
    data['is_open_to_work'] = this.isOpenToWork;
    data['is_providing_service'] = this.isProvidingService;
    data['providing_service'] = this.providingService;
    data['open_to_work_data'] = this.openToWorkData;
    // if (this.formatedLangs != null) {
    //   data['formated_langs'] =
    //       this.formatedLangs!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Details {
  String? postCount;
  String? albumCount;
  String? followingCount;
  String? followersCount;
  String? groupsCount;
  String? likesCount;
  int? mutualFriendsCount;

  Details(
      {this.postCount,
        this.albumCount,
        this.followingCount,
        this.followersCount,
        this.groupsCount,
        this.likesCount,
        this.mutualFriendsCount});

  Details.fromJson(Map<String, dynamic> json) {
    postCount = json['post_count'];
    albumCount = json['album_count'];
    followingCount = json['following_count'];
    followersCount = json['followers_count'];
    groupsCount = json['groups_count'];
    likesCount = json['likes_count'];
    mutualFriendsCount = json['mutual_friends_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_count'] = this.postCount;
    data['album_count'] = this.albumCount;
    data['following_count'] = this.followingCount;
    data['followers_count'] = this.followersCount;
    data['groups_count'] = this.groupsCount;
    data['likes_count'] = this.likesCount;
    data['mutual_friends_count'] = this.mutualFriendsCount;
    return data;
  }
}

class APINotificationSettings {
  int? eLiked;
  int? eShared;
  int? eWondered;
  int? eCommented;
  int? eFollowed;
  int? eAccepted;
  int? eMentioned;
  int? eJoinedGroup;
  int? eLikedPage;
  int? eVisited;
  int? eProfileWallPost;
  int? eMemory;

  APINotificationSettings(
      {this.eLiked,
        this.eShared,
        this.eWondered,
        this.eCommented,
        this.eFollowed,
        this.eAccepted,
        this.eMentioned,
        this.eJoinedGroup,
        this.eLikedPage,
        this.eVisited,
        this.eProfileWallPost,
        this.eMemory});

  APINotificationSettings.fromJson(Map<String, dynamic> json) {
    eLiked = json['e_liked'];
    eShared = json['e_shared'];
    eWondered = json['e_wondered'];
    eCommented = json['e_commented'];
    eFollowed = json['e_followed'];
    eAccepted = json['e_accepted'];
    eMentioned = json['e_mentioned'];
    eJoinedGroup = json['e_joined_group'];
    eLikedPage = json['e_liked_page'];
    eVisited = json['e_visited'];
    eProfileWallPost = json['e_profile_wall_post'];
    eMemory = json['e_memory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['e_liked'] = this.eLiked;
    data['e_shared'] = this.eShared;
    data['e_wondered'] = this.eWondered;
    data['e_commented'] = this.eCommented;
    data['e_followed'] = this.eFollowed;
    data['e_accepted'] = this.eAccepted;
    data['e_mentioned'] = this.eMentioned;
    data['e_joined_group'] = this.eJoinedGroup;
    data['e_liked_page'] = this.eLikedPage;
    data['e_visited'] = this.eVisited;
    data['e_profile_wall_post'] = this.eProfileWallPost;
    data['e_memory'] = this.eMemory;
    return data;
  }
}

class UserData {
  String? userId;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  String? cover;
  String? backgroundImage;
  String? relationshipId;
  String? address;
  String? working;
  String? workingLink;
  String? about;
  String? school;
  String? gender;
  String? birthday;
  String? countryId;
  String? website;
  String? facebook;
  String? google;
  String? twitter;
  String? linkedin;
  String? youtube;
  String? vk;
  String? instagram;
  Null? qq;
  Null? wechat;
  Null? discord;
  Null? mailru;
  String? okru;
  String? language;
  String? ipAddress;
  String? followPrivacy;
  String? friendPrivacy;
  String? postPrivacy;
  String? messagePrivacy;
  String? confirmFollowers;
  String? showActivitiesPrivacy;
  String? birthPrivacy;
  String? visitPrivacy;
  String? verified;
  String? lastseen;
  String? emailNotification;
  String? eLiked;
  String? eWondered;
  String? eShared;
  String? eFollowed;
  String? eCommented;
  String? eVisited;
  String? eLikedPage;
  String? eMentioned;
  String? eJoinedGroup;
  String? eAccepted;
  String? eProfileWallPost;
  String? eSentmeMsg;
  String? eLastNotif;
  String? notificationSettings;
  String? status;
  String? active;
  String? admin;
  String? registered;
  String? phoneNumber;
  String? isPro;
  String? proType;
  String? timezone;
  String? referrer;
  String? refUserId;
  Null? refLevel;
  String? balance;
  String? paypalEmail;
  String? notificationsSound;
  String? orderPostsBy;
  String? androidMDeviceId;
  String? iosMDeviceId;
  String? androidNDeviceId;
  String? iosNDeviceId;
  String? webDeviceId;
  String? wallet;
  String? lat;
  String? lng;
  String? lastLocationUpdate;
  String? shareMyLocation;
  String? lastDataUpdate;
  Details? details;
  String? lastAvatarMod;
  String? lastCoverMod;
  String? points;
  String? dailyPoints;
  String? pointDayExpire;
  String? lastFollowId;
  String? shareMyData;
  Null? lastLoginData;
  String? twoFactor;
  String? newEmail;
  String? twoFactorVerified;
  String? newPhone;
  String? infoFile;
  String? city;
  String? state;
  String? zip;
  String? schoolCompleted;
  String? weatherUnit;
  String? paystackRef;
  String? codeSent;
  Null? stripeSessionId;
  String? timeCodeSent;
  Null? permission;
  Null? skills;
  Null? languages;
  String? currentlyWorking;
  String? banned;
  String? bannedReason;
  String? coinbaseHash;
  String? coinbaseCode;
  String? yoomoneyHash;
  String? conversationId;
  String? securionpayKey;
  String? avatarPostId;
  String? coverPostId;
  String? avatarFull;
  String? userPlatform;
  String? url;
  String? name;
  APINotificationSettings? aPINotificationSettings;
  int? isNotifyStopped;
  List<String>? mutualFriendsData;
  String? lastseenUnixTime;
  String? lastseenStatus;
  bool? isReported;
  bool? isStoryMuted;
  int? isFollowingMe;
  int? isOpenToWork;
  int? isProvidingService;
  int? providingService;
  String? openToWorkData;
  List<Null>? formatedLangs;

  UserData(
      {this.userId,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.avatar,
        this.cover,
        this.backgroundImage,
        this.relationshipId,
        this.address,
        this.working,
        this.workingLink,
        this.about,
        this.school,
        this.gender,
        this.birthday,
        this.countryId,
        this.website,
        this.facebook,
        this.google,
        this.twitter,
        this.linkedin,
        this.youtube,
        this.vk,
        this.instagram,
        this.qq,
        this.wechat,
        this.discord,
        this.mailru,
        this.okru,
        this.language,
        this.ipAddress,
        this.followPrivacy,
        this.friendPrivacy,
        this.postPrivacy,
        this.messagePrivacy,
        this.confirmFollowers,
        this.showActivitiesPrivacy,
        this.birthPrivacy,
        this.visitPrivacy,
        this.verified,
        this.lastseen,
        this.emailNotification,
        this.eLiked,
        this.eWondered,
        this.eShared,
        this.eFollowed,
        this.eCommented,
        this.eVisited,
        this.eLikedPage,
        this.eMentioned,
        this.eJoinedGroup,
        this.eAccepted,
        this.eProfileWallPost,
        this.eSentmeMsg,
        this.eLastNotif,
        this.notificationSettings,
        this.status,
        this.active,
        this.admin,
        this.registered,
        this.phoneNumber,
        this.isPro,
        this.proType,
        this.timezone,
        this.referrer,
        this.refUserId,
        this.refLevel,
        this.balance,
        this.paypalEmail,
        this.notificationsSound,
        this.orderPostsBy,
        this.androidMDeviceId,
        this.iosMDeviceId,
        this.androidNDeviceId,
        this.iosNDeviceId,
        this.webDeviceId,
        this.wallet,
        this.lat,
        this.lng,
        this.lastLocationUpdate,
        this.shareMyLocation,
        this.lastDataUpdate,
        this.details,
        this.lastAvatarMod,
        this.lastCoverMod,
        this.points,
        this.dailyPoints,
        this.pointDayExpire,
        this.lastFollowId,
        this.shareMyData,
        this.lastLoginData,
        this.twoFactor,
        this.newEmail,
        this.twoFactorVerified,
        this.newPhone,
        this.infoFile,
        this.city,
        this.state,
        this.zip,
        this.schoolCompleted,
        this.weatherUnit,
        this.paystackRef,
        this.codeSent,
        this.stripeSessionId,
        this.timeCodeSent,
        this.permission,
        this.skills,
        this.languages,
        this.currentlyWorking,
        this.banned,
        this.bannedReason,
        this.coinbaseHash,
        this.coinbaseCode,
        this.yoomoneyHash,
        this.conversationId,
        this.securionpayKey,
        this.avatarPostId,
        this.coverPostId,
        this.avatarFull,
        this.userPlatform,
        this.url,
        this.name,
        this.aPINotificationSettings,
        this.isNotifyStopped,
        this.mutualFriendsData,
        this.lastseenUnixTime,
        this.lastseenStatus,
        this.isReported,
        this.isStoryMuted,
        this.isFollowingMe,
        this.isOpenToWork,
        this.isProvidingService,
        this.providingService,
        this.openToWorkData,
        this.formatedLangs});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    cover = json['cover'];
    backgroundImage = json['background_image'];
    relationshipId = json['relationship_id'];
    address = json['address'];
    working = json['working'];
    workingLink = json['working_link'];
    about = json['about'];
    school = json['school'];
    gender = json['gender'];
    birthday = json['birthday'];
    countryId = json['country_id'];
    website = json['website'];
    facebook = json['facebook'];
    google = json['google'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
    vk = json['vk'];
    instagram = json['instagram'];
    qq = json['qq'];
    wechat = json['wechat'];
    discord = json['discord'];
    mailru = json['mailru'];
    okru = json['okru'];
    language = json['language'];
    ipAddress = json['ip_address'];
    followPrivacy = json['follow_privacy'];
    friendPrivacy = json['friend_privacy'];
    postPrivacy = json['post_privacy'];
    messagePrivacy = json['message_privacy'];
    confirmFollowers = json['confirm_followers'];
    showActivitiesPrivacy = json['show_activities_privacy'];
    birthPrivacy = json['birth_privacy'];
    visitPrivacy = json['visit_privacy'];
    verified = json['verified'];
    lastseen = json['lastseen'];
    emailNotification = json['emailNotification'];
    eLiked = json['e_liked'];
    eWondered = json['e_wondered'];
    eShared = json['e_shared'];
    eFollowed = json['e_followed'];
    eCommented = json['e_commented'];
    eVisited = json['e_visited'];
    eLikedPage = json['e_liked_page'];
    eMentioned = json['e_mentioned'];
    eJoinedGroup = json['e_joined_group'];
    eAccepted = json['e_accepted'];
    eProfileWallPost = json['e_profile_wall_post'];
    eSentmeMsg = json['e_sentme_msg'];
    eLastNotif = json['e_last_notif'];
    notificationSettings = json['notification_settings'];
    status = json['status'];
    active = json['active'];
    admin = json['admin'];
    registered = json['registered'];
    phoneNumber = json['phone_number'];
    isPro = json['is_pro'];
    proType = json['pro_type'];
    timezone = json['timezone'];
    referrer = json['referrer'];
    refUserId = json['ref_user_id'];
    refLevel = json['ref_level'];
    balance = json['balance'];
    paypalEmail = json['paypal_email'];
    notificationsSound = json['notifications_sound'];
    orderPostsBy = json['order_posts_by'];
    androidMDeviceId = json['android_m_device_id'];
    iosMDeviceId = json['ios_m_device_id'];
    androidNDeviceId = json['android_n_device_id'];
    iosNDeviceId = json['ios_n_device_id'];
    webDeviceId = json['web_device_id'];
    wallet = json['wallet'];
    lat = json['lat'];
    lng = json['lng'];
    lastLocationUpdate = json['last_location_update'];
    shareMyLocation = json['share_my_location'];
    lastDataUpdate = json['last_data_update'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    lastAvatarMod = json['last_avatar_mod'];
    lastCoverMod = json['last_cover_mod'];
    points = json['points'];
    dailyPoints = json['daily_points'];
    pointDayExpire = json['point_day_expire'];
    lastFollowId = json['last_follow_id'];
    shareMyData = json['share_my_data'];
    lastLoginData = json['last_login_data'];
    twoFactor = json['two_factor'];
    newEmail = json['new_email'];
    twoFactorVerified = json['two_factor_verified'];
    newPhone = json['new_phone'];
    infoFile = json['info_file'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    schoolCompleted = json['school_completed'];
    weatherUnit = json['weather_unit'];
    paystackRef = json['paystack_ref'];
    codeSent = json['code_sent'];
    stripeSessionId = json['StripeSessionId'];
    timeCodeSent = json['time_code_sent'];
    permission = json['permission'];
    skills = json['skills'];
    languages = json['languages'];
    currentlyWorking = json['currently_working'];
    banned = json['banned'];
    bannedReason = json['banned_reason'];
    coinbaseHash = json['coinbase_hash'];
    coinbaseCode = json['coinbase_code'];
    yoomoneyHash = json['yoomoney_hash'];
    conversationId = json['ConversationId'];
    securionpayKey = json['securionpay_key'];
    avatarPostId = json['avatar_post_id'];
    coverPostId = json['cover_post_id'];
    avatarFull = json['avatar_full'];
    userPlatform = json['user_platform'];
    url = json['url'];
    name = json['name'];
    aPINotificationSettings = json['API_notification_settings'] != null
        ? new APINotificationSettings.fromJson(
        json['API_notification_settings'])
        : null;
    isNotifyStopped = json['is_notify_stopped'];
    mutualFriendsData = json['mutual_friends_data'].cast<String>();
    lastseenUnixTime = json['lastseen_unix_time'];
    lastseenStatus = json['lastseen_status'];
    isReported = json['is_reported'];
    isStoryMuted = json['is_story_muted'];
    isFollowingMe = json['is_following_me'];
    isOpenToWork = json['is_open_to_work'];
    isProvidingService = json['is_providing_service'];
    providingService = json['providing_service'];
    openToWorkData = json['open_to_work_data'];
    // if (json['formated_langs'] != null) {
    //   formatedLangs = <Null>[];
    //   json['formated_langs'].forEach((v) {
    //     formatedLangs!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    data['cover'] = this.cover;
    data['background_image'] = this.backgroundImage;
    data['relationship_id'] = this.relationshipId;
    data['address'] = this.address;
    data['working'] = this.working;
    data['working_link'] = this.workingLink;
    data['about'] = this.about;
    data['school'] = this.school;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['country_id'] = this.countryId;
    data['website'] = this.website;
    data['facebook'] = this.facebook;
    data['google'] = this.google;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['youtube'] = this.youtube;
    data['vk'] = this.vk;
    data['instagram'] = this.instagram;
    data['qq'] = this.qq;
    data['wechat'] = this.wechat;
    data['discord'] = this.discord;
    data['mailru'] = this.mailru;
    data['okru'] = this.okru;
    data['language'] = this.language;
    data['ip_address'] = this.ipAddress;
    data['follow_privacy'] = this.followPrivacy;
    data['friend_privacy'] = this.friendPrivacy;
    data['post_privacy'] = this.postPrivacy;
    data['message_privacy'] = this.messagePrivacy;
    data['confirm_followers'] = this.confirmFollowers;
    data['show_activities_privacy'] = this.showActivitiesPrivacy;
    data['birth_privacy'] = this.birthPrivacy;
    data['visit_privacy'] = this.visitPrivacy;
    data['verified'] = this.verified;
    data['lastseen'] = this.lastseen;
    data['emailNotification'] = this.emailNotification;
    data['e_liked'] = this.eLiked;
    data['e_wondered'] = this.eWondered;
    data['e_shared'] = this.eShared;
    data['e_followed'] = this.eFollowed;
    data['e_commented'] = this.eCommented;
    data['e_visited'] = this.eVisited;
    data['e_liked_page'] = this.eLikedPage;
    data['e_mentioned'] = this.eMentioned;
    data['e_joined_group'] = this.eJoinedGroup;
    data['e_accepted'] = this.eAccepted;
    data['e_profile_wall_post'] = this.eProfileWallPost;
    data['e_sentme_msg'] = this.eSentmeMsg;
    data['e_last_notif'] = this.eLastNotif;
    data['notification_settings'] = this.notificationSettings;
    data['status'] = this.status;
    data['active'] = this.active;
    data['admin'] = this.admin;
    data['registered'] = this.registered;
    data['phone_number'] = this.phoneNumber;
    data['is_pro'] = this.isPro;
    data['pro_type'] = this.proType;
    data['timezone'] = this.timezone;
    data['referrer'] = this.referrer;
    data['ref_user_id'] = this.refUserId;
    data['ref_level'] = this.refLevel;
    data['balance'] = this.balance;
    data['paypal_email'] = this.paypalEmail;
    data['notifications_sound'] = this.notificationsSound;
    data['order_posts_by'] = this.orderPostsBy;
    data['android_m_device_id'] = this.androidMDeviceId;
    data['ios_m_device_id'] = this.iosMDeviceId;
    data['android_n_device_id'] = this.androidNDeviceId;
    data['ios_n_device_id'] = this.iosNDeviceId;
    data['web_device_id'] = this.webDeviceId;
    data['wallet'] = this.wallet;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['last_location_update'] = this.lastLocationUpdate;
    data['share_my_location'] = this.shareMyLocation;
    data['last_data_update'] = this.lastDataUpdate;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['last_avatar_mod'] = this.lastAvatarMod;
    data['last_cover_mod'] = this.lastCoverMod;
    data['points'] = this.points;
    data['daily_points'] = this.dailyPoints;
    data['point_day_expire'] = this.pointDayExpire;
    data['last_follow_id'] = this.lastFollowId;
    data['share_my_data'] = this.shareMyData;
    data['last_login_data'] = this.lastLoginData;
    data['two_factor'] = this.twoFactor;
    data['new_email'] = this.newEmail;
    data['two_factor_verified'] = this.twoFactorVerified;
    data['new_phone'] = this.newPhone;
    data['info_file'] = this.infoFile;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['school_completed'] = this.schoolCompleted;
    data['weather_unit'] = this.weatherUnit;
    data['paystack_ref'] = this.paystackRef;
    data['code_sent'] = this.codeSent;
    data['StripeSessionId'] = this.stripeSessionId;
    data['time_code_sent'] = this.timeCodeSent;
    data['permission'] = this.permission;
    data['skills'] = this.skills;
    data['languages'] = this.languages;
    data['currently_working'] = this.currentlyWorking;
    data['banned'] = this.banned;
    data['banned_reason'] = this.bannedReason;
    data['coinbase_hash'] = this.coinbaseHash;
    data['coinbase_code'] = this.coinbaseCode;
    data['yoomoney_hash'] = this.yoomoneyHash;
    data['ConversationId'] = this.conversationId;
    data['securionpay_key'] = this.securionpayKey;
    data['avatar_post_id'] = this.avatarPostId;
    data['cover_post_id'] = this.coverPostId;
    data['avatar_full'] = this.avatarFull;
    data['user_platform'] = this.userPlatform;
    data['url'] = this.url;
    data['name'] = this.name;
    if (this.aPINotificationSettings != null) {
      data['API_notification_settings'] =
          this.aPINotificationSettings!.toJson();
    }
    data['is_notify_stopped'] = this.isNotifyStopped;
    data['mutual_friends_data'] = this.mutualFriendsData;
    data['lastseen_unix_time'] = this.lastseenUnixTime;
    data['lastseen_status'] = this.lastseenStatus;
    data['is_reported'] = this.isReported;
    data['is_story_muted'] = this.isStoryMuted;
    data['is_following_me'] = this.isFollowingMe;
    data['is_open_to_work'] = this.isOpenToWork;
    data['is_providing_service'] = this.isProvidingService;
    data['providing_service'] = this.providingService;
    data['open_to_work_data'] = this.openToWorkData;
    // if (this.formatedLangs != null) {
    //   data['formated_langs'] =
    //       this.formatedLangs!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
