#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U SA -P ${SA_PASSWORD} -i init.sql &&

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U SA -P ${SA_PASSWORD} -d LMS -i proc-book.sql &&

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U SA -P ${SA_PASSWORD} -d LMS -i proc-borrow.sql &&

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U SA -P ${SA_PASSWORD} -d LMS -i proc-borrower.sql &

/opt/mssql/bin/sqlservr