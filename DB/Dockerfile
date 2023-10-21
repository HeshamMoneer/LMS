FROM mcr.microsoft.com/mssql/server
WORKDIR /usr/src/app
COPY ./init.sql .
COPY ./entrypoint.sh .

ENV SA_PASSWORD "y5#kA!Lm45]Uj*<"
ENV ACCEPT_EULA Y
ENV MSSQL_PID Express

EXPOSE 1433

CMD /bin/bash ./entrypoint.sh