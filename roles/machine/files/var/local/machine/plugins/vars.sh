#!/usr/bin/env bash

export WORK_ZONE_PATH=/opt/workzone
export WORK_ZONE_APPS=${WORK_ZONE_PATH}/apps
export WORK_ZONE_LOG=${WORK_ZONE_PATH}/logs
export WORK_ZONE_DB=${WORK_ZONE_PATH}/dbs
export WORK_ZONE_DB_DATA=${WORK_ZONE_PATH}/data


# EXPORT GO LANG PATH
if [ -d ${PG_ZONE}/go ]; then
    export GOROOT=${PG_ZONE}/go1.9
    export PATH=$PATH:${GOROOT}/bin
fi

# EXPORT MONGODB
if [ -d ${PG_ZONE_DB}/mongodb ]; then
    export MONGODB_PATH_BIN=${PG_ZONE_DB}/mongodb/bin
    export MONGO_PATH_DATA=${PG_ZONE_DB_DATA}/mongodb_data
    export MONGO_PATH_LOG=${PG_ZONE_LOG}/mongodb
    export PATH=$PATH:${MONGODB_PATH_BIN}
fi

# EXPORT NODEJS TO PATH
if [ -d ${PG_ZONE}/langs/nodejs ]; then
    export PATH=$PATH:${PG_ZONE}/langs/nodejs
fi