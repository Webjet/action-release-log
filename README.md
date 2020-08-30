# Github Relase Log

Download Github Action log and upload to release

## Example usage

```
  - uses: Webjet/action-release-log@v1
    with:
      release-id: ${{ steps.release.outputs.id }}
      job-id: ${{ steps.build-job.outputs.job_id }}
      company: 'Webjet'
      repo: 'TSA'
```
