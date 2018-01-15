---
layout: post
title: PostgreSQL Create View
tags: postgresql 创建视图
category: postgresql
---

## 视图
>create view recent_announcements as select * from announcements order by id desc limit 10;
