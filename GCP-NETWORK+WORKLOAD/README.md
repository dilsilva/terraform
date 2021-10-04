Observations:

For v1.0:
For our legacy deployment to work correctly, it is important to always enable OSlogin inside every project that the infrastructure needs to be deployed.

```gcloud compute project-info add-metadata \
    --metadata enable-oslogin=TRUE````

Doc: https://cloud.google.com/compute/docs/instances/managing-instance-access#install-guest-environment