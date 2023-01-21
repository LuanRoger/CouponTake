using CouponTakeInfra.Auth.Models;

namespace CouponTakeInfra.Auth.Controller;

public interface ILoginController
{
    public Task<string?> AuthenticateUser(UserLoginBody user);
}