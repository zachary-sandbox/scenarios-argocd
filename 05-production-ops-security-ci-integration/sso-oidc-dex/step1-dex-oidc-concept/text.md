# Step1 Dex OIDC concept

Dex built-inside Argo-CD:

- Dex is an OIDC identity broker.
- It does NOT store user database itself, delegates authentication to external IdP.
- After user authenticated by external IdP, Dex issues OIDC id_token for Argo-CD api-server.
- Argo-CD parses groups claim from token and applies Argo-CD RBAC policy.

Workflow:

1. User click SSO login on Argo-CD UI
2. Redirect to Dex → redirect to external IdP
3. User authenticate at IdP
4. Callback to Dex, Dex generate id_token
5. Callback to Argo-CD, Argo-CD validate token and apply RBAC policy.
