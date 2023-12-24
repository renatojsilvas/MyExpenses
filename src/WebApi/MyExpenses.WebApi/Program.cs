

internal class Program
{
    private static void Main(string[] args)
    {
        try
        {

            Console.WriteLine("teste");            
            

            var builder = WebApplication.CreateBuilder(args);
            var app = builder.Build();

            app.MapGet("/", () => "Hello World Teste!");

            app.Run();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
    }
}