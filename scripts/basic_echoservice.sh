#!/bin/bash

. ./scripts/env.sh
# env for collecting data

# REPORT_PATH="${FILE_PATH}/data.log"
# DATA_PATH="${FILE_PATH}/data.csv"
# LATENCY_PATH="${FILE_PATH}/latency_${REPORT}"
REPORT_PATH="output/${REPORT}.log"
DATA_PATH="output/${REPORT}.csv"
LATENCY_PATH="output/latency_${REPORT}"

# make folder to store all latency data
# if [ ! -d ${FILE_PATH} ]; then
#   mkdir ${FILE_PATH}
# fi
if [ ! -d ${LATENCY_PATH} ]; then
  mkdir ${LATENCY_PATH}
fi


n=1000
body=(1024 1024 2048 4096 8192 16384 32768 65536)
concurrent=(100)
header=(1024)
serverIP="http://0.0.0.0"
ports=8888
path="Echo/echo"
addr="${serverIP}:${ports}/${path}"


# generate request in json for ab
 for b in ${body[@]}; do
     python3 ./scripts/ab/generate_request.py ${b}
 done

#warmup needed

# benchmark
for b in ${body[@]}; do
    for h in ${header[@]}; do
        for c in ${concurrent[@]}; do

            sleep 2
            echo "running test with body size $b"

            echo "Benchmark_Config" >> ${REPORT_PATH}
            echo "${n},${c},${b}" >> ${REPORT_PATH}
            latency_file="${LATENCY_PATH}/${n}_${c}_${b}.csv"
            # ab -n ${n} -c ${c} -e ${latency_file} -d -k -g "${FILE_PATH}/gnuplot.data" -p ./scripts/ab/request_${b}.json -T "application/json" ${addr} | $tee_cmd
            ab -n ${n} -c ${c} -e ${latency_file} -d -k -g "/output/out.data" -p ./scripts/ab/request_${b}.json -T "application/json" ${addr} | $tee_cmd

        done
    done
done

# parse data and generate output.csv
python3 ./scripts/ab/parse_data.py ${REPORT_PATH} ${LATENCY_PATH} ${DATA_PATH}