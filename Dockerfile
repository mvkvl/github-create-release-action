FROM alpine:3.9 as base

LABEL "com.github.actions.name"="github-action-release-create"
LABEL "com.github.actions.description"="Creates release for tag in repository"
LABEL "com.github.actions.icon"="settings"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"
LABEL repository="http://github.com/mvkvl/github-create-release-action"
LABEL homepage="http://github.com/mvkvl/github-create-release-action"

RUN apk add --no-cache jq curl

SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN curl -s https://api.github.com/repos/dahlia/submark/releases/latest |  jq -r '.assets[] | select(.browser_download_url | contains("linux-x86_64"))  | .browser_download_url' | xargs curl -o /usr/local/bin/submark -sSL &&  chmod +x /usr/local/bin/submark

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
