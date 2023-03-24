#### 1.前提条件

> vue3.2才支持script setup语法糖



#### 2.声明

> 将 setup attribute 添加到 <script> 代码块

```vue
<script setup lang="ts">   
    
</script>
```



#### 3.顶层的绑定会被暴露给模板

##### 3.1:变量,ref,reactive数据,计算属性,方法,事件无需return

> 注意：ref 值在模板中使用的时候是自动解包，无需.value

```vue
<script setup
        lang="ts">
interface DataObj {
    lists : number[];
    name : string;
    age : number;
}

// 导入
import {
    ref ,
    reactive ,
    toRefs ,
    computed ,
    onMounted ,
} from "vue";
import type { Ref } from 'vue'
    
// 变量
const msg : string = 'Hello!'

//ref定义后，无需return
//ref 值在模板中使用的时候是自动解包，无需.value
const age = ref<number>( 7 )
//这样也是可以的
const agenew : Ref<number> = ref( 7 )
    
//自定义事件定义后,无需return
const ageadd = () : void => {
    age.value++;

    maninfo.lists.push( 100 )
    maninfo.age++;
}

// reactive封装响应数据,无需return
const maninfo = reactive<DataObj>( {
    lists : [ 1 , 2 , 3 ] ,
    name : 'xiaoguo' ,
    age : 6 ,
} );
//这样也可以
const maninfonew : DataObj = reactive( {
    lists : [ 1 , 2 , 3 ] ,
    name : 'xiaoguo' ,
    age : 6 ,
} );
    
//计算属性,无需return
const lens = computed<number>( () => {
    if ( maninfo.lists != null ) {
        return maninfo.lists.length;
    }

    return 0;
} )

// 我们自己定义方法，无需return
const getstr = ( str : string ) : string => {
    return `${ str } qq`;
}

//生命周期函数，保持与之前一样使用
onMounted( () => {
    console.log( 'demodata.vue mounted!' )
} )

</script>
```



> import 导入的内容也会以同样的方式暴露给模板使用

```vue
<script setup>
import { capitalize } from './helpers'
</script>

<template>
  <div>{{ capitalize('hello') }}</div>
</template>
```



##### 3.2:组件引入即可

> 组件引入即可使用,无需注册

```vue
<script setup>
import MyComponent from './MyComponent.vue'
</script>

<template>
  <MyComponent />
</template>
```



#### 4.自定义指令

> 注意命名规范：***<u>==必须以 vNameOfDirective 的形式来命名自定义指令==</u>***

```vue
<template>
    <div>
        <fieldset>
            <legend>局部自定义指令</legend>

            <h2 v-rev-directive=""
                v-for="(item,index) in newslist"
                :key="index">{{ index + '.' + item }}</h2>
            <br>
            <h3 v-dir1-directive=""
                v-for="(item,index) in newslist"
                :key="index">{{ index + '.' + item }}</h3>
            <br>
            <h3 v-click-outside-directive=""
                v-for="(item,index) in newslist"
                :key="index">{{ index + '.' + item }}</h3>
            <br>
            <div>下面是局部指令：</div>
            <h3 v-my-directive=""
                v-for="(item,index) in newslist"
                :key="index">{{ index + '.' + item }}</h3>
            <br>
        </fieldset>
    </div>

</template>

<!-- js脚本代码片段 -->
<script setup
        lang="ts">

// 导入
import {
    ref ,
    reactive ,
    toRefs ,
    computed
} from "vue";


//直接导入后,使用会出错,重命名一下
// import { rev , dir1 } from '@/dir/vdir.ts'

//重命名一下 v加大写
//必须以 vNameOfDirective 的形式来命名自定义指令
import {
    rev as vRevDirective ,
    dir1 as vDir1Directive ,
    // 重新命名 对应：v-click-outside
    //   vMyDir 对应：v-my-dir
    dir1 as vClickOutsideDirective ,
} from '@/dir/vdir.ts'

const newslist = ref<string[]>( [
    'voion新闻' ,
    '今天星期6,大家休息' ,
    '今日头条又来爆料' ,
    '双11又破记录'
] );


//这里是自己定义一个局部指令
//必须以 vNameOfDirective 的形式来命名自定义指令
const vMyDirective = {
    beforeMount : ( el ) => {
        // 在元素上做些操作
        el.style.color = "#" + Math.random().toString( 16 ).slice( 2 , 8 );
    }
}

</script>
```



#### 5.Props

> 利用defineProps声明props
>
> 注意：defineProps 和 defineEmits 都是只在 <script setup> 中才能使用的编译器宏。他们不需要导入的
>
> 
>
> 可以用2种方式声明：
>
> 1.运行时声明
>
> 2.类型声明



##### 方式1：运行时声明

运行时声明的方式,有一个优势就是可以对参数值进行验证(写validator)

个人也推荐使用这样方式定义props

```vue
<script setup lang="ts">

// 导入
import {
    PropType ,
    ref ,
    reactive ,
    toRefs ,
    computed
} from "vue";

import { ComplexMessage } from '@cp/props/types/index.ts'

// 定义字面量类型
type bttype = 'primary' | 'success' | 'warning' | 'info' | 'danger' | 'default';
    
// 声明 props
const props = defineProps( {
    // 带有默认值的数字
    num : {
        type : Number ,
        default : 100 ,
    } ,
    title : {
        type : String ,
        default : ''
    } ,
    // 带有默认值的对象
    objval : {
        type : Object as PropType<ComplexMessage> ,
        // 对象或数组默认值必须从一个工厂函数获取
        default : function () {
            return {
                msg : 'hello' ,
                isok : false
            }
        }
    } ,
    // 数组
    arrlist : {
        type : Array as PropType<number[]> ,
        // 对象或数组默认值必须从一个工厂函数获取
        default : function () {
            return [ 1 , 2 , 3 ];
        }
    } ,
        
    types : {
        type : String as PropType<bttype> ,
        default : 'default' ,
        // 这里对参数值做了验证
        validator : ( val : string ) : boolean => {
            return [ 'default' , 'primary' , 'success' , 'warning' , 'info' , 'danger' ].includes( val )
        } ,
    }    
} )


</script>
```



##### 方式2：类型声明

```vue
<script setup
        lang="ts">

// 导入
import {
    PropType ,
    ref ,
    reactive ,
    toRefs ,
    computed
} from "vue";    

// defineProps的新写法:可以直接使用ts的类型定义 ?表示可以为空
const props = defineProps<{
    foo : string
    bar? : number
}>()

const txts = computed( () => {
    if ( props.bar != null && props.bar != undefined ) {
        return props.bar.toString();
    }

    return '父组件没有传递值';
} )

</script>
```



下面是提供默认值版本

```vue
<script setup
        lang="ts">

// 导入
import {
    ref ,
    reactive ,
    toRefs ,
    computed
} from "vue";


interface IProps {
    msg? : string
    labels? : number[]
}

//withDefaults 辅助函数提供了对默认值的类型检查
const props = withDefaults( defineProps<IProps>() , {
    msg : 'hello' ,
    labels : () => [ 6.3 , 3 , 2.8 , 1.5 ]
} )


</script>
```



#### 6.emit

> 利用defineEmits声明emit
>
> 注意：defineProps 和 defineEmits 都是只在 <script setup> 中才能使用的编译器宏。他们不需要导入的
>
> 
>
> 可以用2种方式声明：
>
> 1.运行时声明
>
> 2.类型声明



##### 方式1：运行时声明

运行时声明的方式,有一个优势就是可以对参数值进行验证(写js判断语句)

个人也推荐使用这样方式定义emit



###### 简单版本

```javascript
const emit = defineEmits( [ 'click' , 'submit' , 'open' ] )
```



###### 带验证功能版本

```javascript
<script setup
        lang="ts">

import { Ipayload } from '@cp/emits/types'

// 导入
import {
    ref ,
    reactive ,
    toRefs ,
    computed ,
    //defineEmits使用不需要导入 defineProps和defineEmits是编译器宏，只能在<script setup>中使用。 它们不需要被导入
    //defineEmits
} from "vue";

// 第一种方式: 直接定义一个数组,把名字写上即可
// const emit = defineEmits( [ 'click' , 'submit' , 'open' ] )

// 第2种方式: 带验证的
const emit = defineEmits( {
    click : null ,
    submit : ( val : Ipayload ) => {

        if ( val.num < 0 ) {  //这样判断 输入范围
            // if ( num < 0 ) {
            console.warn( 'num请大于0!' )

            return false
        }

        return true
    } ,
    // 验证open事件
    open : ( value : string ) => {
        //上面已经定义了参数类型,系统会验证的参数类型

        return true
    } ,
} )

const dj = ( event : any ) => {
    console.log( '单击了组件中按钮' , event )

    // 这里派发一个事件click
    emit( "click" , event )
}

const tijiao = () => {

    // 下面这个也是错误的,因为num为负数
    // let data = {
    //     password : '123456' ,
    //     email : '1142@qq.com' ,
    //     num : -1
    // }

    let payload : Ipayload = {
        password : "123456" ,
        email : '1142@qq.com' ,
        num : 123.12
    }

    emit( 'submit' , payload )
}

const openwin = ( event : any ) => {
    // emit( "open" , event )
    //emit( "open" , 123 )

    // 上面都是错误的,因为验证代码要求是传递一个字符串
    //当校验函数不通过的时候，控制台会输出一个警告，但是emit事件会继续执行
    emit( "open" , "guoguo" )
}

</script>
```



##### 方式2：类型声明

```javascript
<script setup
        lang="ts">

// 导入
import {
    defineComponent ,
    ref ,
    reactive ,
    toRefs ,
    computed
} from "vue";

import { Ipayload } from '@cp/emits/types'

//类型声明emit
// 第一个参数：emit名字 第2个参数：要传递参数的数据类型
// 这里直接使用ts的数据类型定义参数类型
const emit = defineEmits<{
    ( e : 'submit' , val : Ipayload ) : void
    ( e : 'open' , value : string ) : void
}>()

const tijiao = () => {

    let payload : Ipayload = {
        password : "123456" ,
        email : '1142@qq.com' ,
        num : 123.12
    }

    emit( 'submit' , payload )
}

const openwin = ( event : any ) => {
    // emit( "open" , event )
    //emit( "open" , 123 )

    // 上面都是错误的,因为验证代码要求是传递一个字符串
    // 当校验函数不通过的时候，控制台会输出一个警告，但是emit事件会继续执行
    emit( "open" , "guoguo" )
}


</script>
```



#### 7.defineExpose(暴露数据或者方法)

> 通过defineExpose暴露数据或者方法
>
> 注意：defineExpose 都是只在 <script setup> 中才能使用的编译器宏。他们不需要导入的

```javascript
<script setup
        lang="ts">

// 导入
import {
    ref ,
    reactive ,
    toRefs ,
    computed ,
    //defineExpose不需要导入 defineExpose是编译器宏，  不需要被导入
    // defineExpose
} from "vue";

//  定义响应式的数据
const count = ref( 0 )

const countnew = ref( 1 )

const modeldata = reactive( {
    width : 120 ,
    height : 40 ,
    imgCode : ''
} )

function dj () {
    // console.log( 'dj' )

    count.value = count.value + 1;
    countnew.value = countnew.value + 1;

    modeldata.width = modeldata.width + 100;
}

// 把值或者方法暴露给父组件使用
defineExpose( {
    //把2个值暴露给父组件使用
    count ,
    modeldata ,
    //把方法暴露给父组件使用
    dj
} );
```



#### 8.useSlots

> useSlots可以获取插槽相关信息

子组件：

```javascript
<template>

    <div>
        <h1>头部</h1>
        <slot name="header"></slot>
        <br>
        <slot></slot>
        <br>
        <h1>尾部</h1>
        <slot name="footer"></slot>

    </div>

</template>

<!-- TypeScript脚本代码片段 -->
<script lang="ts"
        setup>

// 导入
import {
    defineComponent ,
    ref ,
    reactive ,
    toRefs ,
    computed ,
    useSlots , onMounted
} from "vue";

const slots = useSlots()

onMounted( () => {
    if ( slots.header ) {
        console.log( slots.header() )
    }

    if ( slots.footer ) {
        console.log( slots.footer() )
    }

    if ( slots.default ) {
        console.log( slots.default() )
    }

} )

</script>
```

父组件

```javascript
<template>
    <div>
        <slot1>
            <template #header>
                <div>头部数据</div>
            </template>
            <span style="color: blue;font-size: xxx-large;">中间数据</span>
            <template #footer>
                <div>尾部数据</div>
            </template>
        </slot1>
    </div>
</template>
```



#### 9.与普通的script一起使用

> 单独定义一个<script>可以声明一些其他属性

```javascript
<script>
// 普通 <script>, 在模块范围下执行(只执行一次)
runSideEffectOnce()

// 声明额外的选项
export default {
  inheritAttrs: false,
  customOptions: {}
}
</script>

<script setup>
// 在 setup() 作用域中执行 (对每个实例皆如此)
</script>
```



#### 10.官网参考：

https://v3.cn.vuejs.org/api/sfc-script-setup.html 







