---
layout: post
title: Git commit message 规范
tags: git
categories: git
---


# Git commit message 规范
参考 [AngularJS](https://github.com/angular/angular/pulls)

## Commit message 的作用
格式化的Commit message，有几个好处。

###  提供更多的历史信息，方便快速浏览。
比如，下面的命令显示上次发布后的变动，每个commit占据一行。你只看行首，就知道某次 commit 的目的。

```
git log   HEAD --pretty=format:%s

git log --pretty=format:"%h - %an, %ar : %
```

### 可以过滤某些commit（比如文档改动），便于快速查找信息。

比如，下面的命令仅仅显示本次发布新增加的功能。

$ git log <last release> HEAD --grep feature

### 可以直接从commit生成Change log。

Change Log 是发布新版本时, 用来说明与上一个版本差异的文档.


## Commit message 格式

```
<type>(<scope>): <subject>
<空行>
<body>
<空行>
<footer>
```

上面是一次Commit后Message格式规范，分成标题，内容详情，结尾三个部分，各有各的用处，没有多余项。

头部即首行，是可以直接在页面中预览的部分，入上面图中所示，一共有三个部分<type>，<scope>，<subject>，含义分别如下

**Type**

- feat：新功能（feature）

- fix：修补bug

- docs：文档（documentation）

- style： 不影响功能的代码变化（空格，格式化，丢失分号等）

- refactor：重构（即不是新增功能，也不是修改bug的代码变动）

- test：增加测试

- chore：构建过程或辅助工具的变动

**Scope**
用来说明本次Commit影响的范围，即简要说明修改会涉及的部分。这个本来是选填项，但从AngularJS实际项目中可以看出基本上也成了必填项了。

**Subject**
用来简要描述本次改动，概述就好了，因为后面还会在Body里给出具体信息。并且最好遵循下面三条:

以动词开头，使用第一人称现在时，比如change，而不是changed或changes
首字母不要大写
结尾不用句号(.)。

**Body**
body 里的内容是对上面subject里内容的展开，在此做更加详尽的描述，内容里应该包含修改动机和修改前后的对比。

**Footer**
footer里的主要放置不兼容变更和Issue关闭的信息
>Closes #23

也可以一次关闭多个 issue
>Closes #56, #25, #95

**Revert**
此外如果需要撤销之前的Commit，那么本次Commit Message中必须以revert：开头，后面紧跟前面描述的Header部分，格式不变。并且，Body部分的格式也是固定的，必须要记录撤销前Commit的SHA值。

## 使用Commitizen

### 安装

为了让我们能把这些规范应用到实际使用中，我们要借助于Commitizen这个Node工具，它会在我们Commit的过程中更具规范的内容来引导我们如何一步一步实施规范。当然，规范这种东西就没有唯一的，各家有各家的不同，这一点当然也被该工具想到了，你也可以自定义一份自己的规范，以插件的形式让Commitizen来根据自家规范提醒你。

>npm install -g commitizen

## 配置
上一步我们在全局范围内安装了commitizen，之后我们就可以在Git仓库中配置我们的Commit规范了。打开项目执行如下命令:

>commitizen init cz-conventional-changelog --save --save-exact

上面的cz-conventional-changelog就是AngularJS的规范，其它的规范你可以自行到官网上找找看，不行就自己花时间拟定一份吧。此命令帮你完成了下载cz-conventional-changelog规范，配置package.json(添加依赖和配置应用规范)，想看具体改动打开package.json即可。

## 使用
以后，凡是用到git commit命令，一律改为使用
>git cz
这时，就会出现选项，用来生成符合格式的 Commit message。

## 附

>node_modules/cz-conventional-changelog/index.js

```

"format cjs";

var wrap = require('word-wrap');

// This can be any kind of SystemJS compatible module.
// We use Commonjs here, but ES6 or AMD would do just
// fine.
module.exports = {

  // When a user runs `git cz`, prompter will
  // be executed. We pass you cz, which currently
  // is just an instance of inquirer.js. Using
  // this you can ask questions and get answers.
  //
  // The commit callback should be executed when
  // you're ready to send back a commit template
  // to git.
  //
  // By default, we'll de-indent your commit
  // template and will keep empty lines.
  prompter: function(cz, commit) {
    console.log('\nLine 1 will be cropped at 100 characters. All other lines will be wrapped after 100 characters.\n');

    // Let's ask some questions of the user
    // so that we can populate our commit
    // template.
    //
    // See inquirer.js docs for specifics.
    // You can also opt to use another input
    // collection library if you prefer.
    cz.prompt([
      {
        type: 'list',
        name: 'type',
        message: '选择您正在提交的内容:',
        choices: [
        {
          name: '新功能:    新功能添加',
          value: 'feat'
        }, {
          name: '修补bug:    bug修复',
          value: 'fix'
        }, {
          name: '文档:    文档添加及修改',
          value: 'docs'
        }, {
          name: '格式:    不影响功能的代码变化（空格，格式化，丢失分号等）',
          value: 'style'
        }, {
          name: '重构:    代码重构',
          value: 'refactor'
        }, {
          name: '优化:    提高性能的代码更改',
          value: 'perf'
        }, {
          name: '测试:    添加测试代码，或功能测试代码添加',
          value: 'test'
        }, {
          name: '辅助:    改变构建过程或辅助工具和库，如文档生成',
          value: 'chore'

        }]
      }, {
        type: 'input',
        name: 'scope',
        message: '用来说明本次Commit影响的范围，即简要说明修改会涉及的部分。:\n'
      }, {
        type: 'input',
        name: 'subject',
        message: '用来简要描述本次改动，概述就好了，因为后面还会在Body里给出具体信息:\n'
      }, {
        type: 'input',
        name: 'body',
        message: '对上面subject里内容的展开，在此做更加详尽的描述，内容里应该包含修改动机和修改前后的对比:\n'
      }, {
        type: 'input',
        name: 'footer',
        message: '不兼容变更和Issue关闭的信息:\n,如:  Closes #56, #25'
      }
    ]).then(function(answers) {

      var maxLineWidth = 100;

      var wrapOptions = {
        trim: true,
        newline: '\n',
        indent:'',
        width: maxLineWidth
      };

      // parentheses are only needed when a scope is present
      var scope = answers.scope.trim();
      scope = scope ? '(' + answers.scope.trim() + ')' : '';

      // Hard limit this line
      var head = (answers.type + scope + ': ' + answers.subject.trim()).slice(0, maxLineWidth);

      // Wrap these lines at 100 characters
      var body = wrap(answers.body, wrapOptions);
      var footer = wrap(answers.footer, wrapOptions);

      commit(head + '\n\n' + body + '\n\n' + footer);
    });
  }
}

```