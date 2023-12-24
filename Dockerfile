# Use the official .NET Core SDK as a parent image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the project file and restore any dependencies (use .csproj for the project name)
COPY *.sln .
COPY ./src/Domain/MyExpenses.Domain/MyExpenses.Domain.csproj ./src/Domain/MyExpenses.Domain/
COPY ./src/WebApi/MyExpenses.WebApi/MyExpenses.WebApi.csproj ./src/WebApi/MyExpenses.WebApi/
COPY ./src/Application/MyExpenses.Application/MyExpenses.Application.csproj ./src/Application/MyExpenses.Application/
COPY ./src/Infrastructure/MyExpenses.Infrastructure/MyExpenses.Infrastructure.csproj ./src/Infrastructure/MyExpenses.Infrastructure/
COPY ./test/MyExpenses.Tests/MyExpenses.Tests.csproj ./test/MyExpenses.Tests/
RUN dotnet restore

# Copy the rest of the application code
COPY . ./

# Run tests
RUN dotnet test

# Publish the application
WORKDIR /app/src/WebApi/MyExpenses.WebApi
RUN dotnet publish -c Release -o publish

# Build the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/src/WebApi/MyExpenses.WebApi/publish ./

EXPOSE 8080

# Start the application
ENTRYPOINT ["dotnet", "MyExpenses.WebApi.dll"]