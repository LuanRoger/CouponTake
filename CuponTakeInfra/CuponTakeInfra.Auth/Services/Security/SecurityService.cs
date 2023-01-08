using System.Text;
using Konscious.Security.Cryptography;

namespace CuponTakeInfra.Auth.Services.Security;

public static class SecurityService
{
    public static string GenerateHash(string password, RelatedInformation? relatedInformation = null)
    {
        Argon2 argon = new Argon2i(Encoding.UTF8.GetBytes(password));
        argon.DegreeOfParallelism = 2;
        argon.MemorySize = 8192;
        argon.Iterations = 20;
        if(relatedInformation is not null)
            argon.AssociatedData = Encoding.UTF8.GetBytes(relatedInformation.ToString());

        byte[] hashedPassword = argon.GetBytes(64);
        return Convert.ToBase64String(hashedPassword);
    }
    public static bool ValidateHash(string hash, string password, RelatedInformation? relatedInformation = null)
    {
        string userHash = GenerateHash(password, relatedInformation);
        
        return hash == userHash;
    }
}