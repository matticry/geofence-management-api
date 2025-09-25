using ApiNetCore.ContextMysql;
using ApiNetCore.Controllers.Middleware;
using DotNetEnv;
using ApiNetCore.Mappings;
using ApiNetCore.Services;
using ApiNetCore.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

// Cargar variables de entorno
Env.Load();

var builder = WebApplication.CreateBuilder(args);

// Configuración...
builder.Configuration.AddEnvironmentVariables();
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

// Configuración de Swagger mejorada
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "API de Geolocalización",
        Version = "v1",
        Description = "API para integración con el sistema de vendedores y geolocalización",
        Contact = new OpenApiContact
        {
            Name = "Soporte",
            Email = "matticry1@gmail.com"
        },
        License = new OpenApiLicense
        {
            Name = "MIT",
        }
    });
    
});

// Servicios
builder.Services.AddScoped<IGeocercaService, GeocercaService>();
builder.Services.AddScoped<IVendedorExternoService, VendedorExternoService>();

builder.Services.AddHttpClient<IVendedorExternoService, VendedorExternoService>(client =>
{
    client.Timeout = TimeSpan.FromSeconds(30);
    client.DefaultRequestHeaders.Add("User-Agent", "ApiNetCore/1.0");
});

//Cors
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(corsPolicyBuilder =>
    {
        corsPolicyBuilder.AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});

// AutoMapper
builder.Services.AddAutoMapper(typeof(MappingProfile));

//DbContext MySql
builder.Services.AddDbContext<MyDbContextMysql>(options =>
    options.UseMySql(builder.Configuration.GetConnectionString("DefaultConnectionMysql"), 
        ServerVersion.AutoDetect(builder.Configuration.GetConnectionString("DefaultConnectionMysql"))));

var app = builder.Build();

// Middlewares (orden importante)
app.UseMiddleware<ResponseTimeMiddleware>();
app.UseMiddleware<ExceptionHandlingMiddleware>();

// Swagger habilitado para todos los entornos
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "API de Geolocalización v1");
    c.RoutePrefix = string.Empty; // Opcional: hace que Swagger sea la página de inicio en '/'
    
    // Configuraciones adicionales de la UI
    c.DocExpansion(Swashbuckle.AspNetCore.SwaggerUI.DocExpansion.None);
    c.DisplayRequestDuration();
    c.EnableDeepLinking();
    c.EnableFilter();
    c.ShowExtensions();
    c.EnableValidator();
});

// Redirección condicional basada en el entorno
if (app.Environment.IsDevelopment())
{
    // En desarrollo, Swagger estará disponible tanto en /swagger como en /
    app.MapGet("/", () => Results.Redirect("/swagger")).ExcludeFromDescription();
}
else
{
    // En producción, puedes mantener la redirección o mostrar una página diferente
    app.MapGet("/", () => Results.Ok(new { 
        message = "API de Geolocalización", 
        version = "v1",
        documentation = "/swagger",
        status = "Running"
    })).ExcludeFromDescription();
}

app.UseHttpsRedirection();
app.UseCors(); // Mover CORS antes de Authorization
app.UseAuthorization();
app.MapControllers();

app.Run();