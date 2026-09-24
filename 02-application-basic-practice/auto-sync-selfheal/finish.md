### ✅ WELL DONE !
Completed lab module: auto-sync-selfheal auto sync policy lab

📝 Recap Notes
1. automated: true → Argo-CD automatically performs sync when git desired state changes.
2. selfHeal: true → any manual live-cluster modifications get automatically reverted back to git definition.
3. prune: true → resources removed from git manifest will be deleted from target kubernetes cluster.
> Production hint: carefully evaluate prune risk; accidental git file deletion will delete live cluster resources.

Next lab module: `sample-guestbook` full end-to-end guestbook sample workflow.
