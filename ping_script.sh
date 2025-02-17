#!/bin/bash

URL="google.com"

fail_count=0

while true; do
    ping_output=$(ping -c 1 -W 1 "$URL")
    if [[ $? -eq 0 ]]; then
        response_time=$(echo "$ping_output" | awk -F'time=| ms' '/time=/{print $2}')
        response_time=${response_time%.*}

        if [[ $response_time -gt 100 ]]; then
		echo "Alert!: response time $response_time exceeds 100 ms. AI breakout is imminent. Proceed to shelter! :)"
        else
            echo "Response time: $response_time ms."
        fi

        fail_count=0
    else
        ((fail_count++))
        echo "Failure: unable to get response from $URL. Attempt $fail_count from 3."

        if [[ $fail_count -ge 3 ]]; then
            echo "Failure: $URL unreacheable after three attempts."
            fail_count=0
        fi
    fi
    sleep 1
done


