<img width="80" height="80" border-radius = "40" src="https://avatars0.githubusercontent.com/u/26161584?s=400&u=16aa790577ba20eedb394841b66d1fcfc300c3c1&v=4"/>

# ShineChart 基于Swift4.0 轻量级图表框架

<img width="375" height="812" src="http://g.recordit.co/QwgYcD6hJd.gif"/>

### 安装ShineChart
通过cocoapods安装
```ruby
pod 'ShineChart'
```

### 饼图
```swift
let item1 = ShinePieItem.init(color: .red, value: 0.7,title: "redcolor")
let item2 = ShinePieItem.init(color: .blue, value: 0.2,title: "bluecolor")
let item3 = ShinePieItem.init(color: .purple, value: 0.3,title: "purplecolor")

let pie = ShinePieChart.init(frame: CGRect.init(x: 0, y: 100, width: 300, height: 200), items: [item1,item2,item3])

pie.ringRadius = 20//内环半径

pie.startAngle = 0.2 //开始方向

pie.font = UIFont.systemFont(ofSize: 12)

pie.duration = 3

pie.center = self.view.center

view.addSubview(pie)
```

### 折线图
```swift
let line1 = ShineLine.init(color: .black,source: [0.2,0.4,0.6,0.2,0.8,0.7])

let line2 = ShineLine.init(color: .red,source: [0.3,0.2,0.8,0.5,0.6,0.9])

let bar = ShineLineChart.init(frame: CGRect.init(x: 0, y: 250, width: 375, height: 150), xItems: ["1","2","3","4","5","6"])

bar.maxValue = 1 //y轴最大值

bar.yItemCount = 5 //y轴坐标点个数

bar.lines = [line1,line2] //折线的集合

bar.duration = 2 //动画时长

///通过切换style可获取更多样式，见demo
bar.style = .line
bar.node = .normal

self.view.addSubview(bar)
```
### 柱状图
```swift
let bar1 = ShineBar.init(color: .green, value: [0.5,0.3,0.5,0.9,0.7,0.1,0.4])
let bar2 = ShineBar.init(color: .red, value: [0.2,0.4,0.3,0.7,0.6,0.5,0.8])

let bar = ShineBarChart.init(frame: CGRect.init(x: 0, y: 350, width: 375, height: 200), xItems: ["1","2","3","4","5","6"])

bar.maxValue = 1 //y轴最大值

bar.yItemCount = 5 //y轴坐标点个数

bar.bars = [bar1,bar2]

bar.duration = 2

bar.xShaftTitle = "X"

bar.yShaftTitle = "Y"

bar.itemWidth = 40

bar.center = self.view.center

self.view.addSubview(bar)

```
