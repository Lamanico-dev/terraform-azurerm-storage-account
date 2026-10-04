# Fix notes

This version is aligned to Terraform >= 1.6 and AzureRM >= 4,<5.

Key fixes:
- removed the obsolete `module_variable_optional_attrs` experiment;
- added/declared all inputs used by the test caller;
- uses the AzureRM 4 storage-account argument `https_traffic_only_enabled`;
- exact `name` is honoured (and validated) instead of silently generating/replacing it;
- network rules default to an empty list so the test caller does not create unexpected extra rules;
- container/file-share child modules use `storage_account_id` rather than deprecated name-based linkage;
- old compatibility inputs remain available where practical.
