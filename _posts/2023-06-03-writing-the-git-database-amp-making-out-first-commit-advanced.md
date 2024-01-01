---
layout: post
title:  "Writing the git database &amp; making out first commit! [Advanced]"
date:   "2023-06-03T20:34:19+00:00"
categories: youtube deepdive livestream
description: "In part 2 of re-implementing git from the ground up, I'm going to focus on: building the git database, writing the internal structs (objects, trees, blobs, commits, refs), continue working on git commit and implement commit chaining, make the first commit using our tool"
---
{% youtube  "https://www.youtube.com/watch?v=U691XdSmvzU" %}
{% include anchor-embed.html %}
<br />
In part 2 of re-implementing git from the ground up, I'm going to focus on:

- building the git database
- writing the internal structs (objects, trees, blobs, commits, refs)
- continue working on git commit and implement commit chaining
- make the first commit using our tool

git is a tool that is used by millions of developers every day, but it's also a tool that is often misunderstood. I want to help you understand how git works, and how you can use it more effectively.

▬▬▬▬▬▬ Resources &amp; References 📕 ▬▬▬▬▬▬

- Building git (James Coglan): [https://shop.jcoglan.com/building-git/](https://shop.jcoglan.com/building-git/)
- g source code (only available to my Patreon and Youtube members): [https://github.com/glich-stream/g](https://github.com/glich-stream/g)
- git lfs: [https://git-lfs.com/](https://git-lfs.com/)
- Playlist: [https://www.youtube.com/playlist?list=PLArH6NjfKsUjkUZFJCHRLp7dneAY-U85L](https://www.youtube.com/playlist?list=PLArH6NjfKsUjkUZFJCHRLp7dneAY-U85L)

▬▬▬▬▬▬ Chapters 🕐  ▬▬▬▬▬▬

00:00:00 - Intro
00:08:09 - Recap from part 1
00:13:26 - Refactoring &amp; cleanup
00:21:45 - Creating a Makefile
00:26:11 - Creating objects interfaces &amp; structs
00:36:22 - Implementing the database storage
00:47:57 - Understanding Linux filemodes
00:55:10 - Writing objects on disk
01:07:23 - Creating &amp; storing Blobs
01:22:47 - Building the Tree &amp; Entry objects
01:29:25 - Tree serialisation
01:45:42 - Creating the Commit object
02:04:20 - Conclusion

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
