namespace CuponTakeInfra.Auth.Exceptions;

public class NullEnvironmentVariableException : Exception
{
    private const string MESSAGE = "The variable {0} don't exist in the environment {1}";

    public NullEnvironmentVariableException(string variableName, string environmentName) :
        base(string.Format(MESSAGE, variableName, environmentName)) { }
}