FROM mcr.microsoft.com/mssql/server
WORKDIR /usr/src/app
COPY . .

ENV ACCEPT_EULA Y
ENV MSSQL_PID Express

EXPOSE 1433

CMD /bin/bash ./entrypoint.sh