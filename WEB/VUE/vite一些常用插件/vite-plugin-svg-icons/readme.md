### 1.安装

```javascript
npm i vite-plugin-svg-icons -D

//特别说明：如果碰到报fast-glob错误,请安装：npm install   fast-glob
// https://github.com/vbenjs/vite-plugin-svg-icons/issues
```



### 2.配置

配置vite.config.ts文件

```javascript
import { createSvgIconsPlugin } from 'vite-plugin-svg-icons'
import { resolve } from 'path'

export default defineConfig( {
    plugins : [
        vue() ,

        createSvgIconsPlugin( {
            // 这里配置的是svg文件的存放路径
            iconDirs : [ resolve( process.cwd() , 'src/assets/icons/svg' ) ] ,

            // default
            symbolId : 'icon-[dir]-[name]' ,
        } ) ,
    ] 

} )
```



### 3.ts支持

```javascript
// tsconfig.json
{
  "compilerOptions": {
    "types": ["vite-plugin-svg-icons/client"]
  }
}
```



### 4.引入

main.ts文件引入

```javascript
import 'virtual:svg-icons-register'
```





### 5.使用

> assets目录下存放svg文件

```javascript
<svg aria-hidden="true"
     class="icon-svg1">
    <!--
    命名方式：#icon-是前缀,car是svg的文件名
    -->
    <use xlink:href="#icon-car"/>
</svg>

<svg aria-hidden="true"
     class="icon-svg2">
    <!--
    由于cart.svg文件在2ji目录下,所以中间得写上路径名2ji
    -->
    <use xlink:href="#icon-2ji-cart"/>
</svg>


<style scoped>
.icon-svg1 {
    width: 32px;
    height: 32px;
    /*fill控制颜色*/
    fill: greenyellow;
    overflow: hidden;
}

.icon-svg2 {
    width: 16px;
    height: 16px;
}
</style>
```



















