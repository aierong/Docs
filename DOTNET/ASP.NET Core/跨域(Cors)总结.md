### 1.安装包

Microsoft.AspNetCore.Mvc.Cors

老版本需要安装,新版本不用



### 2.ConfigureServices方法中配置跨域

> appsettings.json文件中配置
>
> urls节点可以配置多个,每个结尾不要带/

```json
{ 
  "CorsData": {
    "name": "CorsPolicy",

    "urls": [

      "http://localhost:8366",
        
      "http://10.12.25.21:8366",
        
      "http://172.17.86.65:8366",

      "http://192.168.1.6:8338"

    ]
  }
}
```



```c#
//定义名称
string PolicyName = Configuration.GetSection( "CorsData:name" ).Get<string>();

//把配置的可跨域的站点取回来(就是那些前端站点域名,可以多个)
var urls = Configuration.GetSection( "CorsData:urls" ).Get<List<string>>();

//添加cors 服务 配置跨域处理            
services.AddCors( options => options.AddPolicy( PolicyName ,
 builder =>
 {
     //builder.WithOrigins( new string[] { "http://localhost:5555" } )
     //    .AllowAnyMethod()
     //    .AllowAnyHeader()
     //    .AllowCredentials();

     builder.WithOrigins( urls.ToArray() )
         .AllowAnyMethod()
         .AllowAnyHeader()
         .AllowCredentials();
 } ) );
```



```c#
// 如果不想配置前端站点信息,可以如下,利用SetIsOriginAllowed( _ => true )  这样任何站点都可以访问
builder.AllowAnyMethod()
    .SetIsOriginAllowed( _ => true )
    .AllowAnyHeader()
    .AllowCredentials();
```





### 3.Configure方法中开启中间件

```c#
//配置Cors
app.UseCors( PolicyName );
```



### 4.分组配置跨越规则

> 可以控制哪些控制器中哪些方法允许哪些站点跨越访问,哪些方法禁止跨域访问

某一些控制器进行跨域

```c#
[EnableCors("AllowSome")]
```



只对某一些方法进行跨域

```c#
[EnableCors("AllowSome")]
```



对某个Action限制跨域

```c#
[DisableCors]
```



参考：

https://www.cnblogs.com/onecodeonescript/p/6121009.html





### 5.参考

官网:
https://docs.microsoft.com/zh-cn/aspnet/core/security/cors?view=aspnetcore-3.1



参考:
https://www.cnblogs.com/linyijia/p/12981830.html
https://www.cnblogs.com/sjt072/p/11929084.html
https://www.cnblogs.com/stulzq/p/9392150.html
https://www.cnblogs.com/onecodeonescript/p/6121009.html   分组配置跨越规则
https://azrng.gitee.io/kbms/#/dotnetcore/kuayu 











