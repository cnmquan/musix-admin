abstract class ProfileEvent {
  const ProfileEvent();
}

class LoadProfilesEvent implements ProfileEvent {
  const LoadProfilesEvent();
}

class SetProfileAdminEvent implements ProfileEvent {
  final String username;
  final String password;
  final String? name;

  const SetProfileAdminEvent({
    required this.username,
    required this.password,
    this.name,
  });
}

class DisableProfileEvent implements ProfileEvent {
  final String id;

  const DisableProfileEvent(this.id);
}
