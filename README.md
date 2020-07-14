### SwiftUI学习笔记：

demo截图

##### Memorize

![avatar](/Users/apple/Library/Application%20Support/marktext/images/038dd09ff262dc909c5586d22372117690e29702.png)

##### Calculator

![avatar](/Users/apple/Library/Application%20Support/marktext/images/45a2e7f5c1df6d5e1ae00b1c81acbc2533ea6749.png)



##### Text 的使用

```swift
Text("+")
 .font(.title) 
 .foregroundColor(.white)
 .padding()
 .background(Color.orange)
```

##### Button 的使用

```swift
Button(action: {            
  print("Button: +")
}) {
  Text("+")
    .font(.system(size: 38))
    .foregroundColor(.white)
    .frame(width: 88, height: 88)
    .background(Color("operatorBackground"))
    .cornerRadius(44)
}
```

在使用`modifiler`的时候要注意，先后顺序，比如 `.background`和`.cornerRadius`顺序颠倒后，渲染结果是不一样的，因为`SwiftUI`的渲染逻辑是按顺序渲染的。

##### Stack 容器

- 水平方向排列容器

```swift
HStack {
    ...
}
```

- 竖直方向排列容器

```swift
VStack(alignment:.trailing,spaceing: 12) {
    ...
}
```

`spaceing` 设置容器中的其他view之间的距离

`alignment`可以指定view的对齐方式

##### ForEach 遍历

```swift
var body: some View {
  HStack {
    ForEach(row, id: \.self)  item in
      CalculatorButton(
        title: item.title,
        size: item.size,
        backgroundColorName: item.backgroundColorName)
        {
          print("Button: \(item.title)")
        }
    }
  }
}
```

上面的代码可能无法编译，我们需要对此进行一些解释。ForEach 是 SwiftUI 中一个用来列举元素，并生成对应 View collection 的类型。它接受一个数组，且数组中的元素需要满足 Identifiable 协议。如果数组元素不满足 Identifiable，我们可以使用 ForEach(_:id:) 来通过某个支持 Hashable 的 key path 获取一个等效的元素是 Identifiable 的数组。在我们的例子中，数组 row 中的元素类型 CalculatorButtonItem 是不遵守 Identifiable 的。为了解决这个问题，我们可以为 CalculatorButtonItem 加上 Hashable，这样就可以直接用 ForEach(row, id: \.self) 的方式转换为可以接受的类型了。在 CalculatorButtonItem.swift 文件最后，加上一行：

```swift
extension CalculatorButtonItem: Hashable {}
```

##### Spacer

“SwiftUI 允许我们定义可伸缩的空白：Spacer，它会尝试将可占据的空间全部填满”

##### frame modifier

```swift
func frame(
  minWidth: CGFloat? = nil, 
  idealWidth: CGFloat? = nil, 
  maxWidth: GFloat? = nil, 
  minHeight: CGFloat? = nil, 
  idealHeight: CGFloat? = nil, 
  maxHeight: CGFloat? = nil, 
  alignment: Alignment = .center
) -> Self.Modified<_FlexFrameLayout>
```

这个函数所有参数都是可选的，它指定了 View 可以使用的可变高宽范围。在默认情况下，View 的尺寸会根据其内容以及它的子 View 的内容自动适配：比如在上面例子中，当 Text 为 0 时，Text 的宽度只有 0 的宽度；当文本内容变长时，Text 的宽度也随之变化。

使用方法如下：

```swift
VStack(spacing: 12) {
  Text("0")
    .font(.system(size: 76))
    .frame(
      minWidth: 0, 
      maxWidth: .infinity, 
      alignment: .trailing)
}
```

##### 预览多尺寸以及适配

通过修改 previews，我们可以同时预览多个屏幕尺寸。将 previews 改写为：

```swift
static var previews: some View {
  Group {
    ContentView()
    ContentView().previewDevice("iPhone SE")
  }
} 
```

View 提供了 `.scaleEffect modifier` 来进行缩放。我们所设计的界面是基于 414 宽度的，在 ContentView.swift 的最上方添加一个按照当前屏幕宽度计算的比例：

```swift
let scale: CGFloat = UIScreen.main.bounds.width / 414
然后将 VStack 按照 scale 缩放即可：

var body: some View {
 VStack(spacing: 12) {
 //...
 }
 .scaleEffect(scale)
}
```

> “小技巧：你可以在预览中使用在 ContentView() 后面添加 environment(\.colorScheme, .dark) 来快速检查深色模式下的 UI。”
