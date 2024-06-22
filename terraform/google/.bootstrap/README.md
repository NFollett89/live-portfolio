## Google Cloud Bootstrapping Steps
1. Create account with free $300 trial
1. Fully activate Billing Account via web console (Necessary for later setup)
1. Install [`gcloud-sdk`](https://cloud.google.com/sdk/docs/install-sdk)
1. Authorize local session
    1. `gcloud auth login`
    1. `gcloud auth application-default login`
1. (Temporarily) Export the sensitive Billing Account ID, e.g:
    1. `export BILLING_ACCOUNT_ID="ABC123-DEF456-GHI789"`
1. Run `./admin-project.sh`
    1. NOTE: This is idempotent and probably needs to be run multiple times
because of the behavior beteween `gcloud` exit codes and what the API is
still processing in the backend. It's not worth figuring out an 'elegant'
solution with `until` to make this one-click, as bootstrapping is supposed to
be one-time and then you move on.
1. Manually delete `My First Project` (auto-generated)
    1. `gcloud projects delete citric-dream-427209-g9`
1. Run `./terraform-key.sh`
1. Add export for `GOOGLE_APPLICATION_CREDENTIALS` to `~/.bash_profile`

