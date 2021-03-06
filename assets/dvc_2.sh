#!/bin/bash

TIMEOUT=60

_maketemp(){
    mktemp -q "/tmp/$(basename "${0}").XXXXXX"
    if [ "${?}" -ne 0 ]; then
        echo "${0}: Can't create temp file, exiting..."
        _writeerrorlog "_maketemp" "was unable to create the temp file, so the script had to exit."
        exit 1
    fi
}

_select_devices(){
    DEVICE_LIST="$(avfctl -list_devices 2>&1 | grep -A 24 "Devices:" | tail -n +2 | cut -d "]" -f2- | sed 's|^ ||g')"
    DEVICE_LIST_COUNT="$(echo -n "${DEVICE_LIST}" | grep -c "^")"
    if [[ "${DEVICE_LIST_COUNT}" == 0 ]] ; then
        echo "No DV devices found :("
    elif [[ "${DEVICE_LIST_COUNT}" == 1 ]] ; then
        echo "Will read from $(echo "${DEVICE_LIST}" | cut -c 5-)"
    else
        echo "Select an input device by number or enter 'S' to check the status of each device."
        echo "${DEVICE_LIST}"
        read DEV_SELECTION
        if [[ "${DEV_SELECTION}" =~ ^[0-9]+$ ]]; then
            if ((DEV_SELECTION >= 0 && DEV_SELECTION <= (DEVICE_LIST_COUNT - 1) )); then
                echo "OK, let's use ${DEV_SELECTION}."
            else
                echo "${DEV_SELECTION} is not an option."
                exit
            fi
        else
            if [[ "${DEV_SELECTION}" == "S" ]] || [[ "${DEV_SELECTION}" == "s" ]] ; then
                COUNTER=0
                while [[ "${COUNTER}" -le "${DEVICE_LIST_COUNT}" ]] ; do
                    avfctl -device "${COUNTER}" -status 2>&1 | grep -o "Device.*"
                    COUNTER=$((COUNTER + 1))
                done
            fi
            _select_devices
        fi
    fi
    DECK_LABEL="$(echo "$DEVICE_LIST" | grep "^\[${DEV_SELECTION}\]" | cut -d "]" -f2- | sed 's|^ ||g')"
}

_capture_tape(){
    FILENAME="${1}"
    DVPID="$(_maketemp)"
    DV="${OUT}/${FILENAME}.dv"
    XML="${OUT}/${FILENAME}.dvrescue.xml"
    SCC="${OUT}/${FILENAME}.scc"
    VTT="${OUT}/${FILENAME}.vtt"
    DV="${OUT}/${FILENAME}.dv"
    DV_LINE="${DEV_SELECTION}|${DECK_LABEL}|${DV}"
    echo "${DV_LINE}" >> /tmp/dv_plays.txt
    ( avfctl -device "${DEV_SELECTION}" -cmd capture - & echo $! > "${DVPID}" ) | dvrescue - --timeout "${TIMEOUT}" --verbosity 7 -x "${XML}" -c "${SCC}" --cc-format scc -s "${VTT}" --merge "${DV}" &
    while [[ ! -s "${XML}" ]] ; do
        sleep "${TIMEOUT}"
    done
    grep -v "${DV_LINE}" /tmp/dv_plays.txt > /tmp/dv_plays2.txt
    mv /tmp/dv_plays2.txt /tmp/dv_plays.txt
    echo "Trying to stop"
    cat "${DVPID}"
    echo "what is that"
    kill "$(cat "${DVPID}")"
}

_rewind_tape(){
    avfctl -cmd rew -device "${DEV_SELECTION}" -foreground
}
_rewindx2(){
    _rewind_tape
    _rewind_tape
}

_select_devices

echo
echo -n "Enter tape ID: "
read ID
echo -n "Add output folder: "
read OUT

if [[ ! -d "${OUT}" ]] ; then
    echo "Error: there is no folder at ${OUT}."
fi

# run this like:

# try to rewind the tape twice
_rewindx2
# capture a first take
_capture_tape "${ID}_take1"
# rewind the tape again (twice, why not?)
_rewindx2
# capture a second take
#_capture_tape "${ID}_take2"

# merge the two takes into a better output
#dvrescue "${OUT}/${ID}_take1.dv" "${OUT}/${ID}_take2.dv" --verbosity 9 --merge "${OUT}/${ID}_merged.dv" > "${OUT}/${ID}_merge_summary.txt"

# make dvrescue xml files for each one
#dvrescue "${OUT}/${ID}_take1.dv" -x "${OUT}/${ID}_take1.dv.xml" -c "${OUT}/${ID}_take1.dv.scc" -s "${OUT}/${ID}_take1.dv.vtt"
#dvrescue "${OUT}/${ID}_take2.dv" -x "${OUT}/${ID}_take2.dv.xml" -c "${OUT}/${ID}_take2.dv.scc" -s "${OUT}/${ID}_take2.dv.vtt"
#dvrescue "${OUT}/${ID}_merged.dv" -x "${OUT}/${ID}_merged.dv.xml" -c "${OUT}/${ID}_merged.dv.scc" -s "${OUT}/${ID}_merge.dv.vtt"
