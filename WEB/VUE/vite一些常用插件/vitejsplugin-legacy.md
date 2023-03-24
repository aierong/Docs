#### 简介

> 为打包后的文件提供传统浏览器兼容性支持



#### 安装

```javascript

# NPM
npm install @vitejs/plugin-legacy -D

# Yarn
yarn add @vitejs/plugin-legacy -D

# PNPM
pnpm install @vitejs/plugin-legacy -D

```



配置

```javascript
// vite.config.js
import legacy from '@vitejs/plugin-legacy'

export default {
  plugins: [
    legacy({
      targets: ['defaults', 'not IE 11']
    })
  ]
}
```



> 以 IE11以上（不兼容IE11） 为目标时，您还需要`regenerator-runtime`

```javascript
// vite.config.js
import legacy from '@vitejs/plugin-legacy'

export default {
  plugins: [
    legacy({
      targets: ['ie >= 11'],
      additionalLegacyPolyfills: ['regenerator-runtime/runtime']
    })
  ]
}
```



参考

https://github.com/vitejs/vite/tree/main/packages/plugin-legacy 

https://juejin.cn/post/7057146049990754341 











