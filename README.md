# 🌍 API de Geocercas - Sistema de Geolocalización

## 📋 Descripción

Esta API REST desarrollada en .NET Core permite gestionar geocercas (geofences) para el control y monitoreo de ubicaciones geográficas. Proporciona funcionalidades para crear, consultar y administrar áreas geográficas definidas por coordenadas de latitud y longitud.

## 🏗️ Arquitectura del Proyecto

```
📁 ApiNetCore/
├── 📁 Controllers/          # Controladores de la API
├── 📁 Dependencies/         # Inyección de dependencias
├── 📁 Properties/          # Propiedades del proyecto
├── 📁 ContextMySql/        # Contexto de base de datos
├── 📁 Dtos/                # Data Transfer Objects
├── 📁 Enum/                # Enumeraciones
├── 📁 Exceptions/          # Manejo de excepciones personalizadas
├── 📁 Mappings/            # Mapeo de entidades
├── 📁 Models/              # Modelos de datos
├── 📁 Services/            # Lógica de negocio
├── 📁 Utils/               # Utilidades
├── 📄 .env                 # Variables de entorno
├── 📄 ApiNetCore.http      # Pruebas HTTP
├── 📄 appsettings.json     # Configuración principal
├── 📄 appsettings.Development.json  # Configuración de desarrollo
└── 📄 bd.sql               # Script de base de datos
```

## ✨ Características

- 🗺️ **Gestión de Geocercas**: Creación y administración de áreas geográficas
- 📍 **Coordenadas Precisas**: Manejo de latitud y longitud con alta precisión
- 🏢 **Multi-empresa**: Soporte para múltiples empresas
- 📄 **Paginación**: Consultas paginadas para mejor rendimiento
- 🔧 **Documentación Swagger**: API documentada e interactiva
- ⚡ **Respuestas Estandarizadas**: Estructura consistente de respuestas
- 🛡️ **Validación HTTP**: Códigos de estado apropiados (200, 400, 500)

## 🚀 Tecnologías Utilizadas

- **.NET Core**: Framework principal
- **MySQL**: Base de datos
- **Swagger/OpenAPI**: Documentación interactiva
- **Entity Framework**: ORM para acceso a datos
- **AutoMapper**: Mapeo de objetos
- **Dependency Injection**: Patrón de inyección de dependencias

## 🔧 Configuración

### Prerrequisitos

- .NET Core SDK 6.0 o superior
- MySQL Server
- Visual Studio o Visual Studio Code

### Instalación

1. **Clonar el repositorio**
   ```bash
   git clone <url-del-repositorio>
   cd ApiNetCore
   ```

2. **Configurar la base de datos**
   ```bash
   # Ejecutar el script bd.sql en MySQL
   mysql -u usuario -p < bd.sql
   ```

3. **Configurar variables de entorno**
   ```bash
   # Crear archivo .env con la configuración necesaria
   DATABASE_CONNECTION="Server=localhost;Database=geocercas;Uid=user;Pwd=password;"
   ```

4. **Restaurar paquetes**
   ```bash
   dotnet restore
   ```

5. **Ejecutar la aplicación**
   ```bash
   dotnet run
   ```

## 📊 Estructura de Respuesta

Todas las respuestas de la API siguen el siguiente formato estándar:

```json
{
  "success": boolean,
  "message": "string",
  "data": object,
  "errorCode": "string",
  "validationErrors": array,
  "timestamp": "datetime",
  "responseTimeMs": number,
  "requestId": "string"
}
```

## 📚 Endpoints Principales

### 🗺️ Obtener Geocercas por Empresa

**GET** `/api/Geocerca/getListGeofenceByEnterprise`

Obtiene la lista paginada de geocercas asociadas a una empresa específica.

#### Parámetros

| Parámetro | Tipo | Requerido | Descripción |
|-----------|------|-----------|-------------|
| `pageNumber` | int | Sí | Número de página (empezando en 1) |
| `pageSize` | int | Sí | Cantidad de registros por página |
| `enterpriseName` | string | Sí | Nombre de la empresa |

#### Ejemplo de Uso

```bash
GET http://localhost:5157/api/Geocerca/getListGeofenceByEnterprise?pageNumber=1&pageSize=10&enterpriseName=MEVECSA
```

#### Respuesta Exitosa (200 OK)

```json
{
  "success": true,
  "message": "Las geocercas fueron obtenidas correctamente",
  "data": {
    "data": [
      {
        "geoccod": "GEO002",
        "geocnom": "PLAZA GRANDE",
        "geocsec": "CENTRO HISTÓRICO",
        "geocciud": "QUITO",
        "geocprov": "PICHINCHA",
        "geocpais": "ECUADOR",
        "geoclat": -0.220588,
        "geoclon": -78.512764,
        "geoccoor": "[{\"lat\": -0.220388, \"lng\": -78.513064}, {\"lat\": -0.220388, \"lng\": -78.512464}]",
        "geocdesc": "Plaza de la Independencia - centro histórico",
        "geocdirre": "GARCIA MORENO Y CHILE",
        "geocarm": 3600,
        "geocperm": 240,
        "geocest": "A",
        "geocact": true,
        "geocpri": 3,
        "geocfcre": "2025-09-10T09:20:15"
      }
    ],
    "paginacion": {
      "paginaActual": 1,
      "tamanioPagina": 10,
      "totalRegistros": 10,
      "totalPaginas": 1
    }
  },
  "errorCode": "SUCCESS",
  "validationErrors": null,
  "timestamp": "2025-09-24T20:47:43.818287Z",
  "responseTimeMs": 2997,
  "requestId": "4f68d0fe-6431-49e4-8898-8021a2515a3e"
}
```

## 📖 Modelo de Datos - Geocerca

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `geoccod` | string | Código único de la geocerca |
| `geocnom` | string | Nombre de la geocerca |
| `geocsec` | string | Sector o zona |
| `geocciud` | string | Ciudad |
| `geocprov` | string | Provincia |
| `geocpais` | string | País |
| `geoclat` | decimal | Latitud central |
| `geoclon` | decimal | Longitud central |
| `geoccoor` | string | Coordenadas JSON del polígono |
| `geocdesc` | string | Descripción detallada |
| `geocdirre` | string | Dirección de referencia |
| `geocarm` | int | Área en metros cuadrados |
| `geocperm` | int | Perímetro en metros |
| `geocest` | string | Estado (A=Activo, I=Inactivo) |
| `geocact` | boolean | Activo/Inactivo |
| `geocpri` | int | Prioridad (1-3) |
| `geocfcre` | datetime | Fecha de creación |

## ⚠️ Códigos de Respuesta HTTP

| Código | Descripción |
|--------|-------------|
| **200** | ✅ Petición exitosa |
| **400** | ❌ Solicitud incorrecta - parámetros inválidos |
| **404** | 🔍 Recurso no encontrado |
| **500** | 💥 Error interno del servidor |

### Ejemplo de Error 400

```json
{
  "success": false,
  "message": "Parámetros de consulta inválidos",
  "data": null,
  "errorCode": "INVALID_PARAMETERS",
  "validationErrors": [
    {
      "field": "pageNumber",
      "message": "El número de página debe ser mayor a 0"
    }
  ],
  "timestamp": "2025-09-24T20:47:43.818287Z",
  "responseTimeMs": 150,
  "requestId": "error-request-id"
}
```

### Ejemplo de Error 500

```json
{
  "success": false,
  "message": "Error interno del servidor",
  "data": null,
  "errorCode": "INTERNAL_SERVER_ERROR",
  "validationErrors": null,
  "timestamp": "2025-09-24T20:47:43.818287Z",
  "responseTimeMs": 500,
  "requestId": "error-request-id"
}
```

## 🔧 Documentación Interactiva

La API cuenta con documentación Swagger interactiva disponible en:

**URL de Swagger**: `http://localhost:5157/swagger`

### Características de Swagger:
- 📋 **Exploración Interactiva**: Prueba los endpoints directamente desde el navegador
- 📘 **Documentación Detallada**: Descripción completa de cada endpoint
- 🧪 **Pruebas en Tiempo Real**: Ejecuta peticiones y ve las respuestas
- 📊 **Esquemas de Datos**: Visualización clara de los modelos de datos

## 🧪 Pruebas

### Usando curl

```bash
# Obtener geocercas paginadas
curl -X GET "http://localhost:5157/api/Geocerca/getListGeofenceByEnterprise?pageNumber=1&pageSize=5&enterpriseName=MEVECSA" \
     -H "accept: application/json"
```

### Usando el archivo ApiNetCore.http

El proyecto incluye un archivo `ApiNetCore.http` con ejemplos de peticiones HTTP que puedes ejecutar directamente desde Visual Studio Code con la extensión REST Client.

## 🤝 Contribución

1. Fork el repositorio
2. Crea una rama feature (`git checkout -b feature/NuevaCaracteristica`)
3. Commit tus cambios (`git commit -m 'Agregar nueva característica'`)
4. Push a la rama (`git push origin feature/NuevaCaracteristica`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 👥 Equipo de Desarrollo

- **Backend**: Equipo de desarrollo .NET Core
- **Database**: Administradores de MySQL
- **DevOps**: Equipo de infraestructura

## 📞 Soporte

Para soporte técnico o consultas:
- 📧 Email: soporte@empresa.com
- 📱 Slack: #api-geocercas
- 🎫 Issues: Crear un issue en el repositorio

---

⭐ **¡No olvides dar una estrella al repositorio si te resultó útil!**
