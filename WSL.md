# Building Wireguard SOCKS Proxy on WSL (& why you might not want it)

## Install WSL

https://learn.microsoft.com/en-us/windows/wsl/install

After installation use the latest ubuntu distribution (default)

## Install docker

https://docs.docker.com/engine/install/ubuntu/

## Run directly on docker

Create a folder `wg-config` in this directory and put in your client conf file. Then run `. ./start.sh ./wg-config`.

Test your connection with `curl --proxy socks5h://127.0.0.1:1080 ipinfo.io`, as in readme.

## Troubleshoot

## WSL NAT

This is not required if you go direct port-forwarding in docker - but if you run a managed cluster: WSL and Windows Host is in different IP in a NAT locally. So you could `curl --proxy socks5h://127.0.0.1:1080 ipinfo.io` in your linux shell, but to use in windows applications you have to find the installation ip by `wsl -d ubuntu hostname -I`, then for instance git bash to `curl --proxy socks5h://172.31.141.115:32000 ipinfo.io`.

---

### Compile Custom Kernel

some core network functions is not included in standard ms built kernel, try build a custom one if you encounter issue
https://github.com/microsoft/WSL/issues/7547#issuecomment-2241526595

---

### Wireguard Conf file

To use in managed cluster, recommended to disable these address:
```
0.0.0.0/8, 
10.0.0.0/8, 
127.0.0.0/8, 
169.254.0.0/16, 
172.16.0.0/12, 
192.168.0.0/16, 
240.0.0.0/4, 
1.1.1.1/32, 
8.8.8.8/32, 
[peer endpoint]/32
```

Try [this](https://www.procustodibus.com/blog/2021/03/wireguard-allowedips-calculator/) ip calculator.