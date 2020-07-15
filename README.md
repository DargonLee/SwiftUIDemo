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



- 给button添加sheet弹窗

```swift
Button("操作履历: \(model.history.count)") {
    self.editingHistory = true
      print(self.model.history)
}
.sheet(isPresented: self.$editingHistory) {
    HistoryView(model: self.model)
}
```

- 给他button添加alert弹窗

```swift
.alert(isPresented: self.$editingHistory, content: { () -> Alert in
       Alert(
       title: Text(self.model.brain.output),
       message: Text(self.model.historyDetail),
       dismissButton: .default(Text("OK"))
   )
})
```

上面的弹窗不仅能给Button加其他的View也可以添加

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

##### @State数据状态驱动界面

- **State**

“使用 @State 是最简单的关联方式。在 ContentView 中，加入一个 brain 属性(数据模型)：

@State 属性值仅只能在属性本身被设置时会触发 UI 刷新，这个特性让它非常适合用来声明一个值类型的值：因为对值类型的属性的变更，也会触发整个值的重新设置，进而刷新 UI。

```swift
struct ContentView : View {

@State private var brain: CalculatorBrain = .left("0")

var body: some View {
 // ...
 }
}
```

和一般的存储属性不同，@State 修饰的值，在 SwiftUI 内部会被自动转换为一对 setter 和 getter，对这个属性进行赋值的操作将会触发 View 的刷新，它的 body 会被再次调用，底层渲染引擎会找出界面上被改变的部分，根据新的属性值计算出新的 View，并进行刷新。”

对于 @State 修饰的属性的访问，只能发生在 body 或者 body 所调用的方法中。你不能在外部改变 @State 的值，它的所有相关操作和状态改变都应该是和当前 View 挂钩的。如果你需要在多个 View 中共享数据，@State 可能不是很好的选择；如果还需要在 View 外部操作数据，那么 @State 甚至就不是可选项了。

- **@Binding**

“@Binding 就是用来解决层级过多的情况下 `@State`修饰的属性值在不同对象之间传递时顶层传递不到。和 @State 类似，@Binding 也是对属性的修饰，它做的事情是将值语义的属性“转换”为引用语义。对被声明为 @Binding 的属性进行赋值，改变的将不是属性本身，而是它的引用，这个改变将被向外传递。”

```swift
struct CalculatorButtonPad: View {
  @Binding var brain: CalculatorBrain
  // ...

  var body: some View {
    // ...
  }
}

struct CalculatorButtonRow : View {
  @Binding var brain: CalculatorBrain
  // ...

  var body: some View {
    // ...
  }
}
```

##### 投影属性 (projection property)。

在传递 brain 时，我们在它前面加上美元符号 $。在 Swift 5.1 中，对一个由 @ 符号修饰的属性，在它前面使用 $ 所取得的值，被称为投影属性 (projection property)。

需要知道 $brain 的写法将 brain 从 State 转换成了引用语义的 Binding，并向下传递。

```swift
struct CalculatorButtonPad: View {
  var body: some View {
   VStack(spacing: 8) {
      ForEach(pad, id: \.self) { row in
        CalculatorButtonRow(row: row, brain: self.$brain)
      }
    }
 }
```

##### ObservableObject 和 @ObjectBinding

如果说 @State 是全自动驾驶的话，ObservableObject 就是半自动，它需要一些额外的声明。ObservableObject 协议要求实现类型是 class，它只有一个需要实现的属性：objectWillChange。在数据将要发生改变时，这个属性用来向外进行“广播”，它的订阅者 (一般是 View 相关的逻辑) 在收到通知后，对 View 进行刷新。

创建 ObservableObject 后，实际在 View 里使用时，我们需要将它声明为 @ObservedObject。这也是一个属性包装，它负责通过订阅 objectWillChange 这个“广播”，将具体管理数据的 ObservableObject 和当前的 View 关联起来。

```swift
在 CalculatorModel 里添加 CalculatorBrain：

class CalculatorModel: ObservableObject {

  let objectWillChange = PassthroughSubject<Void, Never>()

  var brain: CalculatorBrain = .left("0") {
    willSet { objectWillChange.send() }
  }
}
然后在 ContentView 里将 @State 的内容都换成对应的 @ObservedObject 和 CalculatorModel：

struct ContentView : View {
  // @State private var brain: CalculatorBrain = .left("0")
  @ObservedObject var model = CalculatorModel() // 1

  var body: some View {
    VStack(spacing: 12) {
      Spacer()
      Text(model.brain.output) // 2
        //...
      CalculatorButtonPad(brain: $model.brain) // 3
        //...
    }     
  }
}
```

##### 使用 @Published 和自动生成

在 ObservableObject 中，对于每个对界面可能产生影响的属性，我们都可以像上面 brain 的 willSet 那样，手动调用 objectWillChange.send()。如果在 model 中有很多属性，我们将需要为它们一一添加 willSet，这无疑是非常麻烦，而且全是重复的模板代码。实际上，如果我们省略掉自己声明的 objectWillChange，并把属性标记为 @Published，编译器将会帮我们自动完成这件事情。

```swift
class CalculatorModel: ObservableObject {

  @Published var brain: CalculatorBrain = .left("0")
}
```

##### 使用 @EnvironmentObject 传递数据

为了减少页面层级过深的情况下，传值过多导致很多无效的代码，可以在这个View的子层级中使用`@EnvironmentObject`来直接过去这个绑定的环境值

```swift
struct ContentView : View {

  @EnvironmentObject var model: CalculatorModel
  // ...
}
类似地，在 CalculatorButtonRow 里，也可以修改 model 的定义：

struct CalculatorButtonRow : View {
  @EnvironmentObject var model: CalculatorModel
  // ...
}
```

只需要在顶层级和最低层级添加上面修饰符，这样在对应的 View 生成时，我们不需要手动为被标记为 @EnvironmentObject 的值进行指定，它们会自动去查询 View 的 Environment 中是否有符合的类型的值，如果有则使用它们，如没有则抛出运行时的错误。



最后，我们在 SceneDelegate.swift 文件中创建 ContentView 的地方，通过 environmentObject 把通用的 CalculatorModel 添加上去：

```swift

window.rootViewController = UIHostingController(
 rootView: ContentView().environmentObject(CalculatorModel())
)
```
