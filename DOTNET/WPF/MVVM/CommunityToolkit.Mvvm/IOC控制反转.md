#### 1.说明

> CommunityToolkit.Mvvm包不提供ioc功能,但是官方建议使用:Microsoft.Extensions.DependencyInjection使用IOC



#### 2.安装

> Microsoft.Extensions.DependencyInjection 包



#### 3.使用

##### 接口和服务定义

> 这个我们比较熟悉了,简单举例

```c#
public interface IBill
{
    bool IsExistId ( string name );

    string GetData ( string name );
}
```



```c#
public class BillService : IBill
{
    public string GetData ( string name )
    {
        return string.Format( "name:{0}" , name );
    }

    public bool IsExistId ( string name )
    {
        return name == "qq";
    }
}
```



##### App.xaml.cs注册

```c#
public partial class App : Application
{
    /// <summary>
    /// Gets the current <see cref="App"/> instance in use
    /// </summary>
    public new static App Current => ( App ) Application.Current;

    /// <summary>
    /// Gets the <see cref="IServiceProvider"/> instance to resolve application services.
    /// </summary>
    public IServiceProvider Services
    {
        get;
    }

    public App ()
    {
        Services = ConfigureServices();

        this.InitializeComponent();
    }

    private static IServiceProvider ConfigureServices ()
    {
        var services = new ServiceCollection();

        //   注册Services
        services.AddSingleton<IOCDemo.Service.Repository.IBill , IOCDemo.Service.Repository.BillService>();
        services.AddSingleton<IOCDemo.Service.Service.IBill , IOCDemo.Service.Service.BillService>();
        //services.AddSingleton<ISettingsService , SettingsService>();


        //  注册Viewmodels
        // 不是每个Viewmodels都得来AddTransient,如果Viewmodels不需要ioc,可以不用这里注册
        services.AddTransient<IOCDemo.ViewModels.WindowViewModel1>();

        return services.BuildServiceProvider();
    }
}
```



##### view中使用

```c#
public partial class Window1 : Window
{
    public Window1 ()
    {
        InitializeComponent();

        // this.DataContext = new WindowViewModel1(); 这样不可以使用了,请用App.Current.Services.GetService
        this.DataContext = App.Current.Services.GetService<WindowViewModel1>();  

        //代码任何处,都可以使用App.Current.Services.GetService获取到服务
        //IFilesService filesService = App.Current.Services.GetService<IFilesService>();
    }
}
```



##### viewmodel中使用

```c#
readonly Service.Service.IBill _IBill;

public WindowViewModel1 ( Service.Service.IBill iBill )
{
    this._IBill = iBill;
}

[RelayCommand( CanExecute = nameof( CanButton ) )]
void ButtonClick ()
{
    //点击按钮,修改标题

    if ( this._IBill.IsExistId( Title ) )
    {
        Title = "qq" + this._IBill.GetData( Title );
    }
    else
    {
        Title = "qq";
    }
}
```



##### 代码中获取服务的方式

```c#
this.DataContext = App.Current.Services.GetService<WindowViewModel1>();

//代码任何处,都可以使用App.Current.Services.GetService获取到服务
IFilesService filesService = App.Current.Services.GetService<IFilesService>();
```



#### 4.参考

https://learn.microsoft.com/zh-cn/dotnet/communitytoolkit/mvvm/ioc

https://blog.csdn.net/a549742320/article/details/126251625

https://www.cnblogs.com/taogeli/p/16046892.html

https://blog.csdn.net/BadAyase/article/details/125954336

