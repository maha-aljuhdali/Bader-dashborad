enum NotificationType {
  askForAMembershipOnSpecificClub, // طلب عضوية
  adminMakesYouALeaderOnSpecificClub, // الأدمن عينك ليدر على نادي معين
  acceptYourMembershipRequest,
  acceptYourRequestToAuthenticateOnATask,
  rejectYourRequestToAuthenticateOnATask,
  rejectYourMembershipRequest,
  acceptPlanForClubYouLead,
  rejectPlanForClubYouLead,
  deleteClubForEver
}

enum EventForPublicOrNot { private, public }
