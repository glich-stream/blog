---
layout: post
title:  "GitHub Actions: Dive into actions-runner-controller (ARC) || Advanced installation &amp; configuration"
date:   "2023-07-14T11:36:47+00:00"
categories: youtube deepdive
description: 'Actions Runner Controller (ARC) is a Kubernetes operator that orchestrates and scales self-hosted runners for GitHub Actions. With ARC, you can create runner scale sets that automatically scale based on the number of workflows running in your repository, organization, or enterprise.'
---
{% youtube  "https://www.youtube.com/watch?v=_F5ocPrv6io" %}
{% include anchor-embed.html %}
<br />
Actions Runner Controller (ARC) is a Kubernetes operator that orchestrates and scales self-hosted runners for GitHub Actions. With ARC, you can create runner scale sets that automatically scale based on the number of workflows running in your repository, organization, or enterprise.

This video is a deep dive into the different components of ARC, the design decisions, the helm chart configurations and everything you need to know to successfully use it.

▬▬▬▬▬▬ Resources &amp; References 📕 ▬▬▬▬▬▬

- ARC documentation: [https://gh.io/arc-docs](https://gh.io/arc-docs)
- ARC repository: [https://github.com/actions/actions-runner-controller](https://github.com/actions/actions-runner-controller)

▬▬▬▬▬▬ Chapters 🕐  ▬▬▬▬▬▬

00:00:00 - Intro 
00:01:01 - Brief history 
00:01:55 - Docs walkthrough &amp; design decisions 
00:08:10 - Architecture overview 
00:09:54 - What are runner scale sets? 
00:15:20 - Controller manager &amp; listener 
00:24:33 - The ARC repository structure 
00:25:19 - GitHub support vs community support 
00:27:51 - Legacy runner images 
00:31:58 - ARC releases (artifacts &amp; packages) 
00:33:17 - The helm charts packages 
00:35:05 - Why 2 helm charts? 
00:36:46 - Legacy ARC packages 
00:39:54 - ARC pre-requisites setup 
00:48:29 - Controller-manager configuration options 
01:02:54 - Installing the controller-manager 
01:07:37 - Installing a runner scale set 
01:08:36 - Link to GitHub Actions App setup 
01:10:14 - Creating a GitHub App Kubernetes secret 
01:12:57 - HTTP proxy configuration 
01:16:18 - Min-max boundaries 
01:18:40 - Runner scale set name override 
01:19:58 - Custom CA self-signed certificates 
01:29:04 - Understanding containerMode 
01:33:45 - Configuring Docker in Docker (DinD) container mode 
01:36:57 - Installing a runner scale set (DinD mode) 
01:43:31 - Docker in Docker (Dind) simple workflow demo 
01:46:47 - DinD with service container demo 
01:50:08 - Kubernetes container mode 
01:58:00 - Troubleshooting a failed installation 
01:59:59 - Kubernetes mode  demo with service container 

▬▬▬▬▬▬ Connect with me 👋 ▬▬▬▬▬▬

- Twitter: [https://twitter.com/bassemdy](https://twitter.com/bassemdy)
- GitHub: [https://github.com/link-](https://github.com/link-)
- LinkedIn: [https://www.linkedin.com/in/bassemdghaidy](https://www.linkedin.com/in/bassemdghaidy)
- Facebook: [https://www.facebook.com/BassemDy](https://www.facebook.com/BassemDy)
- Blog: [https://blog.bassemdy.com](https://blog.bassemdy.com)

▬▬▬▬▬▬ Support the channel 💜 ▬▬▬▬▬▬

Every little bit helps ✨
- Become a member of the channel: [https://glich.stream/yt_members](https://glich.stream/yt_members)
- Get access to Patreon exclusive perks: [https://glich.stream/patreon](https://glich.stream/patreon)
- 1 time support: [https://glich.stream/coffee_shop](https://glich.stream/coffee_shop)

#glichstream #softwareengineering #programming #coding
