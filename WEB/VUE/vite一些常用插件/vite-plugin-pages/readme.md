#### 1.安装

```javascript
npm install -D vite-plugin-pages
npm install vue-router
```



#### 2.配置

> vite.config.js文件

```javascript
import Pages from 'vite-plugin-pages'

export default {
  plugins: [
    //只要把待生成的路由页面放到src/pages，基本不用配置其它参数
    Pages(  ),
  ],
}
```



#### 3.启动配置

> main.ts

```javascript
import { createRouter } from 'vue-router'
import routes from '~pages'

const router = createRouter({
  // ...
  routes,
})
```



#### 4.配置参数说明

##### dirs指定自动生成路由的路径

> 默认:src/pages

```javascript
// vite.config.js
import Pages from 'vite-plugin-pages'

export default {
  plugins: [
    Pages({
      dirs: 'src/pages',
    }),
  ],
}
```



##### extensions需要包含的文件类型

> 默认:['vue', 'ts', 'js']

```
// vite.config.js
import Pages from 'vite-plugin-pages'

export default {
  plugins: [
    Pages({
      extensions: ['vue', 'ts', 'js']
    }),
  ],
}
```



##### exclude排除某些页面

```javascript
// vite.config.js
export default {
  plugins: [
    Pages({
      exclude: ['**/components/*.vue'],
    }),
  ],
}
```





