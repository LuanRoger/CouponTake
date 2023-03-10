using System.Security.Claims;
using System.Security.Cryptography;
using CouponTakeInfra.Auth.Controller;
using CouponTakeInfra.Auth.Exceptions;
using CouponTakeInfra.Auth.Models;
using CouponTakeInfra.Auth.Services.Jwt;
using CouponTakeInfra.Auth.Utils;
using CouponTakeInfra.Db.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<MainClusterDb>(optionsBuilder =>
{
    string connString = builder.Configuration
        .GetConnectionString("PostgresUsersDbConnectionString")!;
    
    if(builder.Environment.IsProduction())
    {
        string? postgresMainDbUser = EnvironmentUtils.GetPostgresMainDbUser();
        string? postgresMainDbPassword = EnvironmentUtils.GetPostgresMainDbPassword();
        string postgresPort = EnvironmentUtils.GetPostgresPort() ?? "5432";
        
        if(postgresMainDbPassword is null)
            throw new NullEnvironmentVariableException(nameof(postgresMainDbPassword), 
                builder.Environment.EnvironmentName);
        if(postgresMainDbUser is null)
            throw new NullEnvironmentVariableException(nameof(postgresMainDbUser), 
                builder.Environment.EnvironmentName);
        
        connString = string.Format(connString, postgresMainDbUser, postgresMainDbPassword, postgresPort);
    }
    
    optionsBuilder.UseNpgsql(connString,
        contextOptionsBuilder =>
        {
            contextOptionsBuilder.MigrationsAssembly("CouponTakeInfra.Auth");
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
            ValidAudience = "CouponTakeInfra",
            ValidIssuer = "CouponTakeInfraAuthService"
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
app.MapPost("/login", async ([FromBody] UserLoginBody user, 
    [FromServices] ILoginController loginController) =>
{
    string? jwtResult = await loginController.AuthenticateUser(user);
    return jwtResult is null ? 
        Results.NotFound() : 
        Results.Ok(jwtResult);
});

app.Run();