#!/bin/bash

set -ex

archiv=$2

if [ "make" == "$1" ]; then
    while (( "$(expr $# - 2)" ))
    do

        dateien="$3 ${dateien}"

        shift

    done

    tar -cf ${archiv}.tar ${dateien}
    pixz ${archiv}.tar ${archiv}.tar.pxz

    # säuberung
    rm ${archiv}.tar
elif [ "restore" == "$1" ]; then

    [[ -z "${3}" ]] && ort="."

    pixz -d ${archiv} ${archiv/.pxz*}

    tar -xf ${archiv/.pxz*} -C ${ort}

    # säuberung
    rm ${archiv/.pxz*}
else
    echo "tar.pxz compress-script"
    echo "./compress.sh make/restore archivname input/output"
    echo "./compress.sh make archivname daten"
    echo "./compress.sh restore archivname ort"
    echo "or use"
    echo "tar -Ipixz -cf output.tpxz dir  # Make tar use pixz automatically"
fi
