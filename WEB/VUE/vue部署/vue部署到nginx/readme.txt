1.vue打包好的dist目录,copy到nginx的html



2.修改配置文件:nginx.conf
server节点下,location节点下,root指向你的dist目录即可



3.部署多个vue
就是把server节点copy一份出来,改一下listen端口和root指向你的dist目录即可



4.如果刷新会报错,请增加配置:try_files $uri $uri/ /index.html;
例如:
location / {
		
    try_files $uri $uri/ /index.html;
}



5.禁用缓存
location / {
    add_header Cache-Control 'private, no-store, max-age=0';
	
    ...
}



参考:
https://zhuanlan.zhihu.com/p/88603137


