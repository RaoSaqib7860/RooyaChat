class OneToOneChatOuterModel {
  int? apiStatus;
  List<Data>? data;
  bool? videoCall;
  List<Null>? videoCallUser;
  bool? audioCall;
  List<Null>? audioCallUser;
  bool? agoraCall;
  List<Null>? agoraCallData;

  OneToOneChatOuterModel(
      {this.apiStatus,
        this.data,
        this.videoCall,
        this.videoCallUser,
        this.audioCall,
        this.audioCallUser,
        this.agoraCall,
        this.agoraCallData});

  OneToOneChatOuterModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    // videoCall = json['video_call'];
    // if (json['video_call_user'] != null) {
    //   videoCallUser = <Null>[];
    //   json['video_call_user'].forEach((v) {
    //     videoCallUser!.add(new Null.fromJson(v));
    //   });
    // }
    // audioCall = json['audio_call'];
    // if (json['audio_call_user'] != null) {
    //   audioCallUser = <Null>[];
    //   json['audio_call_user'].forEach((v) {
    //     audioCallUser!.add(new Null.fromJson(v));
    //   });
    // }
    // agoraCall = json['agora_call'];
    // if (json['agora_call_data'] != null) {
    //   agoraCallData = <Null>[];
    //   json['agora_call_data'].forEach((v) {
    //     agoraCallData!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    // data['video_call'] = this.videoCall;
    // if (this.videoCallUser != null) {
    //   data['video_call_user'] =
    //       this.videoCallUser!.map((v) => v.toJson()).toList();
    // }
    // data['audio_call'] = this.audioCall;
    // if (this.audioCallUser != null) {
    //   data['audio_call_user'] =
    //       this.audioCallUser!.map((v) => v.toJson()).toList();
    // }
    // data['agora_call'] = this.agoraCall;
    // if (this.agoraCallData != null) {
    //   data['agora_call_data'] =
    //       this.agoraCallData!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Data {
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
  String? qq;
  String? wechat;
  String? discord;
  String? mailru;
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
  String? refLevel;
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
  String? lastLoginData;
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
  String? stripeSessionId;
  String? timeCodeSent;
  String? permission;
  String? skills;
  String? languages;
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
  String? isNotifyStopped;
  List<String>? followingData=<String>[];
  List<String>? followersData=<String>[];
  List<String>? mutualFriendsData=<String>[];
  String? likesData;
  String? groupsData;
  String? albumData;
  String? lastseenUnixTime;
  String? lastseenStatus;
  bool? isReported;
  bool? isStoryMuted;
  String? isFollowingMe;
  String? isOpenToWork;
  String? isProvidingService;
  String? providingService;
  String? openToWorkData;
  List<Null>? formatedLangs;
  String? chatTime;
  String? chatId;
  String? chatType;
  Mute? mute;
  LastMessage? lastMessage;
  String? messageCount;

  Data(
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
        this.formatedLangs,
        this.chatTime,
        this.chatId,
        this.chatType,
        this.mute,
        this.lastMessage,
        this.messageCount});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'].toString();
    username = json['username'].toString();
    email = json['email'].toString();
    password = json['password'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    avatar = json['avatar'].toString();
    cover = json['cover'].toString();
    backgroundImage = json['background_image'].toString();
    backgroundImageStatus = json['background_image_status'].toString();
    relationshipId = json['relationship_id'].toString();
    address = json['address'].toString();
    working = json['working'].toString();
    workingLink = json['working_link'].toString();
    about = json['about'].toString();
    school = json['school'].toString();
    gender = json['gender'].toString();
    birthday = json['birthday'].toString();
    countryId = json['country_id'].toString();
    website = json['website'].toString();
    facebook = json['facebook'].toString();
    google = json['google'].toString();
    twitter = json['twitter'].toString();
    linkedin = json['linkedin'].toString();
    youtube = json['youtube'].toString();
    vk = json['vk'].toString();
    instagram = json['instagram'].toString();
    qq = json['qq'].toString();
    wechat = json['wechat'].toString();
    discord = json['discord'].toString();
    mailru = json['mailru'].toString();
    okru = json['okru'].toString();
    language = json['language'].toString();
    emailCode = json['email_code'].toString();
    src = json['src'].toString();
    ipAddress = json['ip_address'].toString();
    followPrivacy = json['follow_privacy'].toString();
    friendPrivacy = json['friend_privacy'].toString();
    postPrivacy = json['post_privacy'].toString();
    messagePrivacy = json['message_privacy'].toString();
    confirmFollowers = json['confirm_followers'].toString();
    showActivitiesPrivacy = json['show_activities_privacy'].toString();
    birthPrivacy = json['birth_privacy'].toString();
    visitPrivacy = json['visit_privacy'].toString();
    verified = json['verified'].toString();
    lastseen = json['lastseen'].toString();
    showlastseen = json['showlastseen'].toString();
    emailNotification = json['emailNotification'].toString();
    eLiked = json['e_liked'].toString();
    eWondered = json['e_wondered'].toString();
    eShared = json['e_shared'].toString();
    eFollowed = json['e_followed'].toString();
    eCommented = json['e_commented'].toString();
    eVisited = json['e_visited'].toString();
    eLikedPage = json['e_liked_page'].toString();
    eMentioned = json['e_mentioned'].toString();
    eJoinedGroup = json['e_joined_group'].toString();
    eAccepted = json['e_accepted'].toString();
    eProfileWallPost = json['e_profile_wall_post'].toString();
    eSentmeMsg = json['e_sentme_msg'].toString();
    eLastNotif = json['e_last_notif'].toString();
    notificationSettings = json['notification_settings'].toString();
    status = json['status'].toString();
    active = json['active'].toString();
    admin = json['admin'].toString();
    type = json['type'].toString();
    registered = json['registered'].toString();
    startUp = json['start_up'].toString();
    startUpInfo = json['start_up_info'].toString();
    startupFollow = json['startup_follow'].toString();
    startupImage = json['startup_image'].toString();
    lastEmailSent = json['last_email_sent'].toString();
    phoneNumber = json['phone_number'].toString();
    smsCode = json['sms_code'].toString();
    isPro = json['is_pro'].toString();
    proTime = json['pro_time'].toString();
    proType = json['pro_type'].toString();
    joined = json['joined'].toString();
    cssFile = json['css_file'].toString();
    timezone = json['timezone'].toString();
    referrer = json['referrer'].toString();
    refUserId = json['ref_user_id'].toString();
    refLevel = json['ref_level'].toString();
    balance = json['balance'].toString();
    paypalEmail = json['paypal_email'].toString();
    notificationsSound = json['notifications_sound'].toString();
    orderPostsBy = json['order_posts_by'].toString();
    socialLogin = json['social_login'].toString();
    androidMDeviceId = json['android_m_device_id'].toString();
    iosMDeviceId = json['ios_m_device_id'].toString();
    androidNDeviceId = json['android_n_device_id'].toString();
    iosNDeviceId = json['ios_n_device_id'].toString();
    webDeviceId = json['web_device_id'].toString();
    wallet = json['wallet'].toString();
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    lastLocationUpdate = json['last_location_update'].toString();
    shareMyLocation = json['share_my_location'].toString();
    lastDataUpdate = json['last_data_update'].toString();
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    sidebarData = json['sidebar_data'].toString();
    lastAvatarMod = json['last_avatar_mod'].toString();
    lastCoverMod = json['last_cover_mod'].toString();
    points = json['points'].toString();
    dailyPoints = json['daily_points'].toString();
    pointDayExpire = json['point_day_expire'].toString();
    lastFollowId = json['last_follow_id'].toString();
    shareMyData = json['share_my_data'].toString();
    lastLoginData = json['last_login_data'].toString();
    twoFactor = json['two_factor'].toString();
    newEmail = json['new_email'].toString();
    twoFactorVerified = json['two_factor_verified'].toString();
    newPhone = json['new_phone'].toString();
    infoFile = json['info_file'].toString();
    city = json['city'].toString();
    state = json['state'].toString();
    zip = json['zip'].toString();
    schoolCompleted = json['school_completed'].toString();
    weatherUnit = json['weather_unit'].toString();
    paystackRef = json['paystack_ref'].toString();
    codeSent = json['code_sent'].toString();
    stripeSessionId = json['StripeSessionId'].toString();
    timeCodeSent = json['time_code_sent'].toString();
    permission = json['permission'].toString();
    skills = json['skills'].toString();
    languages = json['languages'].toString();
    currentlyWorking = json['currently_working'].toString();
    banned = json['banned'].toString();
    bannedReason = json['banned_reason'].toString();
    coinbaseHash = json['coinbase_hash'].toString();
    coinbaseCode = json['coinbase_code'].toString();
    yoomoneyHash = json['yoomoney_hash'].toString();
    conversationId = json['ConversationId'].toString();
    securionpayKey = json['securionpay_key'].toString();
    avatarPostId = json['avatar_post_id'].toString();
    coverPostId = json['cover_post_id'].toString();
    avatarOrg = json['avatar_org'].toString();
    coverOrg = json['cover_org'].toString();
    coverFull = json['cover_full'].toString();
    avatarFull = json['avatar_full'].toString();
    id = json['id'].toString();
    userPlatform = json['user_platform'].toString();
    url = json['url'].toString();
    name = json['name'].toString();
    aPINotificationSettings = json['API_notification_settings'] != null
        ? new APINotificationSettings.fromJson(
        json['API_notification_settings'])
        : null;
    isNotifyStopped = json['is_notify_stopped'].toString();
    // followingData = json['following_data'].cast<String>();
    // followersData = json['followers_data'].cast<String>();
    // mutualFriendsData = json['mutual_friends_data'].cast<String>();
    likesData = json['likes_data'].toString();
    groupsData = json['groups_data'].toString();
    albumData = json['album_data'].toString();
    lastseenUnixTime = json['lastseen_unix_time'].toString();
    lastseenStatus = json['lastseen_status'].toString();
    isReported = json['is_reported'];
    isStoryMuted = json['is_story_muted'];
    isFollowingMe = json['is_following_me'].toString();
    isOpenToWork = json['is_open_to_work'].toString();
    isProvidingService = json['is_providing_service'].toString();
    providingService = json['providing_service'].toString();
    openToWorkData = json['open_to_work_data'].toString();
    // if (json['formated_langs'] != null) {
    //   formatedLangs = <Null>[];
    //   json['formated_langs'].forEach((v) {
    //     formatedLangs!.add(new Null.fromJson(v));
    //   });
    // }
    chatTime = json['chat_time'].toString();
    chatId = json['chat_id'].toString();
    chatType = json['chat_type'].toString();
    mute = json['mute'] != null ? new Mute.fromJson(json['mute']) : null;
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
    messageCount = json['message_count'].toString();
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
    data['chat_time'] = this.chatTime;
    data['chat_id'] = this.chatId;
    data['chat_type'] = this.chatType;
    if (this.mute != null) {
      data['mute'] = this.mute!.toJson();
    }
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    data['message_count'] = this.messageCount;
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
  String? mutualFriendsCount;

  Details(
      {this.postCount,
        this.albumCount,
        this.followingCount,
        this.followersCount,
        this.groupsCount,
        this.likesCount,
        this.mutualFriendsCount});

  Details.fromJson(Map<String, dynamic> json) {
    postCount = json['post_count'].toString();
    albumCount = json['album_count'].toString();
    followingCount = json['following_count'].toString();
    followersCount = json['followers_count'].toString();
    groupsCount = json['groups_count'].toString();
    likesCount = json['likes_count'].toString();
    mutualFriendsCount = json['mutual_friends_count'].toString();
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
  String? eLiked;
  String? eShared;
  String? eWondered;
  String? eCommented;
  String? eFollowed;
  String? eAccepted;
  String? eMentioned;
  String? eJoinedGroup;
  String? eLikedPage;
  String? eVisited;
  String? eProfileWallPost;
  String? eMemory;

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
    eLiked = json['e_liked'].toString();
    eShared = json['e_shared'].toString();
    eWondered = json['e_wondered'].toString();
    eCommented = json['e_commented'].toString();
    eFollowed = json['e_followed'].toString();
    eAccepted = json['e_accepted'].toString();
    eMentioned = json['e_mentioned'].toString();
    eJoinedGroup = json['e_joined_group'].toString();
    eLikedPage = json['e_liked_page'].toString();
    eVisited = json['e_visited'].toString();
    eProfileWallPost = json['e_profile_wall_post'].toString();
    eMemory = json['e_memory'].toString();
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

class Mute {
  String? notify;
  String? callChat;
  String? archive;
  String? fav;
  String? pin;

  Mute({this.notify, this.callChat, this.archive, this.fav, this.pin});

  Mute.fromJson(Map<String, dynamic> json) {
    notify = json['notify'].toString();
    callChat = json['call_chat'].toString();
    archive = json['archive'].toString();
    fav = json['fav'].toString();
    pin = json['pin'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notify'] = this.notify;
    data['call_chat'] = this.callChat;
    data['archive'] = this.archive;
    data['fav'] = this.fav;
    data['pin'] = this.pin;
    return data;
  }
}

class LastMessage {
  String? id;
  String? fromId;
  String? groupId;
  String? pageId;
  String? toId;
  String? text;
  String? media;
  String? mediaFileName;
  String? mediaFileNames;
  String? time;
  String? seen;
  String? deletedOne;
  String? deletedTwo;
  String? sentPush;
  String? notificationId;
  String? typeTwo;
  String? stickers;
  String? productId;
  String? lat;
  String? lng;
  String? replyId;
  String? storyId;
  String? broadcastId;
  String? forward;
  String? listening;
  String? delivered;
  MessageUser? messageUser;
  String? onwer;
  Reaction? reaction;
  String? timeText;
  String? position;
  String? type;
  String? product;
  String? fileSize;
  String? chatColor;

  LastMessage(
      {this.id,
        this.fromId,
        this.groupId,
        this.pageId,
        this.toId,
        this.text,
        this.media,
        this.mediaFileName,
        this.mediaFileNames,
        this.time,
        this.seen,
        this.deletedOne,
        this.deletedTwo,
        this.sentPush,
        this.notificationId,
        this.typeTwo,
        this.stickers,
        this.productId,
        this.lat,
        this.lng,
        this.replyId,
        this.storyId,
        this.broadcastId,
        this.forward,
        this.listening,
        this.delivered,
        this.messageUser,
        this.onwer,
        this.reaction,
        this.timeText,
        this.position,
        this.type,
        this.product,
        this.fileSize,
        this.chatColor});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fromId = json['from_id'].toString();
    groupId = json['group_id'].toString();
    pageId = json['page_id'].toString();
    toId = json['to_id'].toString();
    text = json['text'].toString();
    media = json['media'].toString();
    mediaFileName = json['mediaFileName'].toString();
    mediaFileNames = json['mediaFileNames'].toString();
    time = json['time'].toString();
    seen = json['seen'].toString();
    deletedOne = json['deleted_one'].toString();
    deletedTwo = json['deleted_two'].toString();
    sentPush = json['sent_push'].toString();
    notificationId = json['notification_id'].toString();
    typeTwo = json['type_two'].toString();
    stickers = json['stickers'].toString();
    productId = json['product_id'].toString();
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    replyId = json['reply_id'].toString();
    storyId = json['story_id'].toString();
    broadcastId = json['broadcast_id'].toString();
    forward = json['forward'].toString();
    listening = json['listening'].toString();
    delivered = json['delivered'].toString();
    messageUser = json['messageUser'] != null
        ? new MessageUser.fromJson(json['messageUser'])
        : null;
    onwer = json['onwer'].toString();
    reaction = json['reaction'] != null
        ? new Reaction.fromJson(json['reaction'])
        : null;
    timeText = json['time_text'].toString();
    position = json['position'].toString();
    type = json['type'].toString();
    product = json['product'].toString();
    fileSize = json['file_size'].toString();
    chatColor = json['chat_color'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_id'] = this.fromId;
    data['group_id'] = this.groupId;
    data['page_id'] = this.pageId;
    data['to_id'] = this.toId;
    data['text'] = this.text;
    data['media'] = this.media;
    data['mediaFileName'] = this.mediaFileName;
    data['mediaFileNames'] = this.mediaFileNames;
    data['time'] = this.time;
    data['seen'] = this.seen;
    data['deleted_one'] = this.deletedOne;
    data['deleted_two'] = this.deletedTwo;
    data['sent_push'] = this.sentPush;
    data['notification_id'] = this.notificationId;
    data['type_two'] = this.typeTwo;
    data['stickers'] = this.stickers;
    data['product_id'] = this.productId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['reply_id'] = this.replyId;
    data['story_id'] = this.storyId;
    data['broadcast_id'] = this.broadcastId;
    data['forward'] = this.forward;
    data['listening'] = this.listening;
    data['delivered'] = this.delivered;
    if (this.messageUser != null) {
      data['messageUser'] = this.messageUser!.toJson();
    }
    data['onwer'] = this.onwer;
    if (this.reaction != null) {
      data['reaction'] = this.reaction!.toJson();
    }
    data['time_text'] = this.timeText;
    data['position'] = this.position;
    data['type'] = this.type;
    data['product'] = this.product;
    data['file_size'] = this.fileSize;
    data['chat_color'] = this.chatColor;
    return data;
  }
}

class MessageUser {
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
  String? qq;
  String? wechat;
  String? discord;
  String? mailru;
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
  String? refLevel;
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
  String? lastLoginData;
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
  String? stripeSessionId;
  String? timeCodeSent;
  String? permission;
  String? skills;
  String? languages;
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
  String? isNotifyStopped;
  List<String>? mutualFriendsData=<String>[];
  String? lastseenUnixTime;
  String? lastseenStatus;
  bool? isReported;
  bool? isStoryMuted;
  String? isFollowingMe;
  String? isOpenToWork;
  String? isProvidingService;
  String? providingService;
  String? openToWorkData;
  List<Null>? formatedLangs;

  MessageUser(
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

  MessageUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'].toString();
    username = json['username'].toString();
    email = json['email'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    avatar = json['avatar'].toString();
    cover = json['cover'].toString();
    backgroundImage = json['background_image'].toString();
    relationshipId = json['relationship_id'].toString();
    address = json['address'].toString();
    working = json['working'].toString();
    workingLink = json['working_link'].toString();
    about = json['about'].toString();
    school = json['school'].toString();
    gender = json['gender'].toString();
    birthday = json['birthday'].toString();
    countryId = json['country_id'].toString();
    website = json['website'].toString();
    facebook = json['facebook'].toString();
    google = json['google'].toString();
    twitter = json['twitter'].toString();
    linkedin = json['linkedin'].toString();
    youtube = json['youtube'].toString();
    vk = json['vk'].toString();
    instagram = json['instagram'].toString();
    qq = json['qq'].toString();
    wechat = json['wechat'].toString();
    discord = json['discord'].toString();
    mailru = json['mailru'].toString();
    okru = json['okru'].toString();
    language = json['language'].toString();
    ipAddress = json['ip_address'].toString();
    followPrivacy = json['follow_privacy'].toString();
    friendPrivacy = json['friend_privacy'].toString();
    postPrivacy = json['post_privacy'].toString();
    messagePrivacy = json['message_privacy'].toString();
    confirmFollowers = json['confirm_followers'].toString();
    showActivitiesPrivacy = json['show_activities_privacy'].toString();
    birthPrivacy = json['birth_privacy'].toString();
    visitPrivacy = json['visit_privacy'].toString();
    verified = json['verified'].toString();
    lastseen = json['lastseen'].toString();
    emailNotification = json['emailNotification'].toString();
    eLiked = json['e_liked'].toString();
    eWondered = json['e_wondered'].toString();
    eShared = json['e_shared'].toString();
    eFollowed = json['e_followed'].toString();
    eCommented = json['e_commented'].toString();
    eVisited = json['e_visited'].toString();
    eLikedPage = json['e_liked_page'].toString();
    eMentioned = json['e_mentioned'].toString();
    eJoinedGroup = json['e_joined_group'].toString();
    eAccepted = json['e_accepted'].toString();
    eProfileWallPost = json['e_profile_wall_post'].toString();
    eSentmeMsg = json['e_sentme_msg'].toString();
    eLastNotif = json['e_last_notif'].toString();
    notificationSettings = json['notification_settings'].toString();
    status = json['status'].toString();
    active = json['active'].toString();
    admin = json['admin'].toString();
    registered = json['registered'].toString();
    phoneNumber = json['phone_number'].toString();
    isPro = json['is_pro'].toString();
    proType = json['pro_type'].toString();
    timezone = json['timezone'].toString();
    referrer = json['referrer'].toString();
    refUserId = json['ref_user_id'].toString();
    refLevel = json['ref_level'].toString();
    balance = json['balance'].toString();
    paypalEmail = json['paypal_email'].toString();
    notificationsSound = json['notifications_sound'].toString();
    orderPostsBy = json['order_posts_by'].toString();
    androidMDeviceId = json['android_m_device_id'].toString();
    iosMDeviceId = json['ios_m_device_id'].toString();
    androidNDeviceId = json['android_n_device_id'].toString();
    iosNDeviceId = json['ios_n_device_id'].toString();
    webDeviceId = json['web_device_id'].toString();
    wallet = json['wallet'].toString();
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    lastLocationUpdate = json['last_location_update'].toString();
    shareMyLocation = json['share_my_location'].toString();
    lastDataUpdate = json['last_data_update'].toString();
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    lastAvatarMod = json['last_avatar_mod'].toString();
    lastCoverMod = json['last_cover_mod'].toString();
    points = json['points'].toString();
    dailyPoints = json['daily_points'].toString();
    pointDayExpire = json['point_day_expire'].toString();
    lastFollowId = json['last_follow_id'].toString();
    shareMyData = json['share_my_data'].toString();
    lastLoginData = json['last_login_data'].toString();
    twoFactor = json['two_factor'].toString();
    newEmail = json['new_email'].toString();
    twoFactorVerified = json['two_factor_verified'].toString();
    newPhone = json['new_phone'].toString();
    infoFile = json['info_file'].toString();
    city = json['city'].toString();
    state = json['state'].toString();
    zip = json['zip'].toString();
    schoolCompleted = json['school_completed'].toString();
    weatherUnit = json['weather_unit'].toString();
    paystackRef = json['paystack_ref'].toString();
    codeSent = json['code_sent'].toString();
    stripeSessionId = json['StripeSessionId'].toString();
    timeCodeSent = json['time_code_sent'].toString();
    permission = json['permission'].toString();
    skills = json['skills'].toString();
    languages = json['languages'].toString();
    currentlyWorking = json['currently_working'].toString();
    banned = json['banned'].toString();
    bannedReason = json['banned_reason'].toString();
    coinbaseHash = json['coinbase_hash'].toString();
    coinbaseCode = json['coinbase_code'].toString();
    yoomoneyHash = json['yoomoney_hash'].toString();
    conversationId = json['ConversationId'].toString();
    securionpayKey = json['securionpay_key'].toString();
    avatarPostId = json['avatar_post_id'].toString();
    coverPostId = json['cover_post_id'].toString();
    avatarFull = json['avatar_full'].toString();
    userPlatform = json['user_platform'].toString();
    url = json['url'].toString();
    name = json['name'].toString();
    aPINotificationSettings = json['API_notification_settings'] != null
        ? new APINotificationSettings.fromJson(
        json['API_notification_settings'])
        : null;
    isNotifyStopped = json['is_notify_stopped'].toString();
    //mutualFriendsData = json['mutual_friends_data'].cast<String>();
    lastseenUnixTime = json['lastseen_unix_time'].toString();
    lastseenStatus = json['lastseen_status'].toString();
    isReported = json['is_reported'];
    isStoryMuted = json['is_story_muted'];
    isFollowingMe = json['is_following_me'].toString();
    isOpenToWork = json['is_open_to_work'].toString();
    isProvidingService = json['is_providing_service'].toString();
    providingService = json['providing_service'].toString();
    openToWorkData = json['open_to_work_data'].toString();
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

class Reaction {
  bool? isReacted;
  String? type;
  String? count;

  Reaction({this.isReacted, this.type, this.count});

  Reaction.fromJson(Map<String, dynamic> json) {
    isReacted = json['is_reacted'];
    type = json['type'].toString();
    count = json['count'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_reacted'] = this.isReacted;
    data['type'] = this.type;
    data['count'] = this.count;
    return data;
  }
}
