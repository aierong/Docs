### 1.方式1

> 通过location.reload和$router.go(0)方法

> 优点:足够简单
> 缺点:会出现页面空白,用户体验不好

```html
<button @click="onClick">刷新</button>
```

```javascript
import { useRoute , useRouter } from "vue-router";

const router = useRouter()


function onClick () {
    console.log('onclick');

    //    location.reload();
    router.go(0);

    return;
}
```



### 2.方式2

> 通过一个空白页过渡

> 优点:不会出现页面空白,用户体验好
> 缺点:地址栏会出现快速切换的过程

建一个空白页,BlankPage.vue

```javascript
import { useRoute , useRouter } from "vue-router";

const router = useRouter()
const route = useRoute()

onMounted( () => {
    console.log( 'onMounted 空白页' )

    let url = route.query.redirect;
    console.log( 'onMounted 空白页 redirect' , url )
    router.replace( url )
} )
```



```html
<button @click="onClick">刷新</button>
```

```javascript
import { useRoute , useRouter } from "vue-router";

const router = useRouter()
const route = useRoute()


function onClick () {
    console.log( 'onclick' );

    //使用replace跳转后不会留下 history 记录,并通过redirect传递当前页面的路径
    router.replace( `/BlankPage?redirect=${ route.fullPath }` )

    return;    
}
```



### 3.参考

https://juejin.cn/post/7188103333440127037?share_token=4935d64f-c99b-4ac1-9826-7ea71b99cb49

