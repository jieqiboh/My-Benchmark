# Overview
## Godzilla Benchmark

Currently gets QPS and TP99

- Uses Apache Bench for sending requests
- Takes elements of testing from Hertz Benchmark such as usage of an Echo service
- Autogenerates graphs

## Parameters

- number of requests (1000)
- bodysize (1024 2048 4096 8192 16384 32768 65536)
- concurrent (100)
- ServerIP and ports

## Tech

- Bash script
- Golang
- Apache Bench

## Installation

Dillinger requires [Node.js](https://nodejs.org/) v10+ to run.

Install the dependencies

1. Generate json bodies to be sent:
- Under scripts/ab/generate_request.py, modify the generate_json(size) method with your request body
- uncomment the lines under "generate request in json for ab" for the first run to generate the necessary files

2. Modify the variables in basic_echoservice.sh according to your gateway address and path to echoservice

3. Install the required python packages (numpy, matplotlib)

4. Run shell command to start tests
```sh
sh scripts/basic_echoservice.sh
```
5. Run python3 command to generate plots for qps and tps99 in output/plots
```sh
python3 scripts/generate_plots.py
```

## Possible Issues
If your server is rate-limiting, your connection may be terminated early. In that case, restart your server and gateway and re-run.




