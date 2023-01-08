namespace CuponTakeInfra.Auth.Exceptions;

public class SameUserNameException : Exception
{
    private const string MESSAGE = "There is a user with name {0}";

    public SameUserNameException(string username) : base(string.Format(MESSAGE, username))  { }
}