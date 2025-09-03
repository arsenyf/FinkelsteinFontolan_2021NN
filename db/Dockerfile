
# db/Dockerfile:
#
# customization of mysql.cnf of the datajoint/mysql container
# to lower memory requirements.
#
# built as separate container since config needs to be read-only
# and making read only as a volume mount of the configuration can
# be tricky/less user friendly in some cases.

FROM datajoint/mysql:5.7

COPY mysql.cnf /etc/mysql/mysql.cnf

