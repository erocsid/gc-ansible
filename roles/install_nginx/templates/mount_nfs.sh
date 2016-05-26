#!/bin/bash

if grep nfs /etc/fstab > /dev/null; then
    echo "NFS mount already exists in fstab, exiting";
    mount -a
    exit 0;
fi

echo "10.240.0.7:/data /data nfs defaults 0 0" >> /etc/fstab
echo "NFS mount added to fstab"

mount -a

exit 1;
