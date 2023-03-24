#### 1.发送数据

```c#
[RelayCommand()]
void ButtonClick ()
{
    //点击按钮,修改标题
    Name = "hello(Left改)";

    //Send发送消息
    WeakReferenceMessenger.Default.Send<string>( "qq1" );

    //第一个参数是发送的消息值,第2个参数是token,可以给接收方区分用的 推荐每次都带上token，方便接收方区分
    //WeakReferenceMessenger.Default.Send<string , string>( "UserControlLeftViewModel发来的qq1" , "token_1" );
    
     //特别注意:直接传递值,只可以是引用类型,值类型不可以编译成功的(例如:下面2句不行)
     //WeakReferenceMessenger.Default.Send<int , string>( 11 , "token_1" );
     //WeakReferenceMessenger.Default.Send<bool , string>( true  , "token_1" );
    
     //上面这样也是可以的，但是官方推荐用ValueChangedMessage封装数据传递
    WeakReferenceMessenger.Default.Send<ValueChangedMessage<string> , string>( new ValueChangedMessage<string> ( "UserControlLeftViewModel发来的qq1" ) , "token_1" );
      //下面2句,由于用ValueChangedMessage,所以bool,int类型数据都可以
     //WeakReferenceMessenger.Default.Send<ValueChangedMessage<bool> , string>( new ValueChangedMessage<bool>( true ) , "token_1" );
     //WeakReferenceMessenger.Default.Send<ValueChangedMessage<int> , string>( new ValueChangedMessage<int>( 123456 ) , "token_1" );

    
    
    //Send发送 一个复杂数据 
    var _data1 = new MyUserMessage() { Age = 18 , UserName = "qq" };
    //WeakReferenceMessenger.Default.Send<MyUserMessage , string>( _data1 , "token_class" );
    WeakReferenceMessenger.Default.Send<ValueChangedMessage<MyUserMessage> , string>( new ValueChangedMessage<MyUserMessage> ( _data1 ) , "token_class" );
    
    //result接收返回的值
    //MyMessage这个类必须继承RequestMessage
    var _data2 = new MyMessage() { Datas = "qqq" , Ids = 100 };
    var result = WeakReferenceMessenger.Default.Send<MyMessage , string>( _data2 , "token_Response" );
    if ( result != null )
    {
        //获取到 返回的值
        var val = result.Response;

        Name = val;
    }
}
```

```c#
public class MyUserMessage
{
    public string UserName
    {
        get; set;
    } 

    public int Age
    {
        get; set;
    }
}
```

```c#
/// <summary>
/// 必须继承RequestMessage  RequestMessage<string>代表返回数据的类型是string
/// </summary>
public class MyMessage : RequestMessage<string>
{
    public string Datas;

    public int Ids;
}
```



#### 2.接收数据

> 2种方式:
>
> 方式1.继承ObservableRecipient  
>
> 方式2.实现接口IRecipient
>
> 推荐使用方式1,方式2不太灵活,它只可以一个模型接收一个数据,并且无法实现token区分

##### 方式1:继承ObservableRecipient 

> viewmodel继承ObservableRecipient
>
> IsActive要等于true
>
> override方法OnActivated
>
> OnActivated方法中Messenger.Register接收数据

```c#
public partial class UserControlTopViewModel : ObservableRecipient
{
    [ObservableProperty]
    private string name = "hello";

    public UserControlTopViewModel ()
    {
        //注意这样要写,才可以接听
        IsActive = true;
    }

    protected override void OnActivated ()
    {
        //Register<>第一个类型一般是自己的类型,第2个是接收数据的类型
        //Register方法第1个参数一般是this,第2个参数是一个方法,可以获取接收到的值
        Messenger.Register<UserControlTopViewModel , string>( this , ( r , message ) =>
        {
            Name = Name + "  收到msg:" + message;
        } );

        //Register<>第一个类型一般是自己的类型,第2个是接收数据的类型,第3个是token数据的类型
        //Register方法第1个参数一般是this,第2个参数是token,第3个参数是一个方法,可以获取接收到的值
        //Messenger.Register<UserControlTopViewModel , string , string>( this , "token_1" , ( r , message ) =>
        //{
        //    Name = Name + "  收到msg:" + message;
        //} );
        Messenger.Register<UserControlTopViewModel , ValueChangedMessage<string> , string>( this , "token_1" , ( r , message ) =>
        {
            Name = Name + "  收到msg:" + message.Value;
        } );                  


        //Messenger.Register<UserControlTopViewModel , MyUserMessage , string>( this , "token_class" , ( r , user ) =>
        //{
        //    Name = Name + "  收到msg:" + user.UserName + user.Age;
        //} );
        Messenger.Register<UserControlTopViewModel , ValueChangedMessage<MyUserMessage> , string>( this , "token_class" , ( r , user ) =>
        {
                Name = Name + "  收到msg:" + user.Value.UserName + user.Value.Age;
        } );

        Messenger.Register<UserControlTopViewModel , MyMessage , string>( this , "token_Response" , ( r , message ) =>
        {
            Name = Name + "  收到msg:" + message.Datas;


            //Reply是答复 ,这样可以返回值
            message.Reply( "给你返回值" );

        } );
    }


    [RelayCommand()]
    void ButtonClick ()
    {
        //点击按钮,修改标题
        Name = "hello(Top改)";
    }
}
```





##### 方式2:实现接口IRecipient

> 实现接口IRecipient的方法Receive

```c#
public partial class UserControlTopViewModel : ObservableObject, IRecipient<string>
{
    [ObservableProperty]
    private string name = "hello";

    public UserControlTopViewModel ()
    {
        //注意这样要写,才可以接听
        IsActive = true;
    }


    /// <summary>
    /// 接收数据
    /// </summary>
    /// <param name="message"></param>
    public void Receive ( string message )
    {
        Name = Name + "  收到msg:" + message;
    }



    [RelayCommand()]
    void ButtonClick ()
    {
        //点击按钮,修改标题
        Name = "hello(Top改)";
    }
}
```





#### 3.参考

官网:

https://learn.microsoft.com/zh-cn/dotnet/communitytoolkit/mvvm/messenger

https://learn.microsoft.com/zh-cn/dotnet/communitytoolkit/mvvm/observablerecipient

使用参考:

https://www.cnblogs.com/AtTheMoment/p/15664022.html

https://blog.csdn.net/chenlinhsfl/article/details/122236194

https://blog.csdn.net/BadAyase/article/details/125116004



