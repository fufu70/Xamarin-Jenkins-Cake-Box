# Xamarin-Jenkins-Cake-Box

Ever feel the need to turn on the [Code Analysis Oven](https://media.giphy.com/media/Z0lWsgfBeuv60/giphy.gif) and bake some Xamarin metrics, but all of those tools just [get in the way](https://media.giphy.com/media/eXvGYytlsnD32/giphy.gif)?  Welcome to the Jenkins [Dump Cake mix](https://media.giphy.com/media/AFTt9NqrWfKuY/giphy.gif), where all of your Analysis is at a one stop shop.

## Table Of Contents

* [The Requirements](#the-requirements)
* [The Process](#the-process)
* [Troubleshooting](#troubleshooting)
* [Thanks To](#thanks-to)

## The requirements

You thought that was a Download And Analyze (DAA) project, **but** you are mistaken! To run the Xamarin-Jenkins-Cake-Box we need to install dependencies:

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  * Make sure to download the latest version, even if you already installed VirtualBox before.
  * As of writing this my version (AOWTMV) is 5.1.14
* [Vagrant](https://www.vagrantup.com/downloads.html) ... not a [vagrant](https://media.giphy.com/media/U1Yp8zc6pSmRO/giphy.gif)
  * AOWTMV is 1.8.6
* [A PC](https://media.giphy.com/media/3uyIgVxP1qAjS/giphy.gif)

## The Process

Firstly we need to start up vagrant so that it can download the entire vagrant box. This may [take some time](https://media.giphy.com/media/xT1XGLSb5E1VjIUw4E/giphy.gif), so [grab a cup of coffee](https://media.giphy.com/media/i09ucikbPnhrq/giphy.gif)

```shell
$ vagrant up
```

After the Vagrant machine has started we need to [setup our mini mac kitchen](https://media.giphy.com/media/k8wY40SQmAtSU/giphy.gif)

```shell
$ vagrant ssh
$ bash install-jenkins/install.sh
```

This will install all of the necessary applications to run code analysis and automated builds for your Android Xamarin application.

AHHhhhhhhhhhhh! [The slowest installation possible!](https://media.giphy.com/media/3oriO7uXFQmIFiy5VK/giphy.gif)

Lets get to the jenkins box, go to [http://192.168.205.30:8080/](http://192.168.205.30:8080/) in your browser. A prompt should show for [unlocking jenkins](https://media.giphy.com/media/l2SpTFfL2KQvuE1pK/giphy.gif)

![alt text][unlock-jenkins]

Simply ssh into your machine and cat the prompted file:

```shell
$ vagrant ssh
$ sudo cat /Users/vagrant/.jenkins/secrets/initialAdminPassword
```

Copy and paste the password shown after the command is run into the **Administrator Password** input.

[Batter up!](https://media.giphy.com/media/WnjGBNT81NPe8/giphy.gif) Choose to **Install suggested plugins**.

![alt text][customize-jenkins]

A list of generalized plugins will start installing, including our favorite [git Source](https://media.giphy.com/media/upjxx2rkcnwxW/giphy.gif) Code Management tool

![alt text][plugins-installing-jenkins]

[Who do you want to be?](http://media.giphy.com/media/jsoMtBuP1Ahpu/giphy.gif) A Jenkins user thats who!

![alt text][admin-user-jenkins]

[The installation is now complete.](https://media.giphy.com/media/13HgwGsXF0aiGY/giphy.gif)

![alt text][installed-jenkins]

Now on to the terminal, but [its not so easy](https://media.giphy.com/media/RddAJiGxTPQFa/giphy.gif). Jenkins needs its **TCP port for JNLP** to be set to a fixed port before any CLI commands can be run. Go to [http://192.168.205.30:8080/configureSecurity/](http://192.168.205.30:8080/configureSecurity/) and set the **TCP port for JNLP agents** value to be **fixed** and to a random number ... [I picked 12345](https://media.giphy.com/media/xT0GqJfdLcrcpSbZf2/giphy.gif)

![alt text][tcp-port-for-jnlp]

[The lovey dovey terminal is back!](https://media.giphy.com/media/z9g6xLr5C0H1m/giphy.gif) And its here to install some plugins! So ssh into your machine and run that script!

```shell
$ vagrant ssh
$ bash install-jenkins/plugins.sh
```

[Nice!](https://media.giphy.com/media/3oEjI5VtIhHvK37WYo/giphy.gif) For the icing on the Xamarin-Jenkins-Cake-Box, lets add some integration with those plugins!

```shell
$ bash install-jenkins/integration.sh
```

When running this command you'll be given an option to input a personal repository. If N is selected then the repository URL can be changed from the config section of the jenkins job at http://192.168.205.30:8080/job/xamarin-cake-box-job/configure. The second option below is the Source Code Management config, here you can set a repository url and credentials:

![alt text][source-code-manager]

Your done now, all you need to do now is simply click the "Build Now" button in your xamarin-cake-box-job and analyze on!

## Troubleshooting

### Content Security Policy Issues

Okay my fellow [scrubs](http://i.giphy.com/YjJZKbm2kNN7i.gif)! You finally got your [first job to run](http://i.giphy.com/omRfGp0CeRShi.gif), you head over to your Gendarme html reportsat [http://192.168.205.30:8080/job/xamarin-cake-box-job/ws/gendarme.html](http://192.168.205.30:8080/job/xamarin-cake-box-job/ws/gendarme.html). [Whats this!](http://i.giphy.com/ToMjGpnXBTw7vnokxhu.gif)

![alt text][blocked-css-gendarme]

What are all these console errors!

![alt text][blocked-script-console-errors]

This is a direct issue with the [Content Security Policy](https://wiki.jenkins-ci.org/display/JENKINS/Configuring+Content+Security+Policy) issue. Were going to run a script inside of Jenkins internal console. Go to [http://192.168.205.30:8080/script](http://192.168.205.30:8080/script) and run:

```groovy
System.setProperty("hudson.model.DirectoryBrowserSupport.CSP", "")
```

Inside of the script console.

![alt text][script-console-execution]

After running the script go back to the Gendarme results page at [http://192.168.205.30:8080/job/xamarin-cake-box-job/ws/gendarme.html](http://192.168.205.30:8080/job/xamarin-cake-box-job/ws/gendarme.html), hard refresh the page to clear your current [cache](http://i.giphy.com/VkYOrBIQv520M.gif), and view the splendor of no Content Security!

![alt text][unblocked-css-gendarme]

## Thanks To

Andrew Dryga's [vagrant-osx-box](https://github.com/AndrewDryga/vagrant-box-osx)

The Xamarin Developer Guide for a [CI setup in Jenkins](https://developer.xamarin.com/guides/cross-platform/ci/jenkins_walkthrough/)

Nelson Senna's Code Sniffer [StyleCop.Baboon](https://github.com/nelsonsar/StyleCop.Baboon)

The MonoDevelop Teams 

[unlock-jenkins]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/unlock-jenkins.png "Unlock Jenkins"
[customize-jenkins]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/customize-jenkins.png "Customize Jenkins"
[plugins-installing-jenkins]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/plugins-installing-jenkins.png "Plugins Installing"
[admin-user-jenkins]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/admin-user-jenkins.png "Admin User Creation"
[installed-jenkins]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/installed-jenkins.png "Jenkins is installed"
[tcp-port-for-jnlp]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/tcp-port-for-jnlp.png "TCP port for JNLP"
[source-code-manager]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/source-code-manager.png "Source Code Manager"
[blocked-css-gendarme]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/blocked-css-gendarme.png "Blocked CSS Gendarme"
[blocked-script-console-errors]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/blocked-script-console-errors.png "Blocked Script Console Errors"
[script-console-execution]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/script-console-execution.png "Script Console Execution"
[unblocked-css-gendarme]: https://raw.githubusercontent.com/fufu70/Xamarin-Jenkins-Cake-Box/master/common/unblocked-css-gendarme.png "Unblocked CSS Gendarme"