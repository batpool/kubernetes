# Installation MetalLB


MetalLB hooks into your Kubernetes cluster, and provides a network load-balancer implementation. In short, it allows you to create Kubernetes services of type “LoadBalancer” in clusters that don’t run on a cloud provider, and thus cannot simply hook into paid products to provide load-balancers.


### Installation

```sh
$ ckubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.3/manifests/metallb.yaml
```

create a file metallb.yaml and add below content...

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      # put your vertualbox DHCP RANGE
      - 172.42.42.110-172.42.42.120

```


License
----

MIT


**Free Software, Hell Yeah!**
