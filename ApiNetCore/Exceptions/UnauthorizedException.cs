﻿namespace ApiNetCore.Exceptions;

public class UnauthorizedException(string message) : Exception(message);