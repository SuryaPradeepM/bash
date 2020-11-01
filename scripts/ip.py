#!/usr/bin/python3

import subprocess
import os
with open(os.devnull, "wb") as limbo:
        for n in range(0, 255):
                ip=f"192.168.227.{n}"
                result=subprocess.Popen(["ping", "-n", "1", "-w", "200", ip],
                        stdout=limbo, stderr=limbo).wait()
                if result:
                        print(ip, "inactive")
                        a = ip
                else:
                        print(ip, "active")
