using System.Security.Claims;
using System.Security.Cryptography;
using CuponTakeInfra.CuponGeneration.Controllers;
using CuponTakeInfra.CuponGeneration.Exceptions;
using CuponTakeInfra.CuponGeneration.Utils;
using CuponTakeInfra.Db.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<MainClusterDb>(options =>
{
    string connString = builder.Configuration
        .GetConnectionString("PostgresUsersDbConnectionString")!;
    
    if(builder.Environment.IsProduction())
    {
        string? postgresMainDbUser = EnviromentUtils.GetPostgresMainDbUser();
        string? postgresMainDbPassword = EnviromentUtils.GetPostgresMainDbPassword();
        string postgresPort = EnviromentUtils.GetPostgresPort() ?? "5432";
        
        if(postgresMainDbPassword is null)
            throw new NullEnviromentVariableException(nameof(postgresMainDbPassword), 
                builder.Environment.EnvironmentName);
        if(postgresMainDbUser is null)
            throw new NullEnviromentVariableException(nameof(postgresMainDbUser), 
                builder.Environment.EnvironmentName);
        
        connString = string.Format(connString, postgresMainDbUser, postgresMainDbPassword, postgresPort);
    }
    
    //The Migrations is to be made on the CuponTakeInfra.Auth
    options.UseNpgsql(connString);
    AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
});
builder.Services.AddScoped<ICuponHistoryController, CuponHistoryController>(provider => 
    new(provider.GetRequiredService<MainClusterDb>()));
builder.Services.AddScoped<ICuponGeneratorController, CuponGeneratorController>(provider => 
    new(provider.GetRequiredService<MainClusterDb>(),
        provider.GetRequiredService<ICuponHistoryController>()));
builder.Services.AddScoped<IPointsController, PointsController>(provider => 
    new(provider.GetRequiredService<MainClusterDb>()));

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
        
        options.TokenValidationParameters = new()
        {
            ValidateIssuerSigningKey = true,
            ValidateAudience = true,
            ValidateIssuer = true,
            IssuerSigningKey = new RsaSecurityKey(rsa),
            ValidAlgorithms = new List<string> { SecurityAlgorithms.RsaSha256 },
            ValidAudience = "CuponTakeInfra",
            ValidIssuer = "CuponTakeInfraAuthService",
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
app.MapControllers();

app.MapGet("/redeem", async (HttpContext context, 
    [FromServices] ICuponGeneratorController cuponGeneratorController) =>
{
    Claim userRequestId = context.User.Claims.First(claim => claim.Type == "ID");
    
    Guid cuponCode;
    try
    {
        cuponCode = await cuponGeneratorController
            .GenerateCupon(int.Parse(userRequestId.Value));   
    }
    catch(UserNotRegisteredException e)
    {
        return Results.NotFound(e.Message);
    }
    catch(NotEnughPointsException e)
    {
        return Results.BadRequest(e.Message);
    }

    return Results.Ok(cuponCode);
}).RequireAuthorization(policyBuilder =>
{
    policyBuilder.RequireClaim("ID");
});
app.MapPost("/points", async (HttpContext context, 
    [FromServices] IPointsController pointsController, 
    [FromQuery]int points) =>
{
    Claim userRequestId = context.User.Claims.First(claim => claim.Type == "ID");
    
    try
    {
        await pointsController.AlterPoints(int.Parse(userRequestId.Value), points);
    }
    catch(UserNotRegisteredException)
    {
        return Results.BadRequest("The user is not registered");
    }
    catch(Exception e)
    {
        return Results.BadRequest(e.Message);
    }
    
    return Results.Ok();
}).RequireAuthorization(policyBuilder =>
{
    policyBuilder.RequireClaim("ID");
});
app.MapGet("/history", async (HttpContext context, 
    [FromServices] ICuponHistoryController historyController,
    [FromQuery(Name = "limit")] int limitPerPage,
    [FromQuery] int page) =>
{
    Claim idClaim = context.User.Claims
        .First(claim => claim.Type == "ID");
   
    var cuponsHistory = await historyController
        .GetHistoryFromUserId(int.Parse(idClaim.Value), page, limitPerPage);
    
    return Results.Ok(cuponsHistory);
}).RequireAuthorization();

app.Run();