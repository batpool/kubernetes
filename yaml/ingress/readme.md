# Installing the Ingress Controller

## Create a Namespace, a SA, the Default Secret, the Customization Config Map, and Custom Resource Definitions

1. Clone the Ingress controller git repo:
    ```
    git clone https://github.com/nginxinc/kubernetes-ingress.git
    cd kubernetes-ingress/deployments/
    ```

2. Create a namespace and a service account for the Ingress controller:
    ```
    $ kubectl apply -f common/ns-and-sa.yaml
    ```

3. Create a config map for customizing NGINX configuration:
    ```
    $ kubectl apply -f common/nginx-config.yaml
    ```


4. If RBAC is enabled in your cluster, create a cluster role and bind it to the service account, created in Step 1:
    ```
    $ kubectl apply -f rbac/rbac.yaml
    ```

5. Create a DaemonSet
    ```
    $ kubectl apply -f daemon-set/nginx-ingress.yaml
    ```

6. Create Service with the Type LoadBalancer

    Create a service with the type *LoadBalancer*. Kubernetes will allocate and configure a cloud load balancer for load balancing the Ingress controller pods.

    ```
    $ kubectl apply -f service/loadbalancer.yaml
    ```

7.  Check :
    ```
    $ kubectl get all -n nginx-ingress
    ```


## Uninstall the Ingress Controller

Delete the `nginx-ingress` namespace to uninstall the Ingress controller along with all the auxiliary resources that were created:
```
$ kubectl delete namespace nginx-ingress
```

**Note**: If RBAC is enabled on your cluster and you completed step 2, you will need to remove the ClusterRole and ClusterRoleBinding created in that step:

```
$ kubectl delete clusterrole nginx-ingress
$ kubectl delete clusterrolebinding nginx-ingress
```
