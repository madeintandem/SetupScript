# Tandem laptop setup script

This script is meant for new delivery team members who are joining the Tandem
organization. It will install generally useful applications, as well as design
and development specific suggestions like language version managers and
packages, etc.

As consultants, we're regularly on different projects that have widely different
needs. Where one project requires Rails 6, ruby 2.4 and InVision for designers, another might need
Angular and the latest Node with Figma for design and handoffs. This script is meant to lay the
foundations of a flexible design & development environment that can accommodate different
requirements and adapt as needed.

---

## Requirements

This script is supported on--
* macOS Catalina (10.15)
* macOS Big Sur (10.16)
* Both intel and apple silicon architecture

If you encounter an issue using this script on those operating systems, let us
know.. or better yet, submit a pull request with how you accomplished it on your
machine!

---

## How to use this Script

### Automated Use

Open your mac's Terminal.app application, either through Spotlight search (⌘ +
space, then type "terminal" and press enter) or through your Application folder
in the subfolder labeled Utilities. Copy and paste this line of code and press
enter, it will download the script and associated files and start it running on
your machine.

*If you don't work for Tandem,* please read the script before you execute it.
Don't go around the internet running strangers' code in your terminal, it isn't
safe. We only use our powers for good, but not everyone does.

```bash
curl -s https://raw.githubusercontent.com/madeintandem/SetupScript/main/setup_script.sh | sh
```

### Manual Use

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

---

## What this will install

The script works in several steps, to accommodate the delivery disciplines at
Tandem. That being said, there is no restriction on installing the other
discipline's tools. We've added collaborative tools to the list that will
execute for all users, but you should absolutely feel free to run the entire
script!

### Shared Tooling

* Google Chrome
* Slack
* Rectangle
* 1Password
* Spotify
* Figma
* Alfred

### Design Tooling

* Adobe Creative Cloud

### Development Tooling

* VSCode
* iTerm2
* RVM - ruby version manager
  * install recent stable ruby version
  - ruby gems
    - bundler
    - rubocop
    - reek
    - solargraph
    - rails

* NVM - node version manager
  * install latest long term support version of node
* npm packages:
  * yarn
  * create-react-app
  * prettier
  * javascript-typescript-langserver
  * babel
  * eslint

### macOS settings configuration

Many macOS settings are not available through the UI, and many of the default
settings aren't chosen with professionals in mind. The script will interactively
take you through a series of questions related to these more esoteric macOS
settings (like always showing a file extension in Finder).

There is an option to say `yes` once and not get the settings interactively, but
we would advise you read through `macos_settings.sh` to understand what you're
getting yourself into before choosing that option.