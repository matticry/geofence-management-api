﻿namespace ApiNetCore.Dtos.Paginacion;

public class PaginacionDto
{
    public int PaginaActual { get; set; }
    public int TamanioPagina { get; set; }
    public int TotalRegistros { get; set; }
    public int TotalPaginas { get; set; }
}