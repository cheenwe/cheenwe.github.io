---
layout: post
title: PostgreSQL Create View
tags: postgresql
category: postgresql
---

## 视图
>create view recent_announcements as select * from announcements order by id desc limit 10;
