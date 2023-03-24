unplugin-vue-components时自动引入组件的插件

使用这个插件后,就没有必要先import组件,再注册组件才可以使用
//old
<template>
  <div>
    <HelloWorld msg="Hello Vue 3.0 + Vite" />
  </div>
</template>

<script>
import HelloWorld from './src/components/HelloWorld.vue'

export default {
  name: 'App',
  components: {
    HelloWorld
  }
}
</script>



//new 直接使用即可
<template>
  <div>
    <HelloWorld msg="Hello Vue 3.0 + Vite" />
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>



官网：
https://github.com/antfu/unplugin-vue-components

参考：
https://doc.houdunren.com/vue/5%20%E6%8F%92%E4%BB%B6%E6%89%A9%E5%B1%95.html#%E8%87%AA%E5%8A%A8%E5%8A%A0%E8%BD%BD%E7%BB%84%E4%BB%B6
https://zhuanlan.zhihu.com/p/427023137
https://blog.csdn.net/qq_47000934/article/details/121807701
https://www.codetd.com/en/article/13679688
参考视频：
https://www.bilibili.com/video/BV19a411k7tg/?spm_id_from=333.788


