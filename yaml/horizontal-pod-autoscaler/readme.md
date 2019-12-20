# Installing metrics-server


1. Clone metrics-server git repo:
    ```
    git clone https://github.com/kubernetes-sigs/metrics-server.git
    cd deploy/1.8+/
    ```

2. Edit and add to the metrics-server-deployment.yaml:
    ```yaml
    # edit metric-server deployment to add the flags
    args:
      - --kubelet-insecure-tls
      - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    ```

3. Deploy the metrics-server:
    ```
    $ kubectl apply -f .
    ```


4. Check status:
    ```
    $ kubectl get pods -n kube-system | grep metrics
    ```


5. Test with :
    ```
    $ siege -q -c 5 -t 3m http://172.42.42.105
    ```


