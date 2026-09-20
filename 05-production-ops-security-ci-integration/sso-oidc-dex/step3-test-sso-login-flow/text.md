# Step3 Test SSO login flow

1. Open Argo‑CD Web UI browser window (incognito mode recommended).
2. You should see SSO login button besides local admin login.
3. Click SSO button, redirect to GitHub / your IdP login page.
4. Complete authentication, redirect back to Argo‑CD UI.
5. Check user info page, verify group claim correctly mapped.

Troubleshooting:

- Check argocd‑dex pod logs for connector error
- Check argocd‑api‑server pod logs for token parsing error
