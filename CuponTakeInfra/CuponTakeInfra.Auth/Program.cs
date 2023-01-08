using System.Security.Claims;
using System.Security.Cryptography;
using CuponTakeInfra.Auth.Controller;
using CuponTakeInfra.Auth.Exceptions;
using CuponTakeInfra.Auth.Models;
using CuponTakeInfra.Auth.Services.Jwt;
using CuponTakeInfra.Db.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<MainClusterDb>(optionsBuilder =>
{
    optionsBuilder.UseNpgsql(builder.Configuration
        .GetConnectionString("PostgresUsersDbConnectionString")!, 
        contextOptionsBuilder =>
        {
            contextOptionsBuilder.MigrationsAssembly("CuponTakeInfra.Auth");
        });
});

builder.Services.AddSingleton<JwtServices>(_ =>
{
    string publicCertificatePath = builder.Configuration
        .GetSection("Jwt")
        .GetValue<string>("PrivateCertificatePath")!;
    
    string publicCertificateContent = File.ReadAllText(publicCertificatePath);
    
    return new(new(publicCertificateContent));
});
builder.Services.AddScoped<IUsersController, UserController>(provider => 
    new(provider.GetRequiredService<MainClusterDb>(), 
        provider.GetRequiredService<JwtServices>()));
builder.Services.AddScoped<ILoginController, LoginController>(provider => 
    new(provider.GetRequiredService<MainClusterDb>(), 
        provider.GetRequiredService<JwtServices>()));

builder.Services.AddAuthentication(options =>
    {
        options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(options =>
    {
        string privateCertificatePath = builder.Configuration
            .GetSection("Jwt")
            .GetValue<string>("PublicCertificatePath")!;
        string certificateContent = File.ReadAllText(privateCertificatePath);
        RSA rsa = RSA.Create();
        rsa.ImportFromPem(certificateContent);
        
        options.SaveToken = true;
        options.TokenValidationParameters = new()
        {
            ValidateIssuerSigningKey = true,
            ValidateAudience = true,
            ValidateIssuer = true,
            ValidateLifetime = true,
            IssuerSigningKey = new RsaSecurityKey(rsa),
            ValidAlgorithms = new List<string> { SecurityAlgorithms.RsaSha256 },
            ValidAudience = "CuponTakeInfra",
            ValidIssuer = "CuponTakeInfraAuthService"
        };
    });

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

using (IServiceScope scope = app.Services.CreateScope())
{
    MainClusterDb db = scope.ServiceProvider
        .GetRequiredService<MainClusterDb>();

    db.Database.SetCommandTimeout(5);
    db.Database.EnsureCreated();
}

app.UseAuthentication();
app.UseAuthorization();

app.MapGet("/user", async (HttpContext context, [FromServices] IUsersController usersController) =>
{
    Claim idClaim = context.User.Claims.First(claim => claim.Type == "ID");

    UserReadResponse? response = await usersController
        .GetUserInfo(int.Parse(idClaim.Value));
    
    return response is not null ?
        Results.Ok(response) : 
        Results.NotFound();
}).RequireAuthorization();

app.MapPost("/register", async ([FromBody] UserRegisterBody user, [FromServices] IUsersController usersController) =>
{
    string token;
    try { token = await usersController.RegisterUser(user);  }
    catch(SameUserNameException e)
    {
        return Results.Conflict(e.Message);
    }
    
    return Results.Ok(token);
});
app.MapGet("/login", async ([FromBody] UserLoginBody user, 
    [FromServices] ILoginController loginController) =>
{
    string? jwtResult = await loginController.AuthenticateUser(user);
    return jwtResult is null ? 
        Results.NotFound() : 
        Results.Ok(jwtResult);
});

app.Run();