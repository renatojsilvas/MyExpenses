var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

Guid? Id = null;

if (Id is null)
{
    Id = Guid.NewGuid();
}

app.MapGet("/", () => $"Teste {Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT")} {Id}");

app.Run();