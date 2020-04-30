# Github Action
## Is Merged Pull Request

Simple Github Action to check if a merge commit is the merge commit of a pull request. 

```yaml
on:
  push:
    branches: master
jobs:
  demo-is-merged-job:
    runs-on: ubuntu-latest
    name: A job to release the next version
    steps:
      - name: Is Merged Pull Request
        uses: Benbentwo/is-merged-pull-request@master
        id: is-merged
        with:
          dump: 'true'

      - name: Check if Merged
        if: ${{steps.is-merged-outputs.isMerged}}
        run: |
          echo this is a merge

      - name: If Not Merged
#        I'm leaving this commented as I always want to dump.
#        if: ${{steps.is-merged-outputs.isMerged}} == 'false'
        run: |
          echo "Dumping output of json"
          echo ${{steps.is-merged-outputs.dump}} | jq
```
