# "Living Portfolio" by Nick Follett
## 📣 Contact
- [Linkedin](https://www.linkedin.com/in/nfollett89)
- nickfollett89@gmail.com

## ⚠️ Disclaimer
- This repository was created on June 22, 2024 and is very much a work in progress
- ➡️ [Current draft PR](https://github.com/NFollett89/live-portfolio/pull/4)
- I will remove/modify this disclaimer after cutting a Release following the first 'Major' milestone, e.g. some layered infra serving traffic beyond "Hello, World!"

## 🎯 Goals
- Demonstrate a cross-section of my project experience and interests
- Create some reusable artifacts
- Reinforce known and learn new best practices and technologies
- Fill out an otherwise sparse GitHub Profile

## 📈 Feedback
You are welcome to give me public feedback via [Issues](https://github.com/NFollett89/live-portfolio/issues)! 😁
(The template is completely [optional](https://github.com/NFollett89/live-portfolio/issues/2))

## 🚀 Milestones
- [x] (June 22, '24) Create the repository, set up branch protections, squash merge, and other configs
- [x] Choose a [license](LICENSE) and automate its usage ([Makefile](https://github.com/NFollett89/live-portfolio/blob/main/Makefile#L5))
- [x] Bootstrap a new Google Cloud account in preparation for Terraform (https://github.com/NFollett89/live-portfolio/pull/1)
- [ ] Set up a Cloud Function, or alternative, to automatically disable the Billing Account when $300 has been spent
- [ ] Create some simple, yet opinionated modules for "Cloud Foundations", and deploy examples of them
  - [ ] Org Policies
  - [ ] Folders
  - [ ] IAM
  - [ ] Networking
- [ ] Create and deploy modules in support of hosting my resumé on various platforms
  - [ ] Google Cloud Storage (Static)
  - [ ] Google Cloud Function (Dynamic-capable, "Serverless")
  - [ ] Google Compute Engine with web server
  - [ ] Google Kubernetes Engine
- [ ] Make a decision on how to automate Terraform
  - A. Cloud Run
  - B. GitHub Actions
  - C. Misc. custom pipeline
  - D. Just run it locally, I'm one person and have other stuff to do!
- [ ] Add AWS 
- [ ] Plan more things!

## 💡 Ideas for later...
- [ ] Pull Spotify tracks from Git history and create a playlist
    - Any line of a commit message may be `[Music] TITLE, ARTIST, SPOTIFY_TRACK_URL`
    - Use `make music` to do this with a prompt!
