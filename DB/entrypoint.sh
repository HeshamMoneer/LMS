#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U ${SA_USER} -P ${SA_PASSWORD} -v DB_NAME=${DB_NAME} -i init.sql &&

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U ${SA_USER} -P ${SA_PASSWORD} -d ${DB_NAME} -i proc-book.sql &&

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U ${SA_USER} -P ${SA_PASSWORD} -d ${DB_NAME} -i proc-borrow.sql &&

/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U ${SA_USER} -P ${SA_PASSWORD} -d ${DB_NAME} -i proc-borrower.sql &

/opt/mssql/bin/sqlservr