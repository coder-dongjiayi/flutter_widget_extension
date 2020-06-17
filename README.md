#  运行环境

* ```Dart >= 2.5.0```

# 如何使用

给一张图片添加圆角，并且设置图片外边距也许你会这样写

```
 Widget _imageItem(imageUrl){
		retrun  Container(
      width: 206,
      margin: EdgeInsets.only(right: 10),
      child: AspectRatio(
          aspectRatio: 0.73,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              )
          ),
      ),
   	)
 }
```

但是当你使用 ``` flutter_widget_extension``` 你的代码会变成如下的样子

```
 Widget _imageItem(imageUrl){
 
			return  CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover,)
   					  .aspectRatio(aspectRatio: 0.73)
    					.circularAll(radius: 8)
    					.container(width: 206.w,margin: EdgeInsets.only(right: 10));
    }
```

能够如此优雅的解决层级嵌套问题 得益于``dart2.5.0``之后的 extension功能

# 特别注意！！接下里的事情很重要 一定要看！！

如果当前的```widget``` 对应的状态需要频繁的 ```build```  我建议谨慎使用 你要在你需要``build``的那个子``widget``中使用。 尽量避免在整个父``widget``使用 比如在你项目中如果使用了 ``provider`` 进行状态管理 你可能会这样写

```
Widget _imageItem(imageUrl){
    return Container(
      width: 206,
      margin: EdgeInsets.only(right: 10),
      child: AspectRatio(
          aspectRatio: 0.73,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              /// 这里的CachedNetworkImage 是你需要rebuild 这样并不会影响上面的 Container AspectRatio 和 ClipRRect
              child: Consumer<T>(
                builder: (context,state,_){
                  return CachedNetworkImage(
                    imageUrl: state.url,
                    fit: BoxFit.cover,
                  );
                },
              )
          ),
      ),
    );
  }

```

这里 你需要 rebuild  ``CachedNetworkImage`` 这个widget 而这次更新操作与 ``Container`` ``AspectRatio`` ``ClipRRect`` 无关 他们是不需要 rebuild的 但是如果你使用了 ``` flutter_widget_extension``` 也许你的代码会变成这个样子

```
Widget _imageItem(imageUrl){
  return  Consumer<T>(
    builder: (context,state,_){
      return CachedNetworkImage(imageUrl: state.url, fit: BoxFit.cover,)
          .aspectRatio(aspectRatio: 0.73)
          .circularAll(radius: 8)
          .container(width: 206.w,margin: EdgeInsets.only(right: 10));
    },
  );

}
```

 此时你要注意了 一旦你的widget 被Consumer 包裹 那么当状态改变的时候  ``Container`` ``AspectRatio``   ``ClipRRect``  都会被rebuild  一旦这样的代码多起来 对于性能有很大损耗，虽然flutter 官方宣传的是高性能，但是避免无关widget 的 rebuild 是高性能的前提。所以我建议你可以这样写

```
Widget _imageItem(imageUrl) {

    return Consumer<MyState>(
      builder: (context, state, _) {
        return GestureDetector(
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
          ),
        );
      },
    ).aspectRatio(aspectRatio: 0.73)
     .circularAll(radius: 8)
     .container(width: 206.w, margin: EdgeInsets.only(right: 10));
  }
}
```

这样写既不会做出无关的rebuild还可以达到想要的效果