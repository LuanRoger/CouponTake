namespace CuponTakeInfra.Auth.Exceptions;

public class UserNotRegisteredException : Exception
{
    private const string MESSAGE = "The user with ID {0} not exists";

    public UserNotRegisteredException(int id) : base(string.Format(MESSAGE, id)) { }
}