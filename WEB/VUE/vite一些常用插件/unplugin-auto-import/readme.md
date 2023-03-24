#### 1.安装

```javascript
npm i -D unplugin-auto-import
```



#### 2.配置

```javascript
// vite.config.ts
import AutoImport from 'unplugin-auto-import/vite'

export default defineConfig({
  plugins: [
    AutoImport({ /* options */ }),
  ],
})
```



#### 3.配置项

##### 指定自动导入项

```javascript
    AutoImport({
      imports: [
        'vue',
        'vue/macros',
        'vue-router',
        '@vueuse/core',
      ]
    }),
```



##### ts相关

```javascript
AutoImport({
  dts: true // or a custom path
})

或者
dts: './auto-imports.d.ts',
```



#### 4.同名问题

> 如果碰到不同文件夹中同名js,可以通过手动引入解决.(还是可以通过手动引入import使用的)







