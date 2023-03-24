unplugin-auto-import插件可以自动引入api
通过unplugin-auto-import实现自动导入,无需import即可在文件里使用Vue的API.

// 旧模式
import { computed, ref } from 'vue'
const count = ref(0)
const doubled = computed(() => count.value * 2)

// 使用unplugin-auto-import插件后可以省去import
const count = ref(0)
const doubled = computed(() => count.value * 2)



官网：
https://github.com/antfu/unplugin-auto-import



参考：
https://doc.houdunren.com/vue/5%20%E6%8F%92%E4%BB%B6%E6%89%A9%E5%B1%95.html#%E8%87%AA%E5%8A%A8%E5%BC%95%E5%85%A5api
https://blog.csdn.net/weixin_52020362/article/details/127841641

参考视频：
https://www.bilibili.com/video/BV1qu411174u/?spm_id_from=333.788
https://www.bilibili.com/video/BV15T4y1X7CL/?spm_id_from=333.788


