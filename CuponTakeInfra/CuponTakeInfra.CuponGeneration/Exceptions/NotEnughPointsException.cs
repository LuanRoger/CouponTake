namespace CuponTakeInfra.CuponGeneration.Exceptions;

public class NotEnughPointsException : Exception
{
    private const string MESSAGE = "The user does't has enugh points to request a cupon.";

    public NotEnughPointsException() : base(MESSAGE) { }
}