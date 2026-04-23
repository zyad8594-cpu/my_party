class Throw 
{
  static addThrowMeesages(oldMeesages, newMeesages)
  {
    if(oldMeesages is List)
    {
      if(newMeesages is List || newMeesages is Set)
      {
        return [...oldMeesages, ...newMeesages];
      }
      return [...oldMeesages, newMeesages];
    }
    if(oldMeesages is Set)
    {
      if(newMeesages is List || newMeesages is Set)
      {
        return {...oldMeesages, ...newMeesages};
      }
      return {...oldMeesages, newMeesages};
    }
  }

}