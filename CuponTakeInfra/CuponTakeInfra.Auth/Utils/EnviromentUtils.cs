namespace CuponTakeInfra.Auth.Utils;

public class EnviromentUtils
{
    public static string? GetPostgresMainDbPassword() => 
        Environment.GetEnvironmentVariable(EnvVariableConsts.POSTGRES_MAIN_DB_PASSWORD);
    public static string? GetPostgresMainDbUser() => 
        Environment.GetEnvironmentVariable(EnvVariableConsts.POSTGRES_MAIN_DB_USER);
    
    public static string? GetPostgresPort() =>
        Environment.GetEnvironmentVariable(EnvVariableConsts.POSTGRES_PORT);
}

file class EnvVariableConsts
{
    public const string POSTGRES_MAIN_DB_PASSWORD = "POSTGRES_MAIN_DB_PASSWORD";
    public const string POSTGRES_MAIN_DB_USER = "POSTGRES_MAIN_DB_USER";
    public const string POSTGRES_PORT = "POSTGRES_PORT";
}