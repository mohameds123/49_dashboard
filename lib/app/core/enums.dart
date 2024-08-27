
enum AppThemeType { system, light, dark }

enum StorageKeys {
  accessToken,
  isFirstRun,
  appMetaData,
  clintVersion,
  appTheme,
  lastAppliedUpdate,
  lastSuccessFetchRoomsTime,
  profile,
  startedBefore,
  countryCode,
}

enum PeerActionType { unFriend, addFriend, cancelFriendRequest }
enum ChatContactTypes { user, group }

enum ChatAttachmentTypes {
  picture,
  video,
  record,
  location,
  file,
}

// ! DON'T EDIT THE SORTING
enum PrivacyStatus {
  onlyMe,
  public,
  friends,
  followers,
  friendsAndFollowers,
}

enum SocialStatus {
  single,
  married,
  divorced,
  inARelationship,
  idLikeToNoTell,
}

enum DynamicAdInputType {
  title,
  description,
  pictures,
  textField,
  dropDown,
  datePicker,
  dayPicker,
  videoPicker,
  pdfPicker,
  checkBox,
}

enum ReportTypes {
  profile,
  post,
  storyOrReel,
  dynamicAd,
  restaurant,
  doctor,
  tinder,
  rideRequest,
  comeWithMeTrip,
  pickMeTrip,
  message,
}
enum ReactionType { like, love, wow, sad, angry }

enum AppRadioTypes {
  voice,
  video,
  text,
  banner,
}

const RunningCostType = [
  'All',
  'Developers',
  'Admins',
  'Marketing',
  'Cashback Payment',
  'Customer Services',
  'Social Media',
  'Ads Media',
  'Events',
  'Lawyers',
  'Permissions',
  'Under Tabled',
  'Taxes',
  'Accounts',
  'VO',
  'Other',
];
enum AppRadioCategories {
  top_Ads,
  top_Show,
  forty_Nine_Ads,
}