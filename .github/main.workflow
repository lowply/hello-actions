workflow "New workflow" {
  on = "push"
  resolves = ["Deploy"]
}

action "Only Master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Build" {
  uses = "lowply/actions-hugo-firebase/build-hugo@master"
  needs = ["Only Master"]
  runs = "hugo"
}

action "Deploy" {
  uses = "lowply/actions-hugo-firebase/deploy-firebase@master"
  needs = ["Build"]
  secrets = ["FIREBASE_TOKEN"]
}
