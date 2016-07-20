#!/bin/bash

if grep nfs /etc/fstab > /dev/null; then
    echo "NFS mount already exists in fstab, exiting";
    mount -a
    exit 0;
fi

echo "fileserver1:/data /data nfs defaults 0 0" >> /etc/fstab
echo "NFS mount added to fstab"

mount -a

exit 1;
