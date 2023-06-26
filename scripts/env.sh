REPORT=${REPORT:-"$(date +%F-%H-%M)"}
# FILE_PATH="output/${REPORT}"

# tee_cmd="tee -a ${FILE_PATH}/output.data"
tee_cmd="tee -a output/${REPORT}.log"