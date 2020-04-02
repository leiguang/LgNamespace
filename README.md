### 介绍

比如写一个 `lg` 为后缀的命名空间，类似于 `RxSwift` 中的 `rx`, `Kingfisher` 中的 `kf`，可用以区别和添加 `lg` 独有的扩展方法。



`Lg.swift` 中实现 `lg` 命名空间的代码如下：

```swift
public struct LgWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol LgCompatible {}

extension LgCompatible {
    public var lg: LgWrapper<Self> {
        get { return LgWrapper(self) }
        set {}
    }
}
```



### 思路：

1. 创建一个 `LgWrapper` 的对象，它就像一个容器，里面会包含一个泛型对象 base，实际上真正做事的是这个 base 对象。

2. 写一个 `LgCompatible` 空协议，

3. 默认为它添加一个 `lg` 属性，这样一来，只要我想为某对象A 添加 `lg` 命名空间，就只需要让` A` 遵守 `LgCompatible` 协议： `extension A: LgCompatible {}` ，就可以让 `a` 拥有 `a.lg` 属性。

4. 该 `lg` 属性返回的是一个 包裹了 a对象 的 LgWrapper<A> 对象。

5. 假设A拥有一个方法 `doSomething()` ，那么，为 `LgWrapper` 写一个扩展方法 `doSomething()`，就可以在其中调用 `base.doSomething()` 方法了。



### 用法：

若对象 `A` 想扩展 `lg` 命名空间，

已知：

```swift
class A {
  func doSomething() {
    print("doSomething")
  }
}
```

做法如下：

```swift
// 在文件 Lg.swift 中为控件 A 实现命名空间的协议（内容是空的）
extension A: LgCompatible {}

// 在你自己的文件中，实现具体需要的方法
extension LgWrapper where Base: A {
  func doSomething() {
  	base.doSomething()
  }
}
```

使用：

```swift
let a = A()
a.doSomething()
```



 

### 示例：

例如，在 iOS 13 之后，系统默认的 present方法使用 `modalPresentationStyle = .pageSheet` 样式弹出，即弹出的 ViewController顶部会留部分距离是有暗色半透明背景。

但是项目中暂不需要这样的风格，所以在 `Lg+UIViewController.swift` 文件中，以 `lg` 为命名空间 对 `UIViewController` 进行扩展，代码如下：

```swift
extension LgWrapper where Base: UIViewController {
    func present(_ viewController: UIViewController, presentationStyle: UIModalPresentationStyle = .fullScreen, animated: Bool, completion: (() -> Void)? = nil) {
        if viewController.modalPresentationStyle == .pageSheet {
            viewController.modalPresentationStyle = presentationStyle
        }

        base.present(viewController, animated: animated, completion: completion)
    }
}
```

使用的时候加上 `.lg.present`：

```swift
viewController.lg.present(vc2, animated: true, completion: nil)
```