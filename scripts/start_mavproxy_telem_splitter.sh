# this starts mavproxy so that the serial link to the companion computer (on /dev/ttyACM0)
# is available to a companion computer and external GCSs via UDP. This broadcasts so that
# multiple IP addresses can receive the telemetry.

# For PixHawk or other connected via USB on Raspberry Pi
cd /home/pi
# Determine if the param file exists.  If not, use default.
if [ -e mavproxy.param ]; then
    paramFile="mavproxy.param"
else
    paramFile="companion/params/mavproxy.param.default"
fi
# Replace all whitespace characters between quote marks with the hex
# representation of a space, remove quote marks
mavOptions=$(cat $paramFile \
    | awk '!(NR%2){gsub(FS,"\\x20")}1' RS=\" ORS=)
mavproxy.py $mavOptions
