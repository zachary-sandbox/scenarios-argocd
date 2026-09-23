# Step4 argocd cli login and connectivity test

Get `svc/argocd-server`
```bash
kubectl get svc argocd-server -n argocd
```

and you can see:

```text
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
argocd-server   NodePort   10.105.97.185   <none>        80:30080/TCP,443:30443/TCP   16m
```

Your username `admin` initial password saved to `argocd_admin_password.txt`.

Execute login command:
```bash
# localhost http port test
argocd login 127.0.0.1:30080 --username admin --password $(cat argocd_admin_password.txt) --plaintext --grpc-web

# localhost https port test
argocd login 127.0.0.1:30443 --username admin --password $(cat argocd_admin_password.txt) --plaintext --grpc-web

# pod ip http port test
argocd login 10.105.97.185:80 --username admin --password $(cat argocd_admin_password.txt) --plaintext --grpc-web

# localhost https port test
argocd login 10.105.97.185:443 --username admin --password $(cat argocd_admin_password.txt) --plaintext --grpc-web
```

After login complete, run:
```bash
argocd version
```
Should print both client version and server version information without errors.
