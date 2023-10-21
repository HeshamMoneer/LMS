#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U SA -P 'y5#kA!Lm45]Uj*<' -i init.sql & 

/opt/mssql/bin/sqlservr