
enum UserType {
  teacher,
  student,
}

String userTypeToString(UserType userType){
  if(userType == UserType.student){
    return 's';
  }
  return 't';
}

UserType userTypeFromString(String string){
  if(string.toLowerCase() == 't'){
    return UserType.teacher;
  }
  return UserType.student;
}