namespace CuponTakeInfra.CuponGeneration.Exceptions;

public class NullEnviromentVariableException : Exception
{
    private const string MESSAGE = "The variable {0} don't exist in the enviroment {1}";

    public NullEnviromentVariableException(string variableName, string enviromentName) :
        base(string.Format(MESSAGE, variableName, enviromentName)) { }
}