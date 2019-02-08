#!/bin/bash
kubectl create ns baremetal
kubectl -n baremetal create cm nginx-baremetal-config --from-file default.conf
kubectl -n baremetal create cm nginx-baremetal-www-data --from-file index.html
