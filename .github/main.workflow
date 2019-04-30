workflow "Build and Publish" {
  on = "push"
  resolves = ["Publish"]
}

action "Build" {
  uses = "ianwalter/puppeteer@master"
  args = "install"
}

action "Test" {
  needs = ["Build"]
  uses = "ianwalter/puppeteer@master"
  args = "test"
}

action "Publish Filter" {
  needs = ["Test"]
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Publish" {
  needs = "Publish Filter"
  uses = "mikeal/merge-release@master"
  secrets = ["GITHUB_TOKEN", "NPM_AUTH_TOKEN"]
}
