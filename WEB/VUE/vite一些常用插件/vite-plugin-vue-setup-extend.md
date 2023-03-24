#### 简介

> setup name 增强插件
>
> Vue3的setup语法糖是个好东西，但使用setup语法带来的第一个问题就是无法自定义name，而我们使用keep-alive往往是需要name的，解决这个问题通常是通过写两个script标签来解决，一个使用setup，一个不使用，但这样必然是不够优雅的。



#### 安装

```javascript

# NPM
npm install vite-plugin-vue-setup-extend -D

# Yarn
yarn add vite-plugin-vue-setup-extend -D

# PNPM
pnpm install vite-plugin-vue-setup-extend -D

```



#### 配置

```javascript
import { defineConfig, Plugin } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueSetupExtend from 'vite-plugin-vue-setup-extend'

export default defineConfig({
  plugins: [vue(), vueSetupExtend()],
})
```



#### 使用

```javascript
<template>
  <div>hello world {{ a }}</div>
</template>

<script lang="ts" setup name="App">
  const a = 1
</script>
```



参考

> https://github.com/vbenjs/vite-plugin-vue-setup-extend 
>
> https://www.npmjs.com/package/vite-plugin-vue-setup-extend 
>
> https://juejin.cn/post/7057146049990754341 

