using CuponTakeInfra.Auth.Models;

namespace CuponTakeInfra.Auth.Controller;

public interface ILoginController
{
    public Task<string?> AuthenticateUser(UserLoginBody user);
}