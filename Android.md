# 前置了解

使用`Android studio`开发

## 项目结构
![[Pasted image 20241202203459.png]]
Android studio左侧文件夹目录中的结构如图

其中：
> **java**：我们写Java代码的地方，业务功能都在这里实现
> **res**：存放我们各种资源文件的地方，有图片，字符串，动画，音频等，还有各种形式的XML文件
> **drawable**：存放的是各种位图文件，还有一些其他的drawable类型的xml文件。
> **layout**：存放APP的布局文件。
> **mipmap**：存放位图文件，同时图片缩放提供一定优化。
> **value**：包括了colors.xml，strings.xml，styles.xml这三个主要文件，其中colors.xml中定义的颜色资源；strings.xml中定义的字符串资源；styles.xml中定义的是样式资源。

有些时候可能会看见这样一行：
```java
import com.learn.R;
```

**`R` 是什么？**

`R` 类是 Android 构建系统自动生成的一个 **资源引用类**，它将项目中所有的资源（如布局、字符串、图片等）转换为静态的整型常量，供 Java 或 Kotlin 代码引用。

**R 类的主要作用：**
- 将 XML 定义的资源映射到 Java/Kotlin 中。
- 为资源分配唯一的 ID（整数值），用于高效引用和操作资源。

**R 类的结构：**
`R` 类包含多个嵌套的静态类，每个嵌套类对应一种资源类型，例如：
```java
public final class R {
    public static final class drawable {
        public static final int icon = 0x7f080000;
    }
    public static final class layout {
        public static final int activity_main = 0x7f0c0000;
    }
    public static final class string {
        public static final int app_name = 0x7f150000;
    }
}

```

- **`drawable`：** 用于图片资源。
- **`layout`：** 用于布局资源。
- **`string`：** 用于字符串资源。
- **`id`：** 用于 View 的唯一 ID。

### 资源介绍

res内所有的资源文件都会在R.java文件下生成一个资源id，我们可以通过这个资源id来完成资源的访问，使用情况有两种：Java代码中使用和XML代码中使用：

**Java代码中使用：**

```java
Java 文字：txtName.setText(getResources().getText(R.string.name)); 
图片：imgIcon.setBackgroundDrawableResource(R.drawable.icon); 
颜色：txtName.setTextColor(getResouces().getColor(R.color.red)); 
布局：setContentView(R.layout.main);
控件：txtName = (TextView)findViewById(R.id.txt_name);
```

**XML代码中使用：**
通过@xxx即可得到，比如这里获取文本和图片:

```xml
<TextView android:text="@string/hello_world" android:layout_width="wrap_content" android:layout_height="wrap_content" android:background = "@drawable/img_back"/>
```

### 三大文件

#### *MainActivity.java*

**作用：**
- **主逻辑文件**：负责定义应用的主要行为和交互逻辑。
- **入口 Activity**：通常作为应用启动时展示的第一个界面。
- **与布局文件关联**：通过调用 `setContentView()` 方法将布局文件绑定到该 Activity。

**常见内容：**
- **继承 `AppCompatActivity`**：使其具有基本的 Activity 功能。
- **生命周期方法**：如 `onCreate()`、`onStart()`、`onPause()` 等。
- **事件处理**：处理用户操作，如按钮点击事件。

**示例代码：**
```java
package com.example.myapp;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 绑定布局文件
        setContentView(R.layout.activity_main);

        // 示例：找到按钮并设置点击事件
        findViewById(R.id.my_button).setOnClickListener(v -> {
            // 响应逻辑
            System.out.println("Button clicked!");
        });
    }
}

```

#### *activity_main.xml*

**作用：**
- **定义 UI 界面**：指定 Activity 或 Fragment 的用户界面结构。
- **声明组件**：如按钮、文本框、图片等。
- **与 Java 逻辑文件关联**：UI 元素通过 `findViewById()` 方法与逻辑代码交互。

#### *AndroidManifest.xml*

**作用：**
- **定义应用的元信息**：描述应用的名称、图标、版本号等基本信息。
- **注册组件**：声明应用使用的所有组件，如 `Activity`、`Service`、`BroadcastReceiver`。
- **权限声明**：定义应用运行时所需的权限，如网络访问、位置访问等。
- **定义入口点**：标明应用的启动 Activity。

**常见内容：**
1. **应用基本信息**：
    - 包名（`package`）
    - 版本号和版本名
2. **组件注册**：
    - 注册 Activity、Service 等组件。
3. **权限声明**：
    - 声明网络、存储等访问权限。
4. **主题设置**：
    - 设置应用或单个 Activity 的主题。

**示例：**
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.myapp">

    <!-- 应用的基本信息 -->
    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/AppTheme">

        <!-- 主 Activity 注册 -->
        <activity android:name=".MainActivity">
            <!-- 声明为应用入口点 -->
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

    <!-- 权限声明 -->
    <uses-permission android:name="android.permission.INTERNET" />
</manifest>

```

解释：
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="com.example.myapp">
```

- **xmlns:android**: 这是 XML 命名空间声明，它指示该 XML 文件属于 Android 配置格式。
- **package**: 这是 Android 应用的包名 (`com.example.myapp`)，它是应用的唯一标识符。在整个 Android 系统中，包名是唯一的。

```xml
<application
android:allowBackup="true"
android:icon="@mipmap/ic_launcher"
android:label="@string/app_name"
android:theme="@style/AppTheme">
```

- **`android:allowBackup="true"`**: 这个属性指示应用是否允许备份。`true` 表示允许应用数据备份。
- **`android:icon="@mipmap/ic_launcher"`**: 这是应用的图标，指向一个图标资源（`@mipmap/ic_launcher` 是资源的引用）。
- **`android:label="@string/app_name"`**: 应用的名称，引用了一个字符串资源。这个字符串会在设备上显示，通常是在应用图标下方的名称。
- **`android:theme="@style/AppTheme"`**: 应用的主题，指定了应用的 UI 样式。

```xml
<activity android:name=".MainActivity">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
</activity>
```

- **`<activity>`**: 这是声明一个 Activity（应用中的一个屏幕）。`android:name=".MainActivity"` 表示该 Activity 的类名为 `MainActivity`。通常在声明时会指定 Activity 的全名，但如果 Activity 在同一包中，前面加个 `.` 表示相对路径。
    
- **`<intent-filter>`**: 用于定义 Activity 可以响应的意图（Intent）。`<intent-filter>` 用于声明这个 Activity 能够处理哪些类型的意图。意图有 `action` 和 `category` 两个部分：
    
    - **`<action>`**: 定义意图的动作。这里的 `android.intent.action.MAIN` 表示该 Activity 是应用的主入口。
    - **`<category>`**: 定义意图的类别。`android.intent.category.LAUNCHER` 表示该 Activity 是启动器活动，也就是启动时应用会打开的 Activity。

这两项配合使用，表明 `MainActivity` 是应用的启动界面，当用户点击应用图标时会启动此 Activity。

```xml
<uses-permission android:name="android.permission.INTERNET" />
```
**`<uses-permission>`**: 用于声明应用所需的权限。此例中声明了 `INTERNET` 权限，表示应用需要使用互联网。


**如何为新的 Activity 添加声明**

每个 Activity 都需要在 `AndroidManifest.xml` 中声明
```xml
<activity android:name=".NewActivity">
    <intent-filter>
        <action android:name="com.example.myapp.NEW_ACTIVITY" />
        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
</activity>
```
- **`android:name=".NewActivity"`**: 声明新 Activity 的类名。若 Activity 在同一包中，可以使用相对路径（例如：`.NewActivity`）。
- **`<intent-filter>`**: 用来声明该 Activity 响应的意图。例如，`android.intent.action.VIEW` 可能会用来表示某个页面可以展示某种类型的内容。


---

# UI

Android 的 UI 界面都是由 `View` 和 `ViewGroup` 及其派生类组合而成的。其中，`View` 是所有 UI 组件的基类，而 `ViewGroup` 是容纳 `View` 及其派生类的容器，`ViewGroup` 也是从 `View` 派生出来的

`View`通常会绘制用户可见的内容，互动`ViewGroup` 是一个不可见的容器，用于定义 `View` 和其他 `ViewGroup` 的布局结构对象
![[Pasted image 20241217203634.png|725]]

## 布局

布局就是界面的框架，类似一个可以放很多控件的容器
- 如下图为布局和控件的关系，布局里可嵌套布局和控件，但控件里不可放布局

![[Pasted image 20241217203800.png|556]]

Android中有六大布局,分别是：
>线性布局*LinearLayout*
>相对布局*RelativeLayout*
>表格布局*TableLayout*
>帧布局*FrameLayout*
>绝对布局*AbsoluteLayout*
>网格布局*GridLayout*

还有一种新型布局
>约束布局*ConstraintLayout*


**布局的创建和加载**

根据上文所说
> **layout**：存放APP的布局文件。

在Android Studio中
![[Pasted image 20241217204425.png|1350]]

布局文件创建后，在`activity`类中加载
```java
public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
}
```

```kotlin
fun onCreate(savedInstanceState: Bundle) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
}
```

*下面将介绍布局中的一些常用属性，有关控件（如`EditText`、`TextView`等）的属性，可以在使用时自行搜索*
### 线性布局

线性布局是常用一种布局，按垂直（vertical）或者水平（horizontal）方向来布局控件
![[Pasted image 20241217205314.png]]

1. **orientation**：
    - 控制子组件的排列方式，有两种选择：
        - `horizontal`：水平排列（从左到右）。
        - `vertical`：垂直排列（从上到下，默认）。
2. **gravity**：
    - 控制 **LinearLayout 内的子元素** 如何对齐，可以设置多个组合，如 `left`（左对齐）、`right`（右对齐）、`center`（居中）等。
3. **layout_gravity**：
    - 控制 **该组件在父容器中的对齐方式**。
    - 常见的属性值有 `top`、`bottom`、`center` 等。
4. **layout_width 和 layout_height**：
    - 控制组件的宽度和高度：
        - `wrap_content`：根据内容大小来调整。
        - `match_parent` 或 `fill_parent`：填充满父容器。
5. **id**：
    - 为组件设置唯一资源 ID，便于在 Java 文件中通过 `findViewById(id)` 获取组件引用。
6. **background**：
    - 设置组件的背景，可以使用纯色、图片等。


`Weight` 属性用于按比例分配控件的空间。
- **简单用法**：
    - 通过设置 `layout_weight` 属性，可以让组件按照比例占据父容器的空间。
    - 比如两个组件设置 `weight=1`，会均分剩余空间；如果一个组件设置 `weight=2`，另一个为 `weight=1`，空间分配比例为 2:1。
- **应用场景**：
    - 常用于实现多组件按比例分配空间，灵活控制 UI 布局。


`divider` 属性用于在 LinearLayout 中设置分割线，可以控制分割线的样式和位置。
1. **divider**：
    - 设置分割线的具体图片。
2. **showDividers**：
    - 设置分割线显示的位置，常见的值有：
        - `none`：不显示分割线。
        - `middle`：仅在组件之间显示分割线。
        - `beginning`：第一个组件之前显示分割线。
        - `end`：最后一个组件之后显示分割线。
3. **dividerPadding**：
    - 控制分割线的 padding（内边距）。

*示例*
```xml
<?xml version="1.0" encoding="utf-8"?>

<!--@+id/ 表示定义一个新 ID。-->
<!--xmlns:android：定义了 android`命名空间，用于访问 Android 系统提供的属性（如 android:layout_width）-->
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:id="@+id/main"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical">
    <!--在垂直方向的 LinearLayout 中，layout_height="0dp" 的意思是 不占用固定高度。-->
    <!--高度将完全由 layout_weight 来决定，而不是由内容或 layout_height 的值决定。-->
    <Button
            android:id="@+id/button1"
            android:layout_width="100dp"
            android:layout_height="0dp"
            android:text="Button1"
            android:layout_weight="3" />

    <Button
            android:id="@+id/button2"
            android:layout_width="100dp"
            android:layout_height="0dp"
            android:text="Button2"
            android:layout_gravity="right"
            android:layout_weight="1" />

    <Button
            android:id="@+id/button3"
            android:layout_width="100dp"
            android:layout_height="0dp"
            android:text="Button3"
            android:layout_weight="2" />
</LinearLayout>

```

效果：
![[Pasted image 20241217212919.png]]

*示例*
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:id="@+id/main"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="horizontal">

    <TextView
            android:layout_weight="1"
            android:layout_width="wrap_content"
            android:layout_height="fill_parent"
            android:text="one"
            android:background="#98FB98" />

    <TextView
            android:layout_weight="2"
            android:layout_width="wrap_content"
            android:layout_height="fill_parent"
            android:text="two"
            android:background="#FFFF00" />

    <TextView
            android:layout_weight="3"
            android:layout_width="wrap_content"
            android:layout_height="fill_parent"
            android:text="three"
            android:background="#FF00FF" />
</LinearLayout>
```

效果:
![[Pasted image 20241217213216.png]]

**关键区别：`wrap_content` 和 `0dp` 的底层逻辑**
1. **`layout_width="wrap_content"`**：
    - 系统会 **先测量控件内容的宽度**。
    - 然后，当存在 `layout_weight` 时，系统会忽略控件的内容大小，重新分配控件的宽度。
    - **过程：** 测量内容 → 覆盖大小 → 按权重分配。
2. **`layout_width="0dp"`**：
    - 系统直接跳过控件内容的宽度测量。
    - 它会立即根据 `layout_weight` 进行分配，不做无意义的内容大小计算。
    - **过程：** 跳过测量 → 按权重分配。


**练习：学校实验内容**
![[Pasted image 20241218215943.png]]

手写一个这样的页面即可

```xml

```