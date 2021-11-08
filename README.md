AKS Cluster with Helm Chart deployment.


1. Created SPN account with full permission in Azure AD to deploy all required actions. All sensitive data stored in the github secrets.
 ( Clinet ID / Cliet Secret / Tenant id / subscription details )    

    Therefore please use your own details replace before you execute pipeline.
    Here used github terraform action for build the deplyment and it's auto tigger after push the code to the repository.

2.  In the azure, they are provided addon for install ingress contorller when create K8 cluster

Install Nginx ingress controller

 addon_profile {
        http_application_routing {
         enabled = true
    }

https://docs.microsoft.com/en-us/azure/aks/http-application-routing

2. terraform modules concept used to create vnet in the Azure
    Modules/vnet

3. Helm installation in the runner, creating helm project, creating helm package, and helm package installing handled in the pipeline.

# install Helm in ubuntu
    - name: install helm 01
      run:  |
        curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
        sudo apt-get install apt-transport-https --yes
        echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list   

    - name: update helm binary
      run:  |
        sudo apt-get update
        sudo apt-get install helm
    # execute package module from Helm Chart
    - name: Change direcory to the HelmAKS
      run:  |
        cd /home/runner/work/CreateAKS/CreateAKS
        pwd
        helm package HelmAKS 
        helm install release1 HelmAKS-0.1.0.tgz   
     

 4. Required genarate file ( artifacts)  are uploaded to future use

 - uses: actions/upload-artifact@v2
      with:
        name: kubeconfig
        path: /home/runner/work/CreateAKS/CreateAKS/

- uses: actions/upload-artifact@v2
      with:
        name: HelmAKS-0.1.0.tgz
        path: /home/runner/work/CreateAKS/CreateAKS/HelmAKS/

 5. After the deplyment you able to access kubernerties home page access via below URL

    execute below command
    $kubectl describe ingress hello-kubernetes

------------------------------------------------------------
    output
    Name:             hello-kubernetes
    Namespace:        default
    Address:          20.83.93.0
    Default backend:  hello-kubernetes:80 (10.244.1.2:8080)
    Rules:
    Host        Path  Backends
    ----        ----  --------
    *
              /   hello-kubernetes:80 (10.244.1.2:8080)
Annotations:  kubernetes.io/ingress.class: addon-http-application-routing
              meta.helm.sh/release-name: release1
              meta.helm.sh/release-namespace: default
Events:       <none>

----------------------------------------

    https://Address/

6. get more details ( logs ) for ingress controller,  please use below command


kubectl logs -f deploy/addon-http-application-routing-nginx-ingress-controller -n kube-system

-------------------------------------------------------------------------------
NGINX Ingress controller
  Release:    0.19.0
  Build:      git-05025d6
  Repository: https://github.com/kubernetes/ingress-nginx.git
-------------------------------------------------------------------------------
