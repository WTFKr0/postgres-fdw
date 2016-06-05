FROM    postgres:9.4
#FROM   debian:jessie

RUN     apt-get update && apt-get install -y build-essential python-dev python-pip postgresql-server-dev-9.5 wget && apt-get clean && \
        #apt-get update && apt-get install -y build-essential python-dev python-pip wget && apt-get clean
        pip install pgxnclient

#RUN    export http_proxy=http://H77833:Macif123@proxy.igrt.macif.fr:3128 && \
#        export https_proxy=http://H77833:Macif123@proxy.igrt.macif.fr:3128 && \
#       apt-get install -y libreadline-dev zlib1g-dev && \
#       cd / && \
#       wget https://ftp.postgresql.org/pub/source/v9.5.3/postgresql-9.5.3.tar.gz && \
#       tar xvzf postgresql-9.5.3.tar.gz && \
#       cd postgresql-9.5.3 && \
#       sed -i "s/NAMEDATALEN 64/NAMEDATALEN 512/g" ./src/include/pg_config_manual.h && \
#       ./configure && \
#       make world && \
#       make install-world && \
#       cd / && \
#       rm -rf postgresql-9.5.3 postgresql-9.5.3.tar.gz

#RUN    export http_proxy=http://H77833:Macif123@proxy.igrt.macif.fr:3128 && \
#        export https_proxy=http://H77833:Macif123@proxy.igrt.macif.fr:3128 && \
#       export PATH=$PATH:/usr/local/pgsql/bin && \
#       useradd -m postgres && \
#       mkdir -p /usr/local/pgsql/data && \
#       chown -R postgres: /usr/local/pgsql/data && \
#       su - postgres -c "/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data"

# Multicorn
RUN     pgxn install multicorn

# Mysql
RUN     apt-get install -y libmysqlclient-dev && \
        wget https://github.com/EnterpriseDB/mysql_fdw/archive/REL-2_1_2.tar.gz && \
        tar xvzf REL-2_1_2.tar.gz && \
        cd mysql_fdw-REL-2_1_2 && \
        make USE_PGXS=1 && \
        make USE_PGXS=1 install && \
        cd .. && \
        rm -rf mysql_fdw-REL-2_1_2 REL-2_1_2.tar.gz

# Oracle
#ADD     instant_client.tar.gz /
#RUN     echo /instantclient_12_1 | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && \
#        ldconfig && \
#        apt-get install -y libaio1 && \
#        export ORACLE_HOME=/instantclient_12_1 && \
#        wget https://github.com/laurenz/oracle_fdw/archive/ORACLE_FDW_1_4_0.tar.gz && \
#        tar xvzf ORACLE_FDW_1_4_0.tar.gz && \
#        cd oracle_fdw-ORACLE_FDW_1_4_0 && \
#        make USE_PGXS=1 && \
#        make USE_PGXS=1 install && \
#        cd .. && \
#        rm -rf ORACLE_FDW_1_4_0.tar.gz oracle_fdw-ORACLE_FDW_1_4_0

# Redis
RUN     apt-get install -y libhiredis-dev && \
        wget -O redis_fdw.tar.gz https://github.com/pg-redis-fdw/redis_fdw/tarball/REL9_5_STABLE && \
        tar xvzf redis_fdw.tar.gz && \
        cd pg-redis-fdw-redis_fdw* && \
        make USE_PGXS=1 && \
        make USE_PGXS=1 install && \
        cd / && \
        rm -rf pg-redis-fdw-redis_fdw* redis_fdw.tar.gz

## Tools
RUN     apt-get install -y vim

## clients
RUN     apt-get install -y mysql-client

# Json
#RUN     apt-get install zlib1g-dev libyajl-dev && \
#        wget -O json_fdw.tar.gz https://github.com/nkhorman/json_fdw/tarball/master && \
#        tar xvzf json_fdw.tar.gz && \
#        cd nkhorman-json_fdw* && \
#        make && \
#        make install && \
#        cd .. && \
#        rm -rf json_fdw.tar.gz nkhorman-json_fdw*

# Twitter
#RUN     apt-get install -y libcurl4-gnutls-dev && \
#        wget https://github.com/umitanuki/twitter_fdw/archive/v1.1.1.tar.gz && \
#        tar xvzf v1.1.1.tar.gz && \
#        ls -l && \
#        cd twitter_fdw-1.1.1 && \
#        make && \
#        make install && \
#        cd / && \
#        rm -rf twitter_fdw-1.1.1 v1.1.1.tar.gz

#ADD    startup.sh /
#EXPOSE 5432
#CMD ["/startup.sh"]

