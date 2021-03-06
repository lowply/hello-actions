workflow "New workflow" {
  on = "push"
  resolves = ["Deploy"]
}

action "Only Master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Build" {
  uses = "lowply/build-hugo@master"
  needs = ["Only Master"]
  runs = "hugo"
}

action "Deploy" {
  uses = "lowply/deploy-firebase@master"
  needs = ["Build"]
  secrets = ["FIREBASE_TOKEN"]
}
