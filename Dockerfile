FROM bitnami/git:latest

LABEL "com.github.actions.name"="Is Merged Pull Request"
LABEL "com.github.actions.description"="Sets an output variable `isMerged` to true if the commit fired from a push event is from a merged pull request"
LABEL "com.github.actions.icon"="git-merge"
LABEL "com.github.actions.color"="grey-dark"

LABEL "repository"="https://github.com/Benbentwo/is-merged-pull-request"
LABEL "homepage"="https://github.com/Benbentwo/is-merged-pull-request"

RUN apt update -y && apt-get install jq -y

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
