#### 方式1

> 推荐这个,这个会有一个向导

```javascript
npm init vue@latest
//下面这个也是一样的
npm create vue@3

//这个是创建vue2项目
npm create vue@2
```



#### 方式2

```javascript
使用 NPM:
npm create  vite@latest

使用 Yarn:
yarn create vite

使用 PNPM:
pnpm create vite

然后按照提示进行操作!(主要是填写项目名和选择vue模板)
```



#### 方式3

```javascript
创建项目并且同时指定模板  (特别注意:npm不同版本有不同命令,推荐使用方式1)
//创建一个项目my-vue-app,并且使用vue模版,同时会创建一个目录:my-vue-app
# npm 6.x
npm create  vite@latest my-vue-app --template vue
# npm 7+, 需要额外的双横线：
npm create  vite@latest my-vue-app -- --template vue


//创建一个项目myvue,并且使用vue-ts模版,同时会创建一个目录:myvue
# npm 6.x
npm create  vite@latest myvue --template vue-ts
# npm 7+, 需要额外的双横线：
npm create  vite@latest myvue -- --template vue-ts
```



#### 方式4

```javascript
在现有文件夹中创建项目(这种方式不创建新文件夹,上面的方式1,2都会产生新文件夹)
先创建一个空文件夹,然后在这个空文件夹中,再创建项目并且同时指定模板(安装过程中会要求填写项目名:填写和文件夹名称一样即可)
说明:.代表在当前文件夹创建项目 (特别说明:这个文件夹可以是空的(如果有文件会在创建项目的过程中自动删除掉))
npm create  vite@latest  . 
```





