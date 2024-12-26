
# 前置了解

使用`Android Studio`开发

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
package edu.swpu.iot2022.myapplication;  
  
import android.os.Bundle;  
  
import androidx.activity.EdgeToEdge;  
import androidx.appcompat.app.AppCompatActivity;  
import androidx.core.graphics.Insets;  
import androidx.core.view.ViewCompat;  
import androidx.core.view.WindowInsetsCompat;  
  
public class MainActivity extends AppCompatActivity {  
    // 重写 onCreate 方法，在 Activity 创建时调用  
    @Override  
    protected void onCreate(Bundle savedInstanceState) {  
    	// 建议把所有对应的调用父类的方法的代码写在开头
        super.onCreate(savedInstanceState);  // 调用父类的 onCreate 方法，进行默认的初始化工作  
        // 启用 Edge-to-Edge 功能，允许 Activity 使用系统的边界区域（如屏幕顶部、底部）  
        EdgeToEdge.enable(this);  
        // 设置当前 Activity 使用的布局文件，activity_main.xml 是布局的资源 ID        setContentView(R.layout.activity_main);  
        // 为界面中的一个视图（ID 为 main 的视图）设置窗口内边距监听器  
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {  
            // 获取系统条（状态栏、导航栏等）的内边距  
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());  
            // 设置视图的内边距，使其避开系统条区域  
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);  
            // 返回原始的 insets 对象  
            return insets;  
        });  
    }  
}
```

*其实`super.onCreate(savedInstanceState)`之下的代码都是为全面屏而准备的*


#### *activity_main.xml*

**作用：**
- **定义 UI 界面**：指定 Activity 或 Fragment 的用户界面结构。
- **声明组件**：如按钮、文本框、图片等。
- **与 Java 逻辑文件关联**：UI 元素通过 `findViewById()` 方法与逻辑代码交互。

#### *AndroidManifest.xml*

应用清单

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
---

## 杂类知识

### Log

**Log是Android中的日志工具类，用来打印日志**

`Log.d(String tag, String msg)`
- 对应Debug调试
- 第一个参数**tag**：**打印信息的标签**（标志）（如果设置该参数为TAG,在查看logcat时，可以通过搜索栏来搜索标签为TAG的打印信息）
- 第二个参数**msg**：**表示需要打印出来的信息**

android.util.Log常用的方法有以下5个：

- **Log.v()** --> *VERBOSE*
- **Log.d()** --> *DEBUG*
- **Log.i()** --> *INFO*
- **Log.w()** --> *WARN*
- **Log.e()** --> *ERROR*

- 1、Log.v 的调试颜色为黑色的，任何消息都会输出，这里的v代表verbose啰嗦的意思，平时使用就是Log.v("","");
    
- 2、Log.d的输出颜色是蓝色的，仅输出debug调试的意思，但他会输出上层的信息，过滤起来可以通过DDMS的Logcat标签来选择.
    
- 3、Log.i的输出为绿色，一般提示性的消息information，它不会输出Log.v和Log.d的信息，但会显示i、w和e的信息
    
- 4、Log.w的意思为橙色，可以看作为warning警告，一般需要我们注意优化Android代码，同时选择它后还会输出Log.e的信息。
    
- 5、Log.e为红色，可以想到error错误，这里仅显示红色的错误信息，这些错误就需要我们认真的分析，查看栈的信息了。注意：不同的打印方法在使用时都是某个方法带上(String tag, String msg)参数，tag表示的是打印信息的标签，msg表示的是需要打印的信息。

### 获取时间日期

```java
new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
```


### 安卓打包与发布

在这里选择打包和签名安装包
![[Pasted image 20241226220148.png]]

签名可以标识开发者，防止篡改


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
![[Pasted image 20241219135529.png|1350]]

在这里，不论什么布局，你都可以像`Visual Basic`一样进行可视化编辑，包括调整控件位置和大小等

**外观相关：**
![[Pasted image 20241219135607.png|975]]

1. **Design 和 Blueprint**：选择我们希望如何在编辑器中查看布局。选择 **Design** 可查看布局的渲染后预览效果。选择 **Blueprint** 可仅查看每个视图的轮廓。选择 **Design + Blueprint** 可并排查看这两个视图； 
2. **屏幕方向和布局变体**：选择屏幕方向（横向和纵向），或选择应用提供备用布局的其他屏幕模式（例如夜间模式）。该菜单还包含用于创建新布局变体的命令；
3. **设备类型和尺寸**：选择设备类型（手机/平板电脑、Android TV 或 Wear OS）和屏幕配置（尺寸和密度）。我们可以从多种预配置的设备类型和 AVD 定义中选择，也可以从列表中选择 **Add Device Definition** 创建新的 AVD；
4. **API 版本**：选择预览布局时使用的 Android 版本；
5. **AppTheme**：选择要应用于预览的界面主题背景。请注意，这仅适用于支持的布局样式，因此该列表中的许多主题背景都会导致出错；
6. **Language**：选择要以何种语言显示界面字符串。此列表仅会显示我们的字符串资源支持的语言。如果想要修改翻译，点击点击下拉菜单中的 **Edit Translations**。


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

*下面将介绍布局中的一些常用属性
有关控件（如`EditText`、`TextView`等）的属性，可以在使用时自行搜索*
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


**分割线`divider`**
略过

布局之间可以嵌套，具体表现为，总父布局设置为垂直结构，之后可以再嵌套一个水平结构的布局，如下图
![[Pasted image 20241219141049.png]]

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:id="@+id/main"
        android:layout_height="match_parent"
        android:orientation="vertical">

    <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="请输入保存电话" />

    <EditText
            android:id="@+id/phone"
            android:layout_width="match_parent"
            android:layout_height="wrap_content" />

    <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:gravity="right">

        <Button
                android:id="@+id/save"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="保存" />

        <Button
                android:id="@+id/cancel"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="取消" />
    </LinearLayout>
</LinearLayout>

```

> NOTE：
> 线性布局是线性的，也就是所有界面都是按顺序以此放置的，无法做到东一耙子，西一扫帚
> 要想让控件灵活起来，还需要使用其他布局



**练习：学校实验内容**
![[Pasted image 20241218215943.png]]

手写一个这样的页面即可

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:id="@+id/main"
        android:layout_height="match_parent">

    <EditText
            android:layout_width="100dp"
            android:layout_height="48dp"
            android:id="@+id/ed1"
            android:gravity="center" />

    <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:id="@+id/text1"
            android:text="+"
            android:textSize="20sp" />

    <EditText
            android:layout_width="100dp"
            android:layout_height="48dp"
            android:id="@+id/ed2"
            android:gravity="center" />

    <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:id="@+id/tx2"
            android:text="="
            android:textSize="20sp" />

    <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:id="@+id/tx3"
            android:textSize="20sp"
            android:textStyle="bold"
            android:gravity="center" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:id="@+id/btn"
            android:text="计算"
            android:gravity="center"
            android:textSize="20sp" />
</LinearLayout>

```

*逻辑代码之后会讲解*
```java
package com.learn;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {
    private EditText ed1, ed2;
    private TextView tx3;
    private Button btn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);-
        setContentView(R.layout.activity_main);
        ed1 = findViewById(R.id.ed1);
        ed2 = findViewById(R.id.ed2);
        tx3 = findViewById(R.id.tx3);
        btn = findViewById(R.id.btn);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                var input1 = ed1.getText().toString();
                var input2 = ed2.getText().toString();
                if (input2.isEmpty() || input1.isEmpty()) {
                    Toast.makeText(MainActivity.this, "请输入", Toast.LENGTH_SHORT).show();
                    return;
                }
                try {
                    var n1 = Double.parseDouble(input1);
                    var n2 = Double.parseDouble(input2);
                    var res = n1 + n2;

                    tx3.setText(String.valueOf(res));
                } catch (Exception e) {
                    Toast.makeText(MainActivity.this, "请输入数字", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
```


### 相对布局

当界面比较复杂的时候，即使使用了多种嵌套的线性布局，也无法实现想要的灵活效果，同时甚至还降低了UI的渲染效率
这时需要使用`RelativeLayout`，以父容器或者兄弟组件参考+margin +padding就可以设置组件的显示位置

![[Pasted image 20241219142014.png]]

1. **相对于父控件的属性**

这些属性用于让子控件与父控件的边界对齐：

- **`android:layout_alignParentTop="true"`**  
    控件的 **顶部** 与父控件的顶部对齐。
- **`android:layout_alignParentBottom="true"`**  
    控件的 **底部** 与父控件的底部对齐。
- **`android:layout_alignParentLeft="true"`**  
    控件的 **左边缘** 与父控件的左边缘对齐。
- **`android:layout_alignParentRight="true"`**  
    控件的 **右边缘** 与父控件的右边缘对齐。
- **`android:layout_centerHorizontal="true"`**  
    控件在父控件中 **水平居中**。
- **`android:layout_centerVertical="true"`**  
    控件在父控件中 **垂直居中**。
- **`android:layout_centerInParent="true"`**  
    控件在父控件中 **完全居中**（水平和垂直居中）。

2. **相对于指定控件的属性**

这些属性用于让子控件相对于某个已指定控件（通过 ID 设置）的位置进行布局：

- **`android:layout_above="@id/控件ID"`**  
    当前控件的 **底部** 位于指定控件的顶部。
- **`android:layout_below="@id/控件ID"`**  
    当前控件的 **顶部** 位于指定控件的底部。
- **`android:layout_toLeftOf="@id/控件ID"`**  
    当前控件的 **右边缘** 紧挨指定控件的左边缘。
- **`android:layout_toRightOf="@id/控件ID"`**  
    当前控件的 **左边缘** 紧挨指定控件的右边缘。
- **`android:layout_alignTop="@id/控件ID"`**  
    当前控件的 **顶部** 与指定控件的顶部对齐。
- **`android:layout_alignBottom="@id/控件ID"`**  
    当前控件的 **底部** 与指定控件的底部对齐。
- **`android:layout_alignLeft="@id/控件ID"`**  
    当前控件的 **左边缘** 与指定控件的左边缘对齐。
- **`android:layout_alignRight="@id/控件ID"`**  
    当前控件的 **右边缘** 与指定控件的右边缘对齐。
- **`android:layout_alignBaseline="@id/控件ID"`**  
    当前控件的 **基线** 与指定控件的基线对齐。

3. **外边距（Margin）**

用于设置控件与其他控件或父控件边缘之间的距离：
- **`android:layout_margin`**  
    设置控件 **上下左右** 的外边距。
- **`android:layout_marginTop`**  
    设置控件 **顶部** 的外边距。
- **`android:layout_marginBottom`**  
    设置控件 **底部** 的外边距。
- **`android:layout_marginLeft`**  
    设置控件 **左侧** 的外边距。
- **`android:layout_marginRight`**  
    设置控件 **右侧** 的外边距。

4. **内边距（Padding）**

用于设置控件内容与控件边框之间的距离：

- **`android:padding`**  
    设置控件 **上下左右** 的内边距。
- **`android:paddingTop`**  
    设置控件 **顶部** 的内边距。
- **`android:paddingBottom`**  
    设置控件 **底部** 的内边距。
- **`android:paddingLeft`**  
    设置控件 **左侧** 的内边距。
- **`android:paddingRight`**  
    设置控件 **右侧** 的内边距。

>`padding`与`margin`在其他布局中也可以使用


父容器属性定位图：
![[Pasted image 20241219142357.png]]

兄弟组件定位图：
![[Pasted image 20241219142440.png]]

其中，组件1与组件2互为兄弟，与组件3无关


> NOTE：
> `margin`针对的是容器中的组件，而`padding`针对的是组件中的元素

*差别示例：*
```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:id="@+id/main">
    
    <!--两个按钮，一个是paddingLeft，一个是layout_marginLeft-->
    <Button
            android:id="@+id/btn1"
            android:layout_height="wrap_content"
            android:layout_width="wrap_content"
            android:text="Button" />

    <Button
            android:paddingLeft="100dp"
            android:layout_height="wrap_content"
            android:layout_width="wrap_content"
            android:text="Button"
            android:layout_toRightOf="@id/btn1" />

    <Button
            android:id="@+id/btn2"
            android:layout_height="wrap_content"
            android:layout_width="wrap_content"
            android:text="Button"
            android:layout_alignParentBottom="true" />

    <Button
            android:layout_marginLeft="100dp"
            android:layout_height="wrap_content"
            android:layout_width="wrap_content"
            android:text="Button"
            android:layout_toRightOf="@id/btn2"
            android:layout_alignParentBottom="true" />

</RelativeLayout>
```

![[Pasted image 20241219145745.png]]

> `margin`可以使用负数


相对布局中，在Android Studio中可以拖动或者通过箭头来快捷设置相对属性和位置
![[Pasted image 20241219150511.png|386]]


**练习：学校实验内容**

手搓一个这样的页面
![[Pasted image 20241219150754.png]]

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:id="@+id/main">

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="中间"
            android:id="@+id/middle"
            android:layout_centerInParent="true" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerInParent="true"
            android:layout_above="@id/middle"
            android:text="上" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_toLeftOf="@id/middle"
            android:layout_above="@id/middle"
            android:text="左上" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="左"
            android:layout_alignBaseline="@id/middle"
            android:layout_toLeftOf="@id/middle" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="左下"
            android:layout_below="@id/middle"
            android:layout_toLeftOf="@id/middle" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="下"
            android:layout_centerInParent="true"
            android:layout_below="@id/middle" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="右下"
            android:layout_below="@id/middle"
            android:layout_toRightOf="@id/middle" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="右"
            android:layout_toRightOf="@id/middle"
            android:layout_alignBaseline="@id/middle" />

    <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="右上"
            android:layout_toRightOf="@id/middle"
            android:layout_above="@id/middle" />


</RelativeLayout>
```



### 网格布局

网格布局与表格布局相似，但是这里只介绍网格布局，表格布局不做介绍。

网格布局是Android 4.0 以后引入的一个新的布局
- 可以自己设置布局中组件的排列方式
- 可以自定义网格布局有多少行,多少列
- 可以直接设置组件位于某行某列
- 可以设置组件横跨几行或者几列

**为了解决相对布局要写一大堆相对属性的难题，把整个页面看做网格，做到一个控件一个坑**

![[Pasted image 20241219162102.png]]

**1. 设置排列方向**

- **`android:orientation`**
    - 定义网格排列方向：
        - **`horizontal`**（水平排列）。
        - **`vertical`**（垂直排列，默认值）。

**2. 设置对齐方式**
- **`android:layout_gravity`**
    - 控件对齐方式：
        - 可设置为 **`center`**、**`left`**、**`right`**、**`top`**、**`bottom`** 等。
        - 组合使用时，如：`bottom|left`，可以实现多方向对齐。

**3. 设置行数和列数**

- **`android:rowCount`**
    - 指定网格的 **总行数**，例如：`android:rowCount="4"` 表示布局有 4 行。
- **`android:columnCount`**
    - 指定网格的 **总列数**，例如：`android:columnCount="4"` 表示布局有 4 列。
> 如果这两个有一个没写，则会根据根据所有子控件的 `android:layout_row` 和 `android:layout_rowSpan` 的值，自动计算所需的总行(列)数

 **4. 设置子控件所在行或列**

- **`android:layout_row`**
    - 子控件所在的行，从 **0** 开始计数。例如：`android:layout_row="1"` 表示子控件在第 2 行。
- **`android:layout_column`**
    - 子控件所在的列，从 **0** 开始计数。例如：`android:layout_column="2"` 表示子控件在第 3 列。

**5. 设置子控件跨行或跨列**

- **`android:layout_rowSpan`**
    - 子控件 **跨越的行数**，例如：`android:layout_rowSpan="2"` 表示控件跨 2 行。
- **`android:layout_columnSpan`**
    - 子控件 **跨越的列数**，例如：`android:layout_columnSpan="3"` 表示控件跨 3 列。

**6. 其他常用属性**

- **`android:useDefaultMargins`**
    - 是否使用默认的边距，默认值为 **`true`**。
- **`android:alignmentMode`**
    - 设置对齐模式：
        - **`alignMargins`**（默认）：根据控件的外边距对齐。


*示例*
![[Pasted image 20241219164131.png|350]]

```xml
<GridLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:columnCount="4"
        android:layout_gravity="center"
        android:id="@+id/main">

    <Button
            android:layout_column="3"
            android:text="/" />

    <Button android:text="1" />

    <Button android:text="2" />

    <Button android:text="3" />

    <Button android:text="*" />

    <Button android:text="4" />

    <Button android:text="5" />

    <Button android:text="6" />

    <Button android:text="-" />

    <Button android:text="7" />

    <Button android:text="8" />

    <Button android:text="9" />

    <Button
            android:text="+"
            android:layout_gravity="fill"
            android:layout_rowSpan="3" />

    <Button
            android:text="0"
            android:layout_gravity="fill"
            android:layout_columnSpan="2" />

    <Button android:text="00" />

    <Button
            android:text="="
            android:layout_gravity="fill"
            android:layout_columnSpan="3" />

</GridLayout>
```

不用像相对布局那样写一堆相对谁谁谁的属性，直接按照网格结构往里填即可
**注意，网格的边线是对齐的，边线在哪里有时候可能取决于某个特定的控件**

**练习：学校实验内容**

手搓一个这样的页面
![[Pasted image 20241219164516.png]]

```xml
<GridLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:columnCount="4"
        android:id="@+id/main">

    <TextView
            android:text="Login From"
            android:layout_gravity="center_horizontal"
            android:layout_columnSpan="4"
            android:layout_rowSpan="2"
            android:textSize="40sp"
            android:layout_marginTop="10sp"
            android:textStyle="bold" />

    <TextView
            android:textSize="20sp"
            android:text="User Name:" />

    <EditText
            android:layout_columnSpan="2"
            android:ems="14"
            android:layout_gravity="fill" />

    <TextView
            android:layout_row="3"
            android:layout_column="0"
            android:layout_gravity="left"
            android:text="Password:"
            android:textSize="20sp" />

    <EditText
            android:layout_columnSpan="2"
            android:ems="14"
            android:layout_gravity="fill" />

    <Button
            android:layout_row="4"
            android:text="Login"
            android:layout_column="2" />


</GridLayout>
```

![[Pasted image 20241219172356.png|325]]


### 绝对布局

绝对布局也叫坐标布局
子视图通过属性`android:layout_x`和`android:layout_y` 来确定当前视图在屏幕上的位置，x,y就是坐标点 x轴的值和y轴的值
过于绝对，无法做到千人千面，不建议使用


### 帧布局

这个布局直接在屏幕上开辟出一块空白的区域,当我们往里面添加控件的时候,会默认把他们放到这块区域的左上角,而这种布局方式却没有任何的定位方式,所以它应用的场景并不多
帧布局的大小由控件中最大的子控件决定

略
### 约束布局

`ConstraintLayout`是`Android官方`在2016年Google的I/O大会推出的一种可以灵活控制子控件的位置和大小的新布局方式，也是目前Android的几大布局中功能最强大的布局。在最新版的`Android Studio中`，创建布局文件的默认根元素都是`ConstraintLayout`了。`ConstraintLayout`非常适合使用**可视化**的方式来编写界面，但并不太适合使用XML的方式来进行编写

https://guolin.blog.csdn.net/article/details/53122387
https://blog.csdn.net/huweiliyi/article/details/122894823


---
## 布局检查器

https://developer.android.google.cn/studio/debug/layout-inspector?hl=zh-cn

---
## 控件

常用控件：
>TextView(文本框)
>EditText(输入框)
>Button(按钮)
>ImageButton(图像按钮)
>ImageView(图像视图)
>RadioButton(单选按钮)
>Checkbox(复选框)
>Switch(开关)
>ToggleButton(开关按钮)
>ProgressBar(进度条)
>SeekBar(拖动条)
>RatingBar(星级评分条)
>ScrollView(滚动条)
>Date & Time组件
>**WebView(网页显示)**

### 进度条


**常用属性**

|          属性名          |                                      含义                                      |
| :-------------------: | :--------------------------------------------------------------------------: |
|         style         |                                   设置进度条的风格                                   |
|          max          |                                  设置该进度条的最大值                                  |
|       maxHeight       |                                 进度Widget最大高                                  |
|      miniHeight       |                                 进度Widget最小高                                  |
|       maxWidth        |                                 进度Widget最大宽                                  |
|       minWidth        |                                 进度Widget最小宽                                  |
|       progress        |                                设置该进度条的已完成进度值                                 |
|   progressDrawable    |                                自定义drawable显示                                 |
| indeteminateDrawable  |                           设置绘制不显示进度的进度条的Drawable对象                           |
|     indeterminate     |                            该属性设为true，设置进度条不精确显示进度                            |
| indeteminateDuration  |                                设置不精确显示进度的持续时间                                |
|   secondaryProgress   |     定义二级进度值，值介于0到max。该进度在主进度和背景之间。比如用于网络播放视频时，二级进度用于表示缓冲进度，主进度用于表示播放进度。      |
|     interpolator      |                                    设置动画速度                                    |
| indeterminateBehavior | 定义当进度达到最大时，不确定模式的表现；该值必须为repeat或者cycle，repeat表示进度从0重新开始；cycle表示进度保持当前值，并且回到0 |

**style属性：**
- @android:style/Widget.ProgressBar.Horizontal：水平进度条
- @android:style/Widget.ProgressBar.Inverse：普通大小的进度条
- @android:style/Widget.ProgressBar.Large：大环形进度条
- @android:style/Widget.ProgressBar.Large.Inverse：大环形进度条
- @android:style/Widget.ProgressBar.Small：小环形进度条
- @android:style/Widget.ProgressBar.Small.Inverse：小环形进度条

代码中常用逻辑：
```java
getMax() //返回这个进度条的范围的上限
getProgress() //返回进度
getsecondaryProgress() //返回二级进度
incrementProgressBy(int diff) //指定增加的进度
isIndeterminate() //指示进度条是否在不确定模式下
setIndeterminate(boolean indeterminate) //设置不确定模式下
setProgress(int progress) // 设置进度
```

```xml
<!--默认圆形加载条-->
<ProgressBar
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_gravity="center" />

<!--长条加载条-->
<ProgressBar
        style="@android:style/Widget.ProgressBar.Horizontal"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:indeterminate="true"
        android:layout_gravity="center" />

<!--不同主题长条加载条-->
<ProgressBar
        style="@style/Widget.AppCompat.ProgressBar.Horizontal"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:indeterminate="true"
        android:layout_gravity="center" />
```

![[Pasted image 20241223094617.png]]



要想实现真实的进度显示，需要利用多线程和`Hander`消息转发
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="16dp">

    <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="水平进度条"
            android:layout_marginTop="50dp"
            android:layout_gravity="center" />

    <ProgressBar
            android:id="@+id/progress_01"
            android:layout_width="match_parent"
            android:layout_height="30dp"
            android:max="100"
            android:layout_marginTop="100dp"
            android:padding="20dp"
            style="@style/Widget.AppCompat.ProgressBar.Horizontal" />

    <TextView
            android:id="@+id/tv_progress"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_below="@id/progress_01"
            android:layout_centerHorizontal="true" />
    
</LinearLayout>

```

```java
package com.learn;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;
import java.util.Random;

public class MainActivity extends AppCompatActivity {

    private ProgressBar mProgressBar;
    private TextView mTextView;
    private int start = 0, maxprogress;

    private final Handler mHandler = new Handler(Looper.getMainLooper()) {
        @Override
        public void handleMessage(@NonNull Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 0:
                    mTextView.setText(start + " %");  // 更新进度
                    mProgressBar.setProgress(start);
                    break;
            }
        }
    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mProgressBar = findViewById(R.id.progress_01);
        mTextView = findViewById(R.id.tv_progress);
        maxprogress = mProgressBar.getMax();
    }

    @Override
    protected void onStart() {
        super.onStart();
        // 启动线程加载
        new Thread() {
            @Override
            public void run() {
                while (true) {
                    try {
                        Thread.sleep(102);// 线程休眠
                        int a = new Random().nextInt(10);// 产生一个10以内的随机数
                        start += a;
                        if (start > maxprogress) {// 如果进程超过最大值
                            start = maxprogress;
                            mHandler.sendEmptyMessage(0);
                            break;
                        }
                        mHandler.sendEmptyMessage(0);// 在安卓里。我们不能直接在线程中更新UI，这里用Hander消息处理
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }.start();
    }
}

```


**PS：如何弹出一个对话框来显示加载条**

1. 使用 ProgressDialog（已被弃用，不推荐）
```java
ProgressDialog progressDialog = new ProgressDialog(this);
progressDialog.setMessage("正在加载...");
progressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER); // 旋转风格（没有进度条）
progressDialog.setIndeterminate(true); // 设置为不确定进度
progressDialog.setCancelable(false); // 设置为不可取消
progressDialog.show();

// 在操作完成后，记得关闭对话框
progressDialog.dismiss();
```

2. 使用 AlertDialog 与 ProgressBar 结合
```java
AlertDialog.Builder builder = new AlertDialog.Builder(this);
builder.setTitle("加载中").setMessage("loading...").setCancelable(false);  // 不允许用户点击外部取消对话框
// 创建进度条
ProgressBar progressBar = new ProgressBar(this);
progressBar.setIndeterminate(true);  // 设置为不确定模式（无具体进度显示）
// 将进度条添加到对话框
builder.setView(progressBar);
// 创建并显示对话框
AlertDialog dialog = builder.create();
dialog.show();
```

*待续*

---

## Adapter（适配器）

适配器是 UI 组件和数据之间的桥梁，**它帮助我们将数据填充到 UI 组件当中**
这是一种典型的`MVC`架构

> MVC 模式代表 Model-View-Controller（模型-视图-控制器） 模式。这种模式用于应用程序的分层开发。
- **Model（模型）** - 模型代表一个存取数据的对象或 JAVA POJO。它也可以带有逻辑，在数据变化时更新控制器。
- **View（视图）** - 视图代表模型包含的数据的可视化。
- **Controller（控制器）** - 控制器作用于模型和视图上。它控制数据流向模型对象，并在数据变化时更新视图。它使视图与模型分离开。

![[Pasted image 20241220144145.png]]

1. **ArrayAdapter**：适用于简单的数据源，如数组或列表。它将每个数据项转换为一个 `TextView` 或其他简单视图。
2. **SimpleAdapter**：用于将复杂的数据源（如 `List<Map<String, Object>>`）绑定到多个视图。
3. **Custom Adapter**：通过继承 `BaseAdapter` 或其他适配器类，可以创建自定义适配器以实现复杂的需求。
### LIstView

> `ListView` 是 Android 中的一种视图组件，用于显示可滚动的垂直列表。每个列表项都是一个视图对象，ListView 会通过适配器（Adapter）将数据绑定到这些视图对象上。它通常用于显示一组相似的数据，比如联系人列表、消息列表等。


#### ArrayAdapter
![[Pasted image 20241220150501.png|300]]

随便创建一个布局
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:id="@+id/main"
        android:layout_height="match_parent">


    <ListView
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:id="@+id/list_test" />
</LinearLayout>

```

实现代码：
```java
package com.learn;

import android.os.Bundle;
import android.os.VibrationAttributes;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        // 要显示的数据
        String[] strs = {"基神", "B神", "翔神", "曹神", "J神"};
        // 创建ArrayAdapter
        ArrayAdapter<String> adapter = new ArrayAdapter<String>
                (this, android.R.layout.simple_expandable_list_item_1, strs);
        // this：表示当前的上下文对象，即这个ArrayAdapter将被用于当前的Activity或Fragment中。
        // 获取ListView对象，通过调用setAdapter方法为ListView设置Adapter设置适配器
        ListView list_test = findViewById(R.id.list_test);
        list_test.setAdapter(adapter);
    }
}
```



说明：
1. 除了通过数组外，我们还可以写到一个数组资源文件中，比如：在res\valuse下创建一个数组资源的xml文件：**arrays.xml**：
```xml
<?xml version="1.0" encoding="utf-8"?>  
<resources>  
    <string-array name="myarray">  
    <item>语文</item>  
    <item>数学</item>  
    <item>英语</item>  
    </string-array>      
</resources>
```
之后在布局下加入：
```xml
<ListView
android:layout_width="match_parent"
android:layout_height="match_parent"
android:entries="@array/myarray"
android:id="@+id/list_test" />
```

mainactivity使用默认，即可达到下面的效果
![[Pasted image 20241220152501.png|350]]

当然也可以布局保持不变，mainactivity改成
```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this,
            R.array.myarray, android.R.layout.simple_list_item_multiple_choice);
    ListView list_test = findViewById(R.id.list_test);
    list_test.setAdapter(adapter);
}
```
2. 一开始也说了这个ArrayAdapter支持泛型，那么集合必不可少
```java
package com.learn;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ArrayList<String> list = new ArrayList<>();
        list.add("玩机器");
        list.add("6657");
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, list);
        ListView list_test = findViewById(R.id.list_test);
        list_test.setAdapter(adapter);
    }
}
```

![[Pasted image 20241220153720.png]]

3. 实例化ArrayAdapter的第二个参数：`android.R.layout.simple_expandable_list_item_1`其实这些是系统给我们提供好的一些ListView模板，其他的比如：
> `simple_list_item_1` : 单独一行的文本框

#### SimpleAdapter

> SimpleAdapter是Android中用于将数据模型转换成ListView或其他视图组件的适配器。它简化了数据绑定过程，通过映射数据集中的字段到布局文件中的视图

随便建一个页面布局
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/main"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <ListView
        android:id="@+id/lv"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

</LinearLayout>

```

在layout文件夹里面新建一个自定义的适配器模板

`list_item_layout`
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="horizontal">

    <ImageView
            android:id="@+id/image"
            android:layout_width="0dp"
            android:layout_height="100dp"
            android:layout_weight="1" />

    <TextView
            android:id="@+id/tv"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_weight="3" />

</LinearLayout>

```

记得在drawable中创建这三个图片![[banana.jpg|182]]![[apple.png|100]]![[machine.jpg|190]]

`MainActivity.java`
```java
package com.learn;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    private ListView mListView;
    private SimpleAdapter msimpleAdapter;
    private List<Map<String, Object>> mList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 初始化ListView
        mListView = findViewById(R.id.lv);
        // 初始化并填充列表数据
        mList = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            Map<String, Object> map1 = new HashMap<>();
            map1.put("image", R.drawable.apple);
            map1.put("text", "苹果");
            mList.add(map1);
            Map<String, Object> map2 = new HashMap<>();
            map2.put("image", R.drawable.banana);
            map2.put("text", "香蕉");
            mList.add(map2);
            Map<String, Object> map3 = new HashMap<>();
            map3.put("image", R.drawable.machine);
            map3.put("text", "玩机器");
            mList.add(map3);
        }

        // 使用SimpleAdapter绑定数据到ListView
        msimpleAdapter = new SimpleAdapter(this, mList, R.layout.list_item_layout,
                new String[]{"image", "text"}, new int[]{R.id.image, R.id.tv});
        mListView.setAdapter(msimpleAdapter);
    }
}
```

效果：
![[Pasted image 20241220215514.png|200]]


**说明：**
- `msimpleAdapter = new SimpleAdapter(this, mList, R.layout.list_item_layout,`
    
    `new String[]{"image", "text"}, new int[]{R.id.image, R.id.tv});`
    
    1. 创建了一个SimpleAdapter对象，用于将数据绑定到ListView上。
    2. `this`：上下文对象，表示当前的Activity或Fragment。
    3. `mList`：数据源，通常是一个List集合，包含了要展示的数据。
    4. `R.layout.list_item_layout`：不同于刚才安卓自带的，这里我们使用自己创建的布局，下面的两个参数`String[]`是刚才map数组中的键，`int[]`是自定义布局中对应的视图id
    5. `new String[]{"image", "text"}`：数据源中要展示的字段名数组，这里表示要展示名为"image"和"text"的字段。
    6. `new int[]{R.id.image, R.id.tv}`：对应字段在布局文件中的控件ID数组，这里表示字段"image"对应ID为R.id.image的ImageView控件，字段"text"对应ID为R.id.tv的TextView控件


#### BaseAdapter

最基础的适配器类，可以做任何事情，不过使用麻烦。


首先新建一个`ItemBean`类来存储数据，一般放在`entity.bean`包下
![[Pasted image 20241220221352.png]]

```java
package com.learn.entity.bean;

public class ItemBean {
    private String name;
    private int imageId;

    public ItemBean(String name, int imageId) {
        this.name = name;
        this.imageId = imageId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }
}

```

*如何快速构建这种bean类？*

> 使用`Ctrl + Alt + 上下键`可以触发多光标操作
> 使用`Alt + Ins`可以选择快速构建get和set方法以及构造函数

![[Jetbarins使用技巧.mp4]]

之后在controller包中新建一个适配器类
继承`BaseAdapter`类，自动生成四个重写方法
![[Pasted image 20241220222448.png]]

用`alt + enter`全选实现方法后编写代码
```java
package com.learn.controller;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.learn.R;
import com.learn.entity.bean.ItemBean;

import java.util.List;

/**
 * 自定义适配器，用于在ListView中显示物品列表。
 * 该适配器负责将数据集中的每个项目绑定到相应的视图上。
 */
public class MyAdapter extends BaseAdapter {
    // 存储物品数据的列表
    private List<ItemBean> mlist;
    // LayoutInflater用于从XML文件中加载布局
    private LayoutInflater mLayoutInflater;
    // 上下文对象，用于获取资源和进行其他上下文相关的操作
    private Context mcontext;

    /**
     * 构造函数初始化适配器。
     *
     * @param mlist    物品数据的列表
     * @param mcontext 上下文对象，用于初始化LayoutInflater
     */
    public MyAdapter(List<ItemBean> mlist, Context mcontext) {
        this.mlist = mlist;
        this.mcontext = mcontext;
        this.mLayoutInflater = LayoutInflater.from(mcontext);
    }

    // 返回数据集的大小
    @Override
    public int getCount() {
        return mlist.size();
    }

    // 根据位置获取数据集中的物品。
    @Override
    public Object getItem(int position) {
        return mlist.get(position);
    }

    // 获取物品在ListView中的唯一标识符
    @Override
    public long getItemId(int position) {
        return position;
    }

    /**
     * 为ListView的每个项目创建并返回一个视图。
     *
     * @param position    物品的位置
     * @param convertView 当前被重用的视图
     * @param parent      视图的父容器
     * @return 绑定到数据集中的视图
     */
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        // 使用LayoutInflater加载列表项的布局
        convertView = mLayoutInflater.inflate(R.layout.list_item_layout, parent, false);

        // 查找并初始化列表项中的ImageView和TextView
        ImageView img = convertView.findViewById(R.id.image);
        TextView tv = convertView.findViewById(R.id.tv);

        // 获取当前位置的物品数据,设置ImageView的图片资源
        ItemBean itemBean = mlist.get(position);
        img.setImageResource(itemBean.getImageId());
        tv.setText(itemBean.getName());

        return convertView;
    }
}


```

说明：
`convertView = mLayoutInflater.inflate(R.layout.list_item_layout, parent, false);`

`mLayoutInflater`通过构造方法处的`LayoutInflater.from(mcontext)`赋值

调用其`inflate`方法：
1. `convertView`: 这个变量通常用来存储从布局文件转换而来的`View`对象。在`ListView`或`RecyclerView`的`getView()`方法中，它会被检查是否为空。如果非空，那么会直接使用这个`View`对象来展示数据，以避免频繁创建新的`View`，从而提高性能。
2. `mLayoutInflater`: 这是一个`LayoutInflater`实例，它是Android框架提供的一个类，用于将XML布局文件转换为对应的View对象。
3. `R.layout.list_item_layout`: 这是一个资源ID，指向了XML布局文件`list_item_layout.xml`。这个布局文件定义了一个`ListView`或`RecyclerView`中单个item的外观和结构，包括控件的类型、大小、位置以及样式等。
4. `parent`: 这是一个`ViewGroup`类型的参数，代表了新创建的View最终将被添加到的父容器。在`ListView`或`RecyclerView`的情况下，`parent`就是`ListView`或`RecyclerView`本身。虽然在这个调用中，我们并没有立即把新创建的`View`添加到`parent`中（因为false参数），但这个参数还是需要的，因为它会影响`LayoutInflater`如何计算View的尺寸和位置。
5. `false`: 这个布尔值参数告诉`LayoutInflater`不要将生成的`View`添加到`parent`中。这是因为`ListView`或`RecyclerView`有自己的逻辑来管理子`View`的添加和移除，它们会在适当的时候将`View`添加到自己内部的`ViewGroup`中。

`MainActivity`
```java
package com.learn;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.appcompat.app.AppCompatActivity;

import com.learn.controller.MyAdapter;
import com.learn.entity.bean.ItemBean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MainActivity extends AppCompatActivity {
    private ListView mListView;
    private BaseAdapter mBaseAdapter;
    private List<ItemBean> mlist;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 初始化数据列表，这里使用了循环来添加多个数据项。
        mlist = new ArrayList<>();
        for (int i = 0; i < 20; i++) {
            ItemBean itemBean1 = new ItemBean("苹果", R.drawable.apple);
            ItemBean itemBean2 = new ItemBean("香蕉", R.drawable.banana);
            ItemBean itemBean3 = new ItemBean("玩机器6657", R.drawable.machine);
            mlist.add(itemBean1);
            mlist.add(itemBean2);
            mlist.add(itemBean3);
        }

        // 初始化ListView和其适配器
        mListView = findViewById(R.id.lv);
        mBaseAdapter = new MyAdapter(mlist, this);
        mListView.setAdapter(mBaseAdapter);
    }
}
```

效果：
![[Pasted image 20241220223721.png|225]]

根据编译器提示，这里的适配器建议我们使用`ViewHolder` 

### RecyclerView

> `RecyclerView`是官方在5.0之后新添加的控件，推出用来替代传统的`ListView`和`GridView`列表控件。
> 相对于 `ListView`，`RecyclerView` 提供了更多的功能和更好的性能。它引入了一些新的概念，如 `ViewHolder` 模式，更高效的滚动和动画支持，以及更灵活的布局管理器（`LayoutManager`）

*待续*

### 其他控件

#### Toast

> Toast是一种很方便的消息提示框,会在 屏幕中显示一个消息提示框,没任何按钮,也不会获得焦点，一段时间过后自动消失


**makeText()方法创建**
比如点击一个按钮，然后弹出Toast，用法： `Toast.makeText(this, "提示的内容", Toast.LENGTH_LONG).show();`
 `Toast.LENGTH_LONG` (显示时间)
- **类型**: `int`
- **说明**:
    - 这是 Toast 显示的持续时间。`Toast` 提供了两种预定义的常量：
        - `Toast.LENGTH_SHORT`：显示时间较短，通常为 2-3 秒。
        - `Toast.LENGTH_LONG`：显示时间较长，通常为 3-5 秒。

自定义一个Toast方法
```java
package com.learn;

import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.appcompat.app.AppCompatActivity;

import com.learn.controller.MyAdapter;
import com.learn.entity.bean.ItemBean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    // 自定义的 midToast 方法，用于显示定制化的 Toast 消息
    void midToast(String str, int showTime) {
        // 创建 Toast 对象，传入上下文、消息文本和显示时间
        Toast toast = Toast.makeText(this, str, showTime);

        // 设置 Toast 显示位置
        // Gravity.CENTER_VERTICAL | Gravity.CENTER_HORIZONTAL：让 Toast 在屏幕的中央显示
        // 0, 0：偏移量设置为 0，表示不做额外的位移，保持在屏幕中央
        toast.setGravity(Gravity.CENTER_VERTICAL | Gravity.CENTER_HORIZONTAL, 0, 0);

        // 获取 Toast 的 View（即 Toast 的内容视图）
        // 通过 android.R.id.message 找到显示消息文本的 TextView
        TextView v = (TextView) toast.getView().findViewById(android.R.id.message);

        // 设置 Toast 中显示的文本颜色为黄色
        v.setTextColor(Color.YELLOW);

        // 显示 Toast
        toast.show();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        midToast("Hello World!", Toast.LENGTH_SHORT);
    }
}
```

![[Pasted image 20241221145329.png|325]]


**注意**
这种方式在API23（安卓12）以上已经失效，因为`Toast` 的视图内容（`TextView`）的访问权限发生了变化。在 Android 12 及以上版本中，`Toast` 被认为是一个 **系统级别的 UI 组件**，其内容的访问权限可能被限制

对于字体设置，可以使用`SpannableString` 来设置字体颜色
对于自定义样式，可以使用自定义布局创建 Toast

*待续*

#### Notification(状态栏通知)

#### AlertDialog(对话框)

**基本使用流程**

- **Step 1**：创建`AlertDialog.Builder`对象；
- **Step 2**：调用`setIcon()`设置图标，`setTitle()`或`setCustomTitle()`设置标题；
- **Step 3**：设置对话框的内容：`setMessage()`还有其他方法来指定显示的内容；
- **Step 4**：调用`setPositive/Negative/NeutralButton()`设置：确定，取消，中立按钮；
- **Step 5**：调用`create()`方法创建这个对象，再调用`show()`方法将对话框显示出来；

*待续*

---
---


# 事件处理

当用户在程序界面执行各种操作时，应用程序需要为用户动作提供响应动作，这种响应动作需要通过事件处理来完成
除了介绍处理方式之外，还必须介绍多线程的相关知识

## 监听处理

响应用户的操作，然后在后台加上相应的操作。比如：我们点击了页面上的一个按钮，事件监听捕捉到了`点击`，然后再给出用户一种**反馈**
![[Pasted image 20241221153536.png|900]]

**写一个事件大致步骤为：**
- 进行`UI`设计
- 加载`UI`，获得控件
- `为该控件设置监听器`，监听用户的操作
- 用户触发事件源的监听器
- `生成对应事件对象`
- 将产生的事件对象作为参数`传入事件处理器`
- 对事件对象进行`判断`，`执行对应的事件的处理方法`

对于事件监听，有五种实现方式、


*举例，点击一个按钮，弹出一个`Toast`*
直接使用拖动方式创建一个带按钮的布局即可，id设置成`btn0`

### 直接使用匿名内部类

首先需要加载获取这个按钮控件
```java
private Button btn0;
btn0 = findViewById(R.id.btn0);
```

之后设置监听器，使用`setOnClickListener`函数，new一个匿名内部类，重写`onClick`方法
```java
btn0.setOnClickListener(new View.OnClickListener() {  
    @Override  
    public void onClick(View v) {  
        // 把V强转成Button类型  
        ((Button)v).setText("魔理沙");  
        Toast.makeText(getApplicationContext(), "Master Spark!", Toast.LENGTH_LONG).show();  
    }  
});
```

效果：
![[Pasted image 20241221162607.png|800]]

总体代码
```java
package com.learn;

import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.activity.EdgeToEdge;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.learn.controller.MyAdapter;
import com.learn.entity.bean.ItemBean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {
    private Button btn0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        btn0 = findViewById(R.id.btn0);
        btn0.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // 把V强转成Button类型
                ((Button) v).setText("魔理沙");
                Toast.makeText(getApplicationContext(), "Master Spark!", Toast.LENGTH_LONG).show();
            }
        });
    }
}
```

**其中，由于`OnClickListener`是一个函数式接口，也就是只有一个方法`onClick`，所以匿名内部类可以使用*Lambda表达式*实现**
```java
// 使用拉姆达表达式
btn0.setOnClickListener(v -> {
    // 把V强转成Button类型
    ((Button) v).setText("魔理沙");
    Toast.makeText(getApplicationContext(), "Master Spark!", Toast.LENGTH_LONG).show();
});
```

**匿名内部类是最常用的**

### 使用内部类

显而易见
```java
package com.learn;

import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.activity.EdgeToEdge;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.learn.controller.MyAdapter;
import com.learn.entity.bean.ItemBean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

    class BtnListener implements View.OnClickListener {
        @Override
        public void onClick(View v) {
            // 把V强转成Button类型
            ((Button) v).setText("魔理沙");
            Toast.makeText(getApplicationContext(), "Master Spark!", Toast.LENGTH_LONG).show();
        }
    }

    private Button btn0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        btn0 = findViewById(R.id.btn0);
        btn0.setOnClickListener(new BtnListener());
    }
}
```


### 使用外部类

不常用

`外部类`
```java
package com.learn;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.view.View;
import android.widget.Toast;

public class Test implements View.OnClickListener {
    Activity vv;

    public Test(Activity vv) {
        this.vv = vv;
    }

    @Override
    public void onClick(View v) {
        Toast.makeText(vv, "Test", Toast.LENGTH_LONG).show();
    }
}

```

```java
package com.learn;

import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.activity.EdgeToEdge;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.learn.controller.MyAdapter;
import com.learn.entity.bean.ItemBean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {


    private Button btn0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        btn0 = findViewById(R.id.btn0);
        btn0.setOnClickListener(new Test(this));
    }
}
```


### 直接使用Activity作为事件监听器

即用这个类直接实现`OnClickListener`接口，在这个类里面重写`onClick`方法即可：
```java
package com.learn;

import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.activity.EdgeToEdge;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.learn.controller.MyAdapter;
import com.learn.entity.bean.ItemBean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private Button btn0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        btn0 = findViewById(R.id.btn0);
        btn0.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        ((Button) v).setText("魔理沙");
        Toast.makeText(this, "Master Spark!", Toast.LENGTH_LONG).show();
    }
}
```

### 直接绑定到标签

```xml
<?xml version="1.0" encoding="utf-8" ?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        android:layout_width="match_parent"
        android:id="@+id/main"
        android:layout_height="match_parent">


    <Button
            android:text="Marisa"
            android:layout_width="131dp"
            android:textSize="25sp"
            android:layout_height="87dp"
            android:id="@+id/btn0"
            android:onClick="MyClick"
            android:layout_centerInParent="true" />
</RelativeLayout>

```

自定义方法，注意，必须是public
```java
public void MyClick(View v) {
    ((Button) v).setText("魔理沙");
    Toast.makeText(this, "Master Spark", Toast.LENGTH_SHORT).show();
}
```



我们给同一事件源设置了多个同种类型的监听器，会是怎么执行的呢？

**答案：** 系统会默认执行，给事件源最后设置的这一个监听器，其他监听器不会执行。在xml文件中设置的onClick属性是最先设置的监听器，那么当有同种类型的其他监听器的话，会执行其他的监听器。


---

## 回调处理

*待续*

---

## 多线程

| 分类   | 对应方法              | 推荐程度     | 特点/备注                     |
| ---- | ----------------- | -------- | ------------------------- |
| 基础使用 | 继承 Thread         | 一般       | 不灵活，需手动管理线程。              |
|      | 实现 Runnable       | 较推荐      | 比继承 Thread 更灵活。           |
|      | Handler           | 推荐       | 用于线程间通信，常用于主线程更新 UI。      |
| 复合使用 | AsyncTask         | 不推荐（已过时） | 简化异步任务，但生命周期管理差。          |
|      | HandlerThread     | 推荐       | 适合长时间运行的单任务线程。            |
|      | IntentService     | 不推荐（已过时） | 自动管理任务，现被 WorkManager 取代。 |
| 高级使用 | 线程池（ThreadPool）   | 推荐       | 适合高并发场景，管理线程更高效。          |
|      | RxJava            | 推荐       | 响应式编程，适合复杂任务链。            |
|      | Kotlin Coroutines | 强烈推荐     | 现代化、简洁、功能强大，未来趋势。         |

### 基础使用

- 继承Thread类
- 实现Runnable接口
- Handler
### 复合使用

- AsyncTask
- HandlerThread
- IntentService

### 高级使用

- 线程池（ThreadPool）

*待续*

---
---

# 四大组件

activity、service、content provider、broadcast receiver

## Activity

### 引言

> Activity是一个应用程序的组件，他在屏幕上提供了一个区域，允许用户在上面做一些交互性的操作， 比如打电话，照相，发送邮件，或者显示一个地图！Activity可以理解成一个绘制用户界面的窗口， 而这个窗口可以填满整个屏幕，也可能比屏幕小或者浮动在其他窗口的上方！

因此，我们知道：
1. Activity用来显示用户界面，用户可以交互
2. 一个App可以有多个Activity


### 基础

#### 概念与生命周期

![[Pasted image 20241222101600.png]]

https://developer.android.google.cn/guide/components/activities/activity-lifecycle?hl=zh-cn


**创建阶段**
- **`onCreate()`**：这是 Activity 生命周期的第一个方法。在 Activity 被创建时，系统会调用此方法。通常在此方法中进行初始化操作，例如设置视图、绑定数据等。
- **`onStart()`**：`onCreate()` 后调用，表示 Activity 已经对用户可见，但还没有处于前台与用户交互的状态。这个方法通常用于恢复在 `onPause()` 时保存的资源或数据。

 **激活阶段**
- **`onResume()`**：`onStart()` 后调用，表示 Activity 已经进入了前台并且开始与用户交互。此时，Activity 是活跃的，用户可以与其进行交互。

**暂停与停止阶段**
- **`onPause()`**：当系统需要回收资源时，或当用户导航到另一个 Activity 时，当前 Activity 会进入暂停状态。此时，用户无法与 Activity 交互，但 Activity 仍然在内存中。一般来说，这个方法会用于保存数据、暂停动画等。
- **`onStop()`**：当 Activity 不再对用户可见时，系统会调用该方法。此时，Activity 可能会被销毁或被暂时置于后台。此方法通常用于释放占用的资源，保存用户的状态，或者保存 Activity 的数据。

**销毁阶段**
- **`onRestart()`**：当 Activity 从停止状态恢复并重新变为可见时，系统会调用此方法。这个方法通常在 `onStop()` 和 `onStart()` 之间调用，用于恢复一些资源或者状态。
- **`onDestroy()`**：当 Activity 被销毁时，系统会调用此方法。此时可以清理 Activity 使用的所有资源，进行内存释放等操作。通常用于释放长时间占用的资源、停止后台线程等。


**Activity有四种状态**

| **状态**               | **描述**                                           | **特点**                                                | **常见回调方法**    |
| -------------------- | ------------------------------------------------ | ----------------------------------------------------- | ------------- |
| **运行状态 (Running)**   | Activity 正在前台运行，用户可见且可以与用户交互。                    | - 处于最前端，优先级最高  <br>- 未暂停或停止。                          | `onResume()`  |
| **暂停状态 (Paused)**    | Activity 部分可见，但失去焦点（例如有透明或半透明的 Activity 显示在其上方）。 | - 仍保持活动，可能会被系统回收资源  <br>- 用户不能与之交互。                   | `onPause()`   |
| **停止状态 (Stopped)**   | Activity 不可见，但未销毁（例如被另一个 Activity 完全覆盖）。         | - 保持实例和所有状态信息，但可能被系统回收  <br>- 如果需要再次显示，可能直接恢复而非重新创建。  | `onStop()`    |
| **销毁状态 (Destroyed)** | Activity 被销毁，释放了所有资源。                            | - 系统或用户主动关闭 Activity  <br>- 可能因配置更改（如屏幕旋转）或系统资源不足被销毁。 | `onDestroy()` |

**启动模式**

| **启动模式**           | **描述**                                                                         | **特点**                                                                                          | **使用场景**                                                                              |
| ------------------ | ------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| **standard**       | 默认模式，每次启动都会创建一个新的 Activity 实例，并将其压入任务栈。                                        | - 每次启动都创建新的实例  <br>- 没有任何复用逻辑  <br>- 通常用于需要多实例的场景。                                              | - 普通 Activity，无需特殊复用逻辑  <br>- 比如列表中每个条目打开新页面。                                         |
| **singleTop**      | 如果当前任务栈的栈顶已是该 Activity 实例，则复用此实例，不会创建新实例；否则创建新实例并压入栈中。                         | - 栈顶复用模式  <br>- 如果实例被复用，则调用 `onNewIntent()`  <br>- 只有栈顶 Activity 才会复用，栈中其他位置的相同 Activity 不会被复用。 | - 消息通知的点击（防止重复打开多余页面）  <br>- 比如用户点击多个通知时，不希望重复打开同一个页面。                                |
| **singleTask**     | 如果该 Activity 在任务栈中已经存在，则会复用它，并将它之上的所有 Activity 从栈中移除；否则创建新的任务栈并将其作为根 Activity。 | - 栈内复用模式  <br>- 如果实例被复用，则调用 `onNewIntent()`  <br>- 任务栈只会保留一个该 Activity 实例  <br>- 适合任务为单位的页面。    | - 启动页面、主页面等（每次启动都希望清空任务栈其他页面）  <br>- 比如：新闻 App 的主页 Activity，每次从通知启动时都希望返回主页面，而不是历史页面。 |
| **singleInstance** | 每次启动都创建一个全新的任务栈，并且整个任务栈中只有该 Activity，一个任务栈只服务于一个实例。                            | - 单例模式  <br>- 整个任务栈中只允许存在一个实例  <br>- 如果复用实例，则调用 `onNewIntent()`  <br>- 适用于需要与其他任务栈完全隔离的页面。      | - 播放器、拨号器等（需要独立任务栈，防止干扰）  <br>- 比如：视频播放器的独立 Activity，用户切换回来时仍然保持独立运行。                 |

#### 创建流程

![[Pasted image 20241222103255.png]]

> Android中的四大组件，只要你定义了，无论你用没用，都要在AndroidManifest.xml对 这个组件进行声明


**PS**
在用Android Studio生成重写函数的时候，发现有这样一个选项，其中oncreate有两个函数
```java
@Override
public void onCreate(Bundle savedInstanceState, PersistableBundle persistentState) {
    super.onCreate(savedInstanceState, persistentState);
}
```

之前代码中的只有一个函数
```java
@Override
public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
}
```

这是安卓5.0之后的新方法，要想启用这个方法，需要在`AndroidManifest.xml`配置文件中的`Activity`项中设置属性：
```xml
android:persistableMode="persistAcrossReboots"
```

然后我们的Activity就拥有了持久化的能力了，一般我们会搭配另外两个方法来使用：
```java
public void onSaveInstanceState(Bundle outState, PersistableBundle outPersistentState)
public void onRestoreInstanceState(Bundle savedInstanceState, PersistableBundle persistentState)
```

前一个方法会在下述情形中被调用:
> 点击home键回到主页或长按后选择运行其他程序按下电源键关闭屏幕启动新的Activity横竖屏切换时，肯定会执行，因为横竖屏切换的时候会先销毁Act，然后再重新创建 重要原则：当系统"未经你许可"时销毁了你的activity，则onSaveInstanceState会被系统调用， 这是系统的责任，因为它必须要提供一个机会让你保存你的数据（你可以保存也可以不保存）。

而后一个方法，和onCreate同样可以从取出前者保存的数据： 一般是在onStart()和onResume()之间执行,这是为了避免Act跳转而没有关闭， 然后不走onCreate()方法，而你又想取出保存数据

#### 横竖屏切换与状态保存的问题

*待续*

#### 系统常见Activity

*未验证*
```java
//1.拨打电话
// 给移动客服10086拨打电话
Uri uri = Uri.parse("tel:10086");
Intent intent = new Intent(Intent.ACTION_DIAL, uri);
startActivity(intent);

//2.发送短信
// 给10086发送内容为“Hello”的短信
Uri uri = Uri.parse("smsto:10086");
Intent intent = new Intent(Intent.ACTION_SENDTO, uri);
intent.putExtra("sms_body", "Hello");
startActivity(intent);

//3.发送彩信（相当于发送带附件的短信）
Intent intent = new Intent(Intent.ACTION_SEND);
intent.putExtra("sms_body", "Hello");
Uri uri = Uri.parse("content://media/external/images/media/23");
intent.putExtra(Intent.EXTRA_STREAM, uri);
intent.setType("image/png");
startActivity(intent);

//4.打开浏览器:
// 打开Google主页
Uri uri = Uri.parse("http://www.baidu.com");
Intent intent  = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//5.发送电子邮件:(阉割了Google服务的没戏!!!!)
// 给someone@domain.com发邮件
Uri uri = Uri.parse("mailto:someone@domain.com");
Intent intent = new Intent(Intent.ACTION_SENDTO, uri);
startActivity(intent);
// 给someone@domain.com发邮件发送内容为“Hello”的邮件
Intent intent = new Intent(Intent.ACTION_SEND);
intent.putExtra(Intent.EXTRA_EMAIL, "someone@domain.com");
intent.putExtra(Intent.EXTRA_SUBJECT, "Subject");
intent.putExtra(Intent.EXTRA_TEXT, "Hello");
intent.setType("text/plain");
startActivity(intent);
// 给多人发邮件
Intent intent=new Intent(Intent.ACTION_SEND);
String[] tos = {"1@abc.com", "2@abc.com"}; // 收件人
String[] ccs = {"3@abc.com", "4@abc.com"}; // 抄送
String[] bccs = {"5@abc.com", "6@abc.com"}; // 密送
intent.putExtra(Intent.EXTRA_EMAIL, tos);
intent.putExtra(Intent.EXTRA_CC, ccs);
intent.putExtra(Intent.EXTRA_BCC, bccs);
intent.putExtra(Intent.EXTRA_SUBJECT, "Subject");
intent.putExtra(Intent.EXTRA_TEXT, "Hello");
intent.setType("message/rfc822");
startActivity(intent);

//6.显示地图:
// 打开Google地图中国北京位置（北纬39.9，东经116.3）
Uri uri = Uri.parse("geo:39.9,116.3");
Intent intent = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//7.路径规划
// 路径规划：从北京某地（北纬39.9，东经116.3）到上海某地（北纬31.2，东经121.4）
Uri uri = Uri.parse("http://maps.google.com/maps?f=d&saddr=39.9 116.3&daddr=31.2 121.4");
Intent intent = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//8.多媒体播放:
Intent intent = new Intent(Intent.ACTION_VIEW);
Uri uri = Uri.parse("file:///sdcard/foo.mp3");
intent.setDataAndType(uri, "audio/mp3");
startActivity(intent);

//获取SD卡下所有音频文件,然后播放第一首=-= 
Uri uri = Uri.withAppendedPath(MediaStore.Audio.Media.INTERNAL_CONTENT_URI, "1");
Intent intent = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//9.打开摄像头拍照:
// 打开拍照程序
Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE); 
startActivityForResult(intent, 0);
// 取出照片数据
Bundle extras = intent.getExtras(); 
Bitmap bitmap = (Bitmap) extras.get("data");

//另一种:
//调用系统相机应用程序，并存储拍下来的照片
Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE); 
time = Calendar.getInstance().getTimeInMillis();
intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(new File(Environment
.getExternalStorageDirectory().getAbsolutePath()+"/tucue", time + ".jpg")));
startActivityForResult(intent, ACTIVITY_GET_CAMERA_IMAGE);

//10.获取并剪切图片
// 获取并剪切图片
Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
intent.setType("image/*");
intent.putExtra("crop", "true"); // 开启剪切
intent.putExtra("aspectX", 1); // 剪切的宽高比为1：2
intent.putExtra("aspectY", 2);
intent.putExtra("outputX", 20); // 保存图片的宽和高
intent.putExtra("outputY", 40); 
intent.putExtra("output", Uri.fromFile(new File("/mnt/sdcard/temp"))); // 保存路径
intent.putExtra("outputFormat", "JPEG");// 返回格式
startActivityForResult(intent, 0);
// 剪切特定图片
Intent intent = new Intent("com.android.camera.action.CROP"); 
intent.setClassName("com.android.camera", "com.android.camera.CropImage"); 
intent.setData(Uri.fromFile(new File("/mnt/sdcard/temp"))); 
intent.putExtra("outputX", 1); // 剪切的宽高比为1：2
intent.putExtra("outputY", 2);
intent.putExtra("aspectX", 20); // 保存图片的宽和高
intent.putExtra("aspectY", 40);
intent.putExtra("scale", true);
intent.putExtra("noFaceDetection", true); 
intent.putExtra("output", Uri.parse("file:///mnt/sdcard/temp")); 
startActivityForResult(intent, 0);

//11.打开Google Market 
// 打开Google Market直接进入该程序的详细页面
Uri uri = Uri.parse("market://details?id=" + "com.demo.app");
Intent intent = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//12.进入手机设置界面:
// 进入无线网络设置界面（其它可以举一反三）  
Intent intent = new Intent(android.provider.Settings.ACTION_WIRELESS_SETTINGS);  
startActivityForResult(intent, 0);

//13.安装apk:
Uri installUri = Uri.fromParts("package", "xxx", null);   
returnIt = new Intent(Intent.ACTION_PACKAGE_ADDED, installUri);

//14.卸载apk:
Uri uri = Uri.fromParts("package", strPackageName, null);      
Intent it = new Intent(Intent.ACTION_DELETE, uri);      
startActivity(it); 

//15.发送附件:
Intent it = new Intent(Intent.ACTION_SEND);      
it.putExtra(Intent.EXTRA_SUBJECT, "The email subject text");      
it.putExtra(Intent.EXTRA_STREAM, "file:///sdcard/eoe.mp3");      
sendIntent.setType("audio/mp3");      
startActivity(Intent.createChooser(it, "Choose Email Client"));

//16.进入联系人页面:
Intent intent = new Intent();
intent.setAction(Intent.ACTION_VIEW);
intent.setData(People.CONTENT_URI);
startActivity(intent);

//17.查看指定联系人:
Uri personUri = ContentUris.withAppendedId(People.CONTENT_URI, info.id);//info.id联系人ID
Intent intent = new Intent();
intent.setAction(Intent.ACTION_VIEW);
intent.setData(personUri);
startActivity(intent);
```

### 高级

#### Activity的数据传递

- 简单数据传递
	**Intent**
		Intent 是在 Android 中传递数据的最简单方法。它可以携带各种数据类型，包括字符串、数字和布尔值。使用 Intent 传递数据只需几个简单的步骤：
		在发送数据的 Activity 中，使用 `putExtra()` 方法将数据添加到 Intent 中。
		启动目标 Activity，将 Intent 作为参数传递。
		在目标 Activity 中，使用 `getIntent()` 方法获取 Intent，然后使用 `getExtra()` 方法检索数据。
	**Bundle**
		Bundle 与 Intent 类似，但它专门用于传递小块数据。与 Intent 相比，Bundle 的使用更加灵活，可以存储更复杂的数据结构，如哈希表和列表。

- 复杂自定义对象传递（序列化）*待续*
	**Serializable**
		Serializable 接口允许您传递自定义对象。要使用 Serializable，您需要实现该接口并在传递对象之前对其进行序列化。在目标 Activity 中，反序列化对象以访问数据。
	**Parcel**
		Parcel 是 Android 框架中用于高效序列化和反序列化对象的类。它比 Serializable 更高效，但需要更多的手动编码。

**note：**
- 对于简单的数据类型，优先使用 Intent 或 Bundle。
- 避免传递大数据，因为这可能会导致应用程序崩溃。
- 使用有意义的键来标识 Intent 和 Bundle 中的数据。
- 考虑使用单例模式来存储会话数据，以便在所有 Activity 中可用。
> 单例模式（Singleton Pattern）是一种设计模式，属于创建型模式。它的核心思想是确保一个类只有一个实例，并提供一个全局访问点来获取该实例。简而言之，单例模式确保某个类在整个应用程序中只有一个实例，并且这个实例可以被多个对象共享。

##### 简单传递

**学校实验内容**

手搓这个app
![[Pasted image 20241222150727.png|750]]

`activity_main`
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="20dp">

    <TextView
            android:text="请输入身高和选择性别"
            android:textSize="20sp"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content" />

    <RadioGroup
            android:orientation="horizontal"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content">

        <RadioButton
                android:id="@+id/rbMale"
                android:text="男"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content" />

        <RadioButton
                android:id="@+id/rbFemale"
                android:text="女"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content" />
    </RadioGroup>

    <EditText
            android:id="@+id/etHeight"
            android:hint="身高 (cm)"
            android:inputType="numberDecimal"
            android:layout_width="match_parent"
            android:layout_height="wrap_content" />

    <Button
            android:id="@+id/btnCalculate"
            android:text="计算标准体重"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content" />
</LinearLayout>

```

`activity_new`
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="20dp">

    <TextView
            android:id="@+id/tvResult"
            android:textSize="18sp"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content" />

    <Button
            android:id="@+id/btnBack"
            android:text="返回"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content" />
</LinearLayout>

```

**记得在清单文件中宣布新的act，不然会崩溃**
```xml
<activity  
        android:name=".NewActivity"  
        android:exported="true" />
```


**只使用Intent**

`MainActivity` -> `NewActivity`

- 发数据
```java
Intent intent = new Intent(MainActivity.this, NewActivity.class);
intent.putExtra("key", value);
startActivity(intent)
```

- 收数据
```java
Intent intent = getIntent();
// 同样键值对模式，第二个参数代表默认值
类型 data = intent.getxxxExtra("key", 0);
```

完整代码
```java
package com.learn;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    private EditText etHeight;
    private RadioButton rbMale;
    private RadioButton rbFemale;
    private Button btnCalculate;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 初始化控件
        etHeight = findViewById(R.id.etHeight);
        rbMale = findViewById(R.id.rbMale);
        rbFemale = findViewById(R.id.rbFemale);
        btnCalculate = findViewById(R.id.btnCalculate);

        // 设置按钮点击事件
        btnCalculate.setOnClickListener(v -> {
            // 获取输入的身高
            String heightStr = etHeight.getText().toString().trim();
            if (heightStr.isEmpty()) {
                etHeight.setError("请输入身高");
                return;
            }

            // 转换身高为数字
            double height = Double.parseDouble(heightStr);

            // 获取性别
            String sex = "";
            if (rbMale.isChecked()) {
                sex = "M";  // 男性
            } else if (rbFemale.isChecked()) {
                sex = "F";  // 女性
            } else {
                Toast.makeText(MainActivity.this, "请选择性别", Toast.LENGTH_SHORT).show();
                return;
            }

            // 创建 Intent 并传递数据
            Intent intent = new Intent(MainActivity.this, NewActivity.class);
            intent.putExtra("height", height);
            intent.putExtra("sex", sex);
            startActivity(intent);
        });
    }
}

```

```java
package com.learn;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class NewActivity extends AppCompatActivity {
    private TextView tvResult;
    private Button btnBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new);

        // 初始化控件
        tvResult = findViewById(R.id.tvResult);
        btnBack = findViewById(R.id.btnBack);

        // 获取传递过来的数据
        Intent intent = getIntent();
        double height = intent.getDoubleExtra("height", 0);
        String sex = intent.getStringExtra("sex");

        // 根据性别计算标准体重
        String sexText = sex.equals("M") ? "男性" : "女性";
        String weight = (sex.equals("M")) ? String.format("%.2f", (height - 80) * 0.7) : String.format("%.2f", (height - 70) * 0.6);

        // 显示结果
        tvResult.setText("你是一位" + sexText + "\n身高: " + height + " cm\n标准体重: " + weight + " kg");

        // 返回按钮事件
        btnBack.setOnClickListener(v -> finish());
    }
}

```


**利用Bundle**

`MainActivity` -> `NewActivity`

- 发数据
```java
Intent intent = new Intent(MainActivity.this, NewActivity.class);
Bundle bundle = new Bundle();
bundle.putxxx("k1", v1);
bundle.putxxx("k2", v2);
intent.putExtra(bundle);
startActivity(intent)
```

- 收数据
```java
Intent intent = getIntent();
Bundle bundle = intent.getExtras();
// 同样键值对模式，第二个参数代表默认值
类型 data = bundle.getxxx("k", 0);
```

完整代码，这里把发数据的过程用方法封装
```java
package com.learn;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    private EditText etHeight;
    private RadioButton rbMale;
    private RadioButton rbFemale;
    private Button btnCalculate;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 初始化控件
        etHeight = findViewById(R.id.etHeight);
        rbMale = findViewById(R.id.rbMale);
        rbFemale = findViewById(R.id.rbFemale);
        btnCalculate = findViewById(R.id.btnCalculate);

        // 设置按钮点击事件
        btnCalculate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // 获取输入的身高
                String heightStr = etHeight.getText().toString().trim();
                if (heightStr.isEmpty()) {
                    etHeight.setError("请输入身高");
                    return;
                }

                // 转换身高为数字
                double height = Double.parseDouble(heightStr);

                // 获取性别
                String sex = "";
                if (rbMale.isChecked()) {
                    sex = "M";  // 男性
                } else if (rbFemale.isChecked()) {
                    sex = "F";  // 女性
                } else {
                    Toast.makeText(MainActivity.this, "请选择性别", Toast.LENGTH_SHORT).show();
                    return;
                }

                // 使用 Bundle 传递数据
                Bundle bundle = new Bundle();
                bundle.putDouble("height", height);
                bundle.putString("sex", sex);

                // 启动 NewActivity，并通过 Bundle 传递数据
                NewActivity.startActivityWithBundle(MainActivity.this, bundle);
            }
        });
    }
}

```

```java
package com.learn;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class NewActivity extends AppCompatActivity {
    private TextView tvResult;
    private Button btnBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new);

        // 初始化控件
        tvResult = findViewById(R.id.tvResult);
        btnBack = findViewById(R.id.btnBack);

        // 获取传递过来的 Bundle 数据
        Bundle bundle = getIntent().getExtras();
        if (bundle != null) {
            double height = bundle.getDouble("height", 0);
            String sex = bundle.getString("sex");

            // 根据性别计算标准体重
            String sexText = sex.equals("M") ? "男性" : "女性";
            String weight = (sex.equals("M")) ? String.format("%.2f", (height - 80) * 0.7) : String.format("%.2f", (height - 70) * 0.6);

            // 显示结果
            tvResult.setText("你是一位" + sexText + "\n身高: " + height + " cm\n标准体重: " + weight + " kg");
        }

        // 返回按钮事件
        btnBack.setOnClickListener(v -> finish());
    }

    // 用静态方法简化 Activity 启动
    public static void startActivityWithBundle(MainActivity mainActivity, Bundle bundle) {
        Intent intent = new Intent(mainActivity, NewActivity.class);
        intent.putExtras(bundle);
        mainActivity.startActivity(intent);
    }
}

```



前面提到，`Bundle`可以存储更复杂的数据结构，下面是一个传递`ArrayList`的例子

![[Pasted image 20241222153224.png]]

![[Pasted image 20241222153236.png]]

`activity_main`
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="16dp">

    <Button
            android:id="@+id/button"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Send ArrayList" />
</LinearLayout>

```

`activity_new`
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="16dp">

    <TextView
            android:id="@+id/textView"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="18sp" />
</LinearLayout>

```

`MainActivity`
```java
package com.learn;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private Button button;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        button = findViewById(R.id.button);

        // 创建一个 ArrayList 数据
        ArrayList<String> itemList = new ArrayList<>();
        itemList.add("Item 1");
        itemList.add("Item 2");
        itemList.add("Item 3");

        // 设置按钮点击事件，发送数据到另一个 Activity
        button.setOnClickListener(v -> {
            // 创建 Bundle 来封装数据
            Bundle bundle = new Bundle();
            bundle.putStringArrayList("itemList", itemList);

            // 创建 Intent 并将 Bundle 添加到 Intent 中
            Intent intent = new Intent(MainActivity.this, NewActivity.class);
            intent.putExtras(bundle);

            // 启动目标 Activity
            startActivity(intent);
        });
    }
}

```

`NewActivity`
```java
package com.learn;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class NewActivity extends AppCompatActivity {
    private TextView textView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new);

        textView = findViewById(R.id.textView);

        // 获取传递过来的数据
        Bundle bundle = getIntent().getExtras();
        if (bundle != null) {
            ArrayList<String> itemList = bundle.getStringArrayList("itemList");

            if (itemList != null) {
                // 显示 ArrayList 的内容
                StringBuilder stringBuilder = new StringBuilder();
                for (String item : itemList) {
                    stringBuilder.append(item).append("\n");
                }
                textView.setText(stringBuilder.toString());
            }
        }
    }
}

```

##### 序列化数据传递

*待续*



#### 多个Activity间的交互(后一个传回给前一个)
*待续*


### 进阶

*待续*


---

## Service

### 概述

服务与线程没有太大的关系，服务允许开发者执行后台任务，而无需用户界面

服务一旦被启动将在后台一直运行，即使启动服务的组件（Activity）已销毁也不受影响。 此外，组件可以绑定到服务，以与之进行交互，甚至是执行进程间通信 (IPC)。 例如，服务可以处理网络事务、播放音乐，执行文件 I/O 或与内容提供程序交互，而所有这一切均可在后台进行，Service基本上分为两种形式：

- 启动状态
  当应用组件（如 Activity）通过调用 startService() 启动服务时，服务即处于“启动”状态。一旦启动，服务即可在后台无限期运行，即使启动服务的组件已被销毁也不受影响，除非手动调用才能停止服务， 已启动的服务通常是执行单一操作，而且不会将结果返回给调用方。

- 绑定状态
  当应用组件通过调用 bindService() 绑定到服务时，服务即处于“绑定”状态。绑定服务提供了一个客户端-服务器接口，允许组件与服务进行交互、发送请求、获取结果，甚至是利用进程间通信 (IPC) 跨进程执行这些操作。 仅当与另一个应用组件绑定时，绑定服务才会运行。 多个组件可以同时绑定到该服务，但全部取消绑定后，该服务即会被销毁。

![[Pasted image 20241223111328.png]]

---

### 清单声明

```xml
<service android:enabled=["true" | "false"]
    android:exported=["true" | "false"]
    android:icon="drawable resource"
    android:isolatedProcess=["true" | "false"]
    android:label="string resource"
    android:name="string"
    android:permission="string"
    android:process="string" >
    . . .
</service>
```

- android:exported：代表是否能被其他应用隐式调用，其默认值是由service中有无intent-filter决定的，如果有intent-filter，默认值为true，否则为false。为false的情况下，即使有intent-filter匹配，也无法打开，即无法被其他应用隐式调用。
- android:name：对应Service类名
- android:permission：是权限声明
- android:process：是否需要在单独的进程中运行,当设置为android:process=”:remote”时，代表Service在单独的进程中运行。注意“：”很重要，它的意思是指要在当前进程名称前面附加上当前的包名，所以“remote”和”:remote”不是同一个意思，前者的进程名称为：remote，而后者的进程名称为：App-packageName:remote。
- android:isolatedProcess ：设置 true 意味着，服务会在一个特殊的进程下运行，这个进程与系统其他进程分开且没有自己的权限。与其通信的唯一途径是通过服务的API(bind and start)。
- android:enabled：是否可以被系统实例化，默认为 true因为父标签 也有 enable 属性，所以必须两个都为默认值 true 的情况下服务才会被激活，否则不会激活。

---

### 服务使用

Android中使用Service的方式有两种：

> 1）**StartService()启动Service**  
> 2）**BindService()启动Service**  
> PS:还有一种，就是启动Service后，绑定Service！


#### 启动服务

首先要创建服务，必须创建 Service 的子类（或使用它的一个现有子类如IntentService）。在实现中，我们需要重写一些回调方法，以处理服务生命周期的某些关键过程

```java
package com.learn;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

public class SimpleService extends Service {

    /**
     * 绑定服务时才会调用
     * 必须要实现的方法
     *
     * @param intent
     * @return
     */
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    /**
     * 首次创建服务时，系统将调用此方法来执行一次性设置程序（在调用 onStartCommand() 或 onBind() 之前）。
     * 如果服务已在运行，则不会调用此方法。该方法只被调用一次
     */
    @Override
    public void onCreate() {
        System.out.println("onCreate invoke");
        super.onCreate();
    }

    /**
     * 每次通过startService()方法启动Service时都会被回调。
     *
     * @param intent
     * @param flags
     * @param startId
     * @return
     */
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        System.out.println("onStartCommand invoke");
        return super.onStartCommand(intent, flags, startId);
    }

    /**
     * 服务销毁时的回调
     */
    @Override
    public void onDestroy() {
        System.out.println("onDestroy invoke");
        super.onDestroy();
    }
}
```

从上面的代码我们可以看出`SimpleService`继承了`Service`类，并重写了`onBind`方法，该方法是**必须重写**的，但是由于此时是启动状态的服务，则该方法无须实现，返回null即可，只有在绑定状态的情况下才需要实现该方法并返回一个`IBinder`的实现类（这个后面会详细说），接着重写了`onCreate`、`onStartCommand`、`onDestroy`三个主要的生命周期方法，关于这几个方法说明如下:

- **onBind()**
  当另一个组件想通过调用 bindService() 与服务绑定（例如执行 RPC）时，系统将调用此方法。在此方法的实现中，必须返回 一个IBinder 接口的实现类，供客户端用来与服务进行通信。无论是启动状态还是绑定状态，此方法必须重写，但在启动状态的情况下直接返回 null。

- **onCreate()**
  首次创建服务时，系统将调用此方法来执行一次性设置程序（在调用 onStartCommand() 或onBind() 之前）。如果服务已在运行，则不会调用此方法，该方法只调用一次

- **onStartCommand()**
  当另一个组件（如 Activity）通过调用 startService() 请求启动服务时，系统将调用此方法。一旦执行此方法，服务即会启动并可在后台无限期运行。 如果自己实现此方法，则需要在服务工作完成后，通过调用 stopSelf() 或 stopService() 来停止服务。（在绑定状态下，无需实现此方法。）

- **onDestroy()**
  当服务不再使用且将被销毁时，系统将调用此方法。服务应该实现此方法来清理所有资源，如线程、注册的侦听器、接收器等，这是服务接收的最后一个调用。


可以写一段程序验证一下服务启动的时候的回调状态与顺序，布局中新建两个按钮，MainActivity代码如下：
```java
package com.learn;

import android.content.Intent;
import android.os.Bundle;

import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;


public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private Button startBtn;
    private Button stopBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        startBtn = findViewById(R.id.startService);
        stopBtn = findViewById(R.id.stopService);
        startBtn.setOnClickListener(this);
        stopBtn.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        Intent it = new Intent(this, SimpleService.class);
        if (v.getId() == R.id.startService) {
            startService(it);
        } else if (v.getId() == R.id.stopService) {
            stopService(it);
        }
    }
}
```

不要忘记配置清单
```xml
<manifest ... >
  ...
  <application ... >
      <service android:name=".service.SimpleService" />
      ...
  </application>
</manifest>
```

点击按钮，观察服务启动状态
![[Pasted image 20241223130709.png]]

如上面所言，onCreate是首次回调，onStartCommand每次启动都会回调

> 从代码看出，启动服务使用`startService(Intent intent)`方法，仅需要传递一个**Intent对象**即可，在Intent对象中指定需要启动的服务。而使用`startService()`方法启动的服务，在服务的**外部**，必须使用`stopService()`方法停止，在服务的**内部**可以调用`stopSelf()`方法停止当前服务。如果使用`startService()`或者`stopSelf()`方法请求停止服务，系统会就会尽快销毁这个服务。值得注意的是对于启动服务，一旦启动，将与访问它的组件无任何关联，即使访问它的组件被销毁了，这个服务也一直运行下去，直到手动调用停止服务才被销毁，至于`onBind`方法，只有在绑定服务时才会起作用，在启动状态下，无需关注此方法


下面，让我们回过头来解析一下`onStartCommand`函数

**onStartCommand（Intent intent, int flags, int startId）**

- **intent** ：启动时，启动组件传递过来的Intent，如Activity可利用Intent封装所需要的参数并**传递**给Service
    
- **flags**：表示启动请求时是否有额外数据，可选值有 `0`，`START_FLAG_REDELIVERY`，`START_FLAG_RETRY`，0代表没有，它们具体含义如下：
    - **START_FLAG_REDELIVERY**  
        这个值代表了onStartCommand方法的返回值为  
        `START_REDELIVER_INTENT`，而且在上一次服务被杀死前会去调用stopSelf方法停止服务。其中`START_REDELIVER_INTENT`意味着当Service因内存不足而被系统kill后，则会重建服务，并通过传递给服务的最后一个 Intent 调用 onStartCommand()，此时Intent时有值的。
    - **START_FLAG_RETRY**  
        该flag代表当onStartCommand调用后一直没有返回值时，会尝试重新去调用onStartCommand()。

*例子：*
```java
@Override
public int onStartCommand(Intent intent, int flags, int startId) {
    if (flags == START_FLAG_REDELIVERY) {
        // 重新传递了 Intent，可能是服务被杀死后重建
        Log.d("MyService", "Service is being redeployed with the last intent.");
    } else if (flags == START_FLAG_RETRY) {
        // 表示需要重试
        Log.d("MyService", "Service is retrying operation.");
    }
    return START_NOT_STICKY;
}
```

- **startId** ： 指明当前服务的唯一ID，与stopSelfResult (int startId)配合使用，stopSelfResult 可以更安全地根据ID停止服务。

*例子：*
```java
@Override
public int onStartCommand(Intent intent, int flags, int startId) {
    Log.d("MyService", "Service started with startId: " + startId);

    // 假设做一些操作
    new Thread(() -> {
        // 执行任务
        // 完成后停止当前服务
        stopSelfResult(startId);
    }).start();

    return START_NOT_STICKY;
}
```

实际上onStartCommand的返回值int类型才是最最值得注意的，它有三种可选值， `START_STICKY`，`START_NOT_STICKY`，`START_REDELIVER_INTENT`，它们具体含义如下：

- **START_STICKY**  
      当Service因内存不足而被系统kill后，一段时间后内存再次空闲时，系统将会尝试重新创建此Service，一旦创建成功后将回调onStartCommand方法，但其中的Intent将是null，除非有挂起的Intent，如pendingintent，这个状态下比较适用于不执行命令、但无限期运行并等待作业的媒体播放器或类似服务。
    
- **START_NOT_STICKY**  
      当Service因内存不足而被系统kill后，即使系统内存再次空闲时，系统也不会尝试重新创建此Service。除非程序中再次调用startService启动此Service，这是最安全的选项，可以避免在不必要时以及应用能够轻松重启所有未完成的作业时运行服务。
    
- **START_REDELIVER_INTENT**  
      当Service因内存不足而被系统kill后，则会重建服务，并通过传递给服务的最后一个 Intent 调用 onStartCommand()，任何挂起 Intent均依次传递。与START_STICKY不同的是，其中的传递的Intent将是非空，是最后一次调用startService中的intent。这个值适用于主动执行应该立即恢复的作业（例如下载文件）的服务。


#### 绑定服务

绑定服务是Service的另一种变形，当Service处于绑定状态时，其代表着`客户端-服务器`接口中的**服务器**

当其他组件（如 Activity）绑定到服务时（有时我们可能需要从Activity组件中去调用Service中的方法，此时Activity以绑定的方式挂靠到Service后，我们就可以轻松地访问到Service中的指定方法），组件（如Activity）可以向Service（也就是服务端）发送请求，或者调用Service（服务端）的方法，此时被绑定的Service（服务端）会接收信息并响应，甚至可以通过绑定服务进行执行进程间通信 (即IPC，这个后面再单独分析)

与启动服务不同的是**绑定服务的生命周期通常只在为其他应用组件(如Activity)服务时处于活动状态，不会无限期在后台运行**，也就是说宿主(如Activity)解除绑定后，绑定服务就会被销毁

要想运行绑定服务，我们必须提供一个`IBinder`接口的实现类，该类用以提供客户端用来与服务进行交互的编程接口，该接口可以通过三种方法定义接口：

- **扩展 Binder 类**  
	如果服务是提供给自有应用专用的，并且Service(服务端)与客户端在**相同的进程**中运行（常见情况），则应通过扩展 Binder 类并从 `onBind()` 返回它的一个实例来创建接口。客户端收到 Binder 后，可利用它直接访问 Binder 实现中以及Service中可用的公共方法。如果我们的服务只是自有应用的后台工作线程，则优先采用这种方法。 *不采用该方式创建接口的唯一情况是，服务被其他应用或不同的进程调用*
    
- **使用 Messenger**  
    Messenger可以翻译为信使，通过它可以在不同的进程中共传递Message对象(Handler中的Messager，因此 Handler 是 Messenger 的基础)，在Message中可以存放我们需要传递的数据，然后在进程间传递。如果需要让接口跨不同的进程工作，则可使用 Messenger 为服务创建接口，客户端就可利用 Message 对象向服务发送命令。同时客户端也可定义自有 Messenger，以便服务回传消息。这是执行进程间通信 (IPC) 的最简单方法，因为 Messenger 会在单一线程中创建包含所有请求的队列，也就是说Messenger是以串行的方式处理客户端发来的消息，这样我们就不必对服务进行线程安全设计了。
    
- ***使用 AIDL***
    *由于Messenger是以串行的方式处理客户端发来的消息，如果当前有大量消息同时发送到Service(服务端)，Service仍然只能一个个处理，这也就是Messenger跨进程通信的缺点了，因此如果有大量并发请求，Messenger就会显得力不从心了，这时AIDL（Android 接口定义语言）就派上用场了， 但实际上Messenger 的跨进程方式其底层实现就是AIDL，只不过android系统帮我们封装成透明的Messenger罢了 。因此，如果我们想让服务同时处理多个请求，则应该使用 AIDL。 在此情况下，服务必须具备多线程处理能力，并采用线程安全式设计。使用AIDL必须创建一个定义编程接口的 .aidl 文件。Android SDK 工具利用该文件生成一个实现接口并处理 IPC 的抽象类，随后可在服务内对其进行扩展。*



##### 扩展 Binder 类

前面描述过，如果我们的服务仅供本地应用使用，不需要跨进程工作，则可以实现自有 Binder 类，让客户端通过该类直接访问服务中的公共方法。其使用开发步骤如下

1. 创建BindService服务端，继承自Service，并在类中创建一个实现IBinder 接口的实例对象并提供公共方法给客户端调用
2. 从 onBind() 回调方法返回此 Binder 实例。
3. 在客户端中，从 onServiceConnected() 回调方法接收 Binder，并使用提供的方法调用绑定服务。

注意：此方式只有在客户端和服务位于同一应用和进程内才有效，如对于需要将 Activity 绑定到在后台播放音乐的自有服务的音乐应用，此方式非常有效。另一点之所以要求服务和客户端必须在同一应用内，是为了便于客户端转换返回的对象和正确调用其 API。服务和客户端还必须在同一进程内，因为此方式不执行任何跨进程编组


*例程*

`服务实现BindService.java`
```java
package com.learn;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

public class BindService extends Service {
    private final static String TAG = "kmj";
    private int count;
    private boolean quit;
    private Thread thread;

    /**
     * 创建Binder对象，返回给客户端即Activity使用，提供数据交换的接口
     */
    public class LocalBinder extends Binder {
        // 声明一个方法，getService。（提供给客户端调用）
        BindService getService() {
            // 返回当前对象BindService,这样我们就可在客户端端调用Service的公共方法了
            return BindService.this;
        }
    }

    /**
     * 把LocalBinder类的实例返回给客户端
     */
    @Override
    public IBinder onBind(Intent intent) {
        Log.i(TAG, "Service is invoke onBind");
        return new LocalBinder();
    }


    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "Service is invoke Created");
        thread = new Thread(new Runnable() {
            @Override
            public void run() {
                // 每间隔一秒count加1 ，直到quit为true。
                while (!quit) {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    count++;
                }
            }
        });
        thread.start();
    }

    /**
     * 公共方法
     *
     * @return
     */
    public int getCount() {
        return count;
    }

    /**
     * 解除绑定时调用
     *
     * @return
     */
    @Override
    public boolean onUnbind(Intent intent) {
        Log.i(TAG, "Service is invoke onUnbind");
        return super.onUnbind(intent);
    }

    @Override
    public void onDestroy() {
        Log.i(TAG, "Service is invoke Destroyed");
        this.quit = true;
        super.onDestroy();
    }
}
```

`BindService`类继承自`Service`，在该类中创建了一个`LocalBinder`继承自`Binder`类，`LocalBinder`中声明了一个`getService`方法，客户端可访问该方法获取`BindService`对象的实例，只要客户端获取到`BindService`对象的实例，就可调用`BindService`服务端的公共方法，如`getCount`方法

值得注意的是，我们在`onBind`方法中返回了`LocalBinder`的具体实例，而该实例最终会返回给客户端，客户端通过返回的实例对象便可以与服务端实现交互


`客户端实现MainActivity`
```java
package com.learn;

import android.app.Service;
import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;

import android.os.IBinder;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;


public class MainActivity extends AppCompatActivity {
    protected static final String TAG = "kmj";
    Button btnBind;
    Button btnUnBind;
    Button btnGetDatas;
    /**
     * ServiceConnection代表与服务的连接，它只有两个方法，
     * onServiceConnected和onServiceDisconnected，
     * 前者是在操作者在连接一个服务成功时被调用，而后者是在服务崩溃或被杀死导致的连接中断时被调用
     */
    private ServiceConnection conn;
    private BindService mService;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btnBind = (Button) findViewById(R.id.BindService);
        btnUnBind = (Button) findViewById(R.id.unBindService);
        btnGetDatas = (Button) findViewById(R.id.getServiceDatas);
        // 创建绑定对象
        final Intent intent = new Intent(this, BindService.class);

        // 开启绑定
        btnBind.setOnClickListener(v -> {
            Log.d(TAG, "绑定调用：bindService");
            // 调用绑定方法
            bindService(intent, conn, Service.BIND_AUTO_CREATE);
        });
        // 解除绑定
        btnUnBind.setOnClickListener(v -> {
            Log.d(TAG, "解除绑定调用：unbindService");
            // 解除绑定
            if (mService != null) {
                mService = null;
                unbindService(conn);
            }
        });

        // 获取数据
        btnGetDatas.setOnClickListener(v -> {
            if (mService != null) {
                // 通过绑定服务传递的Binder对象，获取Service暴露出来的数据
                Log.d(TAG, "从服务端获取数据：" + mService.getCount());
            } else {
                Log.d(TAG, "还没绑定呢，先绑定,无法从服务端获取数据");
            }
        });


        conn = new ServiceConnection() {
            /**
             * 与服务器端交互的接口方法 绑定服务的时候被回调，在这个方法获取绑定Service传递过来的IBinder对象，
             * 通过这个IBinder对象，实现宿主和Service的交互。
             */
            @Override
            public void onServiceConnected(ComponentName name, IBinder service) {
                Log.d(TAG, "绑定成功调用：onServiceConnected");
                // 获取Binder
                BindService.LocalBinder binder = (BindService.LocalBinder) service;
                mService = binder.getService();
            }

            /**
             * 当取消绑定的时候被回调。但正常情况下是不被调用的，它的调用时机是当Service服务被意外销毁时，
             * 例如内存的资源不足时这个方法才被自动调用。
             */
            @Override
            public void onServiceDisconnected(ComponentName name) {
                mService = null;
            }
        };
    }
}
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:gravity="center"
        android:orientation="vertical">

    <Button
            android:id="@+id/BindService"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="BindService" />

    <Button
            android:id="@+id/unBindService"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="UnBindService" />

    <Button
            android:id="@+id/getServiceDatas"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="GetServiceDatas" />
</LinearLayout>

```

在客户端中我们创建了一个ServiceConnection对象，该代表与服务的连接，它只有两个方法， `onServiceConnected`和`onServiceDisconnected`，其含义如下：
- **onServiceConnected(ComponentName name, IBinder service)**  
    系统会调用该方法以传递服务的　onBind() 方法返回的 IBinder。其中service便是服务端返回的IBinder实现类对象，通过该对象我们便可以调用获取BindService实例对象，进而调用服务端的公共方法。而ComponentName是一个封装了组件(Activity, Service, BroadcastReceiver, or ContentProvider)信息的类，如包名，组件描述等信息，较少使用该参数。

- **onServiceDisconnected(ComponentName name)**  
    Android 系统会在与服务的连接意外中断时（例如当服务崩溃或被终止时）调用该方法。注意:当客户端取消绑定时，系统“绝对不会”调用该方法。


在onServiceConnected()被回调前，我们还需先把当前Activity绑定到服务BindService上，绑定服务是通过通过bindService()方法，解绑服务则使用unbindService()方法，这两个方法解析如下：
- **bindService(Intent service, ServiceConnection conn, int flags)**  
    该方法执行绑定服务操作，其中Intent是我们要绑定的服务(也就是BindService)的意图，而ServiceConnection代表与服务的连接，它只有两个方法，前面已分析过。flags则是指定绑定时是否自动创建Service。0代表不自动创建、BIND_AUTO_CREATE则代表自动创建。

- **unbindService(ServiceConnection conn)**  
    该方法执行解除绑定的操作，其中ServiceConnection代表与服务的连接，它只有两个方法，前面已分析过。


Activity通过`bindService()`绑定到`BindService`后，ServiceConnection类的`onServiceConnected()`便会被回调并可以获取到`BindService`实例对象`mService`，之后我们就可以调用`BindService`服务端的公共方法了

**也就是说，客户端通过回调，获得了一个服务端提供的`Binder`对象，以这个对象为中间人，客户端由此获得了服务端的所有公共方法(public)的使用权限**

最后还需要在清单文件中声明该Service


*运行效果*
![[Pasted image 20241223170830.png]]

根据Log，在`onCreate()`执行完之后，总体执行顺序为：

服务端`onBind()` -> `new LocalBinder()` -> 客户端`onServiceConnected(ComponentName name, IBinder service)`的`service`参数中 -> 转换为自定义`Binder`类型(因为得到的参数是一个接口) -> 调用服务端`getService()`获取整个服务端对象 -> 有资格使用所有服务端公开方法

> **NOTE:**
> 多次调用BindService方法绑定服务端，而BindService的onBind方法只调用了一次，那就是在第一次调用BindService时才会回调onBind方法
> 多次绑定只需一次解绑
> 绑定状态下的Service生命周期方法的调用依次为onCreate()、onBind、onUnBind、onDestroy


##### 使用Messenger

前面了解了如何使用IBinder应用内同一进程的通信后，我们接着来了解服务与远程进程（即不同进程间）通信，而不同进程间的通信，最简单的方式就是使用 Messenger 服务提供通信接口，利用此方式，我们无需使用 AIDL 便可执行进程间通信 (IPC)。以下是 Messenger 使用的主要步骤：

- 1.服务实现一个 Handler，由其接收来自客户端的每个调用的回调
    
- 2.Handler 用于创建 Messenger 对象（对 Handler 的引用）
    
- 3.Messenger 创建一个 IBinder，服务通过 onBind() 使其返回客户端
    
- 4.客户端使用 IBinder 将 Messenger（引用服务的 Handler）实例化，然后使用Messenger将 Message 对象发送给服务
    
- 5.服务在其 Handler 中（在 handleMessage() 方法中）接收每个 Message


*待续*



---


## BroadcastReceiver


广播，是应用程序间的全局大喇叭，即通信的一个手段

比如：系统很多时候都在自己发送广播，比如开机成功、准备关机、电池电量低、插入耳机、收到来电......此之谓系统广播，每个APP都会收到，只需注册一个`BroadcastReceiver`

![[Pasted image 20241223220059.png]]

无序广播（标准广播）

### 基础用法



#### 接收广播

![[Pasted image 20241223220218.png|800]]

![[Pasted image 20241223220229.png|800]]



##### 动态注册

*实现：一开始没有联网，但是打开wifi之后过一会出现Toast提示*

自定义一个BroadcastReceiver，在onReceive()方法中完成广播要处理的事务
```java
package com.learn;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

public class MyBRReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Toast.makeText(context, "网络改变", Toast.LENGTH_SHORT).show();
        Log.i("", "网络改变");
    }
}

```

`MainActivity`中动态注册广播：
```java
package com.learn;

import android.content.IntentFilter;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;


public class MainActivity extends AppCompatActivity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        MyBRReceiver myBRReceiver = new MyBRReceiver();
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.net.conn.CONNECTIVITY_CHANGE");
        registerReceiver(myBRReceiver, intentFilter);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        unregisterReceiver(new MyBRReceiver());
    }
}
```

![[Pasted image 20241223221841.png]]

动态注册很简答，但是需要程序启动才能接收广播

##### 静态注册

*示例：接收开机广播*

自定义一个BroadcastReceiver，重写onReceive完成事务处理
```java
package com.learn;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

public class BootCompleteReceiver extends BroadcastReceiver {

    private final String ACTION_BOOT = "android.intent.action.BOOT_COMPLETED";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (ACTION_BOOT.equals(intent.getAction()))
            Toast.makeText(context, "开机完毕~", Toast.LENGTH_LONG).show();
        Log.d("kmj", "开机完毕");
    }
}
```

不同于动态注册，静态注册必须在清单中声明，同时添加开机广播的过滤条目并申请权限
```xml
<!--权限-->
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>

<receiver
        android:name=".BootCompleteReceiver"
        android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED" />
    </intent-filter>
</receiver>
```

> `android:exported="true"`代表组件可以被其他程序访问，允许其他应用向它发送广播

重启手机后发现接收到了广播
![[Pasted image 20241223223351.png]]


> **NOTE**:
> 不要在广播里添加过多逻辑或者进行任何耗时操作,因为在广播中是不允许开辟线程的, 当onReceiver()方法运行较长时间(超过10秒)还没有结束的话,那么程序会报错(ANR), 广播更多的时候扮演的是一个打开其他组件的角色,比如启动Service,Notification提示, Activity等


#### 发送广播


![[Pasted image 20241224082559.png|650]]


*示例(标准/无序广播)：*

`MyBroadcastReceiver`
```java
package com.learn;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

public class MyBroadcastReceiver extends BroadcastReceiver {
    private final String ACTION_BOOT = "com.learn.MY_BROADCAST";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent.getAction().equals(ACTION_BOOT)) {
            Toast.makeText(context, "收到", Toast.LENGTH_LONG).show();
            Log.d("kmj", "onReceive: 收到广播");
        }
    }
}
```

在接收方注册
```xml
<receiver
        android:name=".MyBroadcastReceiver"
        android:exported="true">
    <intent-filter>
        <action android:name="com.learn.MY_BROADCAST" />
    </intent-filter>
</receiver>
```

任意程序作为发送方
```java
package com.learn;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;


public class MainActivity extends AppCompatActivity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button btn = findViewById(R.id.button);

        btn.setOnClickListener(v -> sendBroadcast(new Intent("com.learn.MY_BROADCAST")));
    }
}
```

> **NOTE：**
> 在安卓8之后，自定义广播添加了限制，需要用一些方法才能接收和发送
> https://blog.csdn.net/kongqwesd12/article/details/78998151



**有序广播**
*待续*


---

### 本地广播

*待续*

---



## ContentProvider

*待续*

---

## Intent

*待续*


---
---


# 数据存储与访问

持久层内容

## 文件存储

 文件存储是Android中最基本的一种数据存储方式，它**不对**存储的**内容进行**任何的**格式化处理**，所有**数据都是原封不动**地保存到文件当中的，因而它比较适合用于**存储一些简单的文本数据或二进制数据**。

**访问方法**：
(数据与缓存)
- 内部存储(Internal Storage)，
    
    - getFilesDir()
        
    - getCacheDir()
        
- 外部存储(External Storage)
    
    - getExternalFilesDir()
        
    - getExternalCacheDir()
        

> 注意：**卸载应用**时，所有目录下的**文件将被移除**。并且**其他应用无法访问**这些专属文件。

### 内部存储

对于内部存储，Android提供了一个简化的方法，Context类中的`openFileOutput()`

这个方法接受两个参数：

- **第一个参数是文件名**，在文本创建的时候使用的就是这个名称，注意这里指定的文件名不可以包含路径（因为默认存储到`/data/data/<packagename>/files/`目录下）。
- 第二个参数是**文件的操作模式**
![[Pasted image 20241224111646.png]]

Context对象也有一些方法可以访问目录
```java
public void load() {
    // From internal storage, getFilesDir() or getCacheDir()
    File filesDir = getFilesDir();// 持久文件目录
    // FilesDir：/data/user/0/com.learn/files
    Log.e("File", "FilesDir：" + filesDir.getAbsolutePath());
    File cacheDir = getCacheDir();// 缓存文件目录
    // CacheDir：/data/user/0/com.learn/cache
    Log.e("File", "CacheDir：" + cacheDir.getAbsolutePath());
}
```

![[Pasted image 20241224111653.png]]


文件流形式，为了快速理解，可以回顾一下java的快读与快写
```java
import java.io.*;

// 快速读入
BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

// 快速输出
PrintWriter out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(System.out)));

```

**写入文件**

根据上面所说，调用 `openFileOutput()` 来获取 `FileOutputStream`，得到这个对象后就可以使用Java流的方式将数据写入到文件中
```java
public void save() {
    // 文件名
    String filename = "Reimu";
    // 写入内容
    String fileContents = "Hello Marisa";
    // 内容不能为空
    if (fileContents.isEmpty()) {
        Log.e("File", "FileContents.isEmpty()");
        return;
    }
    BufferedWriter writer = null;
    try {
        // 获取FileOutputStream对象
        FileOutputStream fos = openFileOutput(filename, Context.MODE_PRIVATE);
        // 通过OutputStreamWriter构建出一个BufferedWriter对象
        writer = new BufferedWriter(new OutputStreamWriter(fos));
        // 通过BufferedWriter对象将文本内容写入到文件中
        writer.write(fileContents);
    } catch (IOException e) {
        Log.e("File", e.getMessage());
    } finally {
        try {
            // 不管是否抛异常，都手动关闭输入流
            if (writer != null) writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

> **NOTE：**
> 如何在Android Studio中查看写入的文件？

在IDE的工具栏的`视图`中点击`工具窗口`，选择`设备资源管理器`后找到相应的文件夹即可
![[Pasted image 20241224133918.png]]


**读取文件**

```java
// 读取文件
public void read() {
    Log.e("File", "read.start");
    String filename = "Reimu";
    BufferedReader reader = null;
    try {
        // 获取FileInputStream对象
        FileInputStream fis = openFileInput(filename);
        // 通过InputStreamReader构建出一个BufferedReader对象
        reader = new BufferedReader(new InputStreamReader(fis));
        StringBuilder sb = new StringBuilder();
        String line = "";
        // 一行一行的读取，当数据为空时结束循环
        while ((line = reader.readLine()) != null) {
            sb.append(line);// 将数据添加到StringBuilder
            sb.append("\n");
        }
        Log.e("File", sb.toString());
    } catch (IOException e) {
        Log.e("File", e.getMessage());
    } finally {
        Log.e("File", "read.finally");
        try {
            if (reader != null) reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```



**查看文件列表**
方法已给出
*待续*

**删除文件**
*待续*


> **NOTE：**
> 内部存储路径为`/data/data/<packagename>/files/`，这里在安卓系统的根目录下，如果没有root，那么用户将无法查看该文件，适合存储专有内部存储文件


### 外部存储

对于外部存储，无法使用`openFileOutput()`，只能使用Java IO中的`File`类和`FileWriter`类

先看一个对比表格：

| 特性       | `openFileOutput()` | `FileWriter`         |
| -------- | ------------------ | -------------------- |
| **存储位置** | 应用内部存储             | 任意存储位置（需要指定路径）       |
| **安全性**  | 默认高，只能被应用自身访问      | 依赖存储位置和文件权限          |
| **操作对象** | 字节流                | 字符流                  |
| **适用场景** | 简单的内部存储文件写入        | 更灵活复杂的文件写入操作         |
| **权限需求** | 不需要额外权限            | 写入外部存储需要权限（应用专属目录除外） |

同样，也有访问外部存储目录的方法
```java
public void load() {
    File filesDir = getExternalFilesDir(null);// 持久文件目录
    // FilesDir：/storage/emulated/0/Android/data/com.learn/files
    Log.e("File", "FilesDir：" + filesDir.getAbsolutePath());
}
```

**参数详解：**

| **参数值**                           | **目录结构**            | **用途** |
| --------------------------------- | ------------------- | ------ |
| `null`                            | `/files/`           | 通用文件存储 |
| `Environment.DIRECTORY_PICTURES`  | `/files/Pictures/`  | 存储图片文件 |
| `Environment.DIRECTORY_MUSIC`     | `/files/Music/`     | 存储音乐文件 |
| `Environment.DIRECTORY_DOCUMENTS` | `/files/Documents/` | 存储文档文件 |

验证存储是否可用：
```java
// 检查外部存储是否可用于读写。
private boolean isExternalStorageWritable() {
    return Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED);
}
 
// 检查外部存储至少可读。
private boolean isExternalStorageReadable() {
     return Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED) ||
            Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED_READ_ONLY);
}
```


**应用专属目录**

```java

public void save() {
    String filename = "Komeiji";
    String content = "Touhou\nProject";
    try {
        // 获取应用私有的外部存储目录
        File file = new File(getExternalFilesDir(null), filename);

        // 写入文件
        FileWriter writer = new FileWriter(file);
        writer.write(content);
        writer.close();

        Log.d("StorageExample", "File written to: " + file.getAbsolutePath());
    } catch (IOException e) {
        e.printStackTrace();
    }
}

// 读取文件
public void read() {
    String filename = "Komeiji";
    try {
        // 获取文件路径
        File file = new File(getExternalFilesDir(null), filename);

        if (file.exists()) {
            // 读取文件内容
            FileReader reader = new FileReader(file);
            BufferedReader bufferedReader = new BufferedReader(reader);
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                content.append(line).append("\n");
            }
            bufferedReader.close();
            Log.d("content", content.toString());
        } else {
            Log.e("content", "File does not exist!");
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}

```

![[Pasted image 20241224143109.png]]


**公共存储区域**


公共存储区域指的是外部存储中的任意目录，例如 `Downloads`、`Pictures` 等。这些区域可以被其他应用访问，但需要申请适当的权限。

*在安卓10以上，有些常用的公共区域似乎也不用授权，这些都归功于沙盒存储机制*
*然而对于Android 13 (API 33) 或更高版本，你将永远无法任意访问沙盒之外的存储空间，除非你获得了任意文件写入权限*
*狗屎的是用户也访问不了应用外部存储的专属区域，谷歌真是全家死完了*


下面是沙盒区域内的文件操作(`Download`)
```java
public void save() {
    String folderName = Environment.DIRECTORY_DOWNLOADS;
    String filename = "Reimu.fumo";
    String content = "fumo\nfumo\nMarisa";
    try {
        // 获取公共存储区域路径
        File publicDir = new File(Environment.getExternalStoragePublicDirectory(folderName), filename);

        if (!publicDir.getParentFile().exists()) {
            publicDir.getParentFile().mkdirs(); // 创建目录
        }

        // 写入文件
        FileWriter writer = new FileWriter(publicDir);
        writer.write(content);
        writer.close();

        Log.d("kmj", "File written to: " + publicDir.getAbsolutePath());
    } catch (IOException e) {
        e.printStackTrace();
    }
}

// 读取文件
public void read() {
    String folderName = Environment.DIRECTORY_DOWNLOADS;
    String filename = "Reimu.fumo";
    try {
        // 获取文件路径
        File file = new File(Environment.getExternalStoragePublicDirectory(folderName), filename);

        if (file.exists()) {
            // 读取文件内容
            FileReader reader = new FileReader(file);
            BufferedReader bufferedReader = new BufferedReader(reader);
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                content.append(line).append("\n");
            }
            Log.d("kmj", content.toString());
            bufferedReader.close();
        } else {
            Log.e("kmj", "File does not exist!\"");
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

![[Pasted image 20241224194800.png]]


---


## SharedPreferences

这个类似于Windows中的ini文件

![[Pasted image 20241224202525.png|1050]]

```java
package com.learn;

import android.os.Bundle;

import android.widget.Button;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;

import android.widget.EditText;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {

    private EditText editTextUsername;
    private Button buttonSave, buttonLoad;
    private TextView textViewDisplay;

    // SharedPreferences 文件名和键名
    private static final String PREFS_NAME = "UserPrefs";
    private static final String KEY_USERNAME = "username";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 初始化 UI 元素
        editTextUsername = findViewById(R.id.editTextUsername);
        buttonSave = findViewById(R.id.buttonSave);
        buttonLoad = findViewById(R.id.buttonLoad);
        textViewDisplay = findViewById(R.id.textViewDisplay);

        // 保存按钮的点击事件
        buttonSave.setOnClickListener(v -> saveUsername());

        // 加载按钮的点击事件
        buttonLoad.setOnClickListener(v -> loadUsername());
    }

    // 保存用户名到 SharedPreferences
    private void saveUsername() {
        String username = editTextUsername.getText().toString();

        if (username.isEmpty()) {
            Toast.makeText(this, "请输入用户名", Toast.LENGTH_SHORT).show();
            return;
        }

        // 获取 SharedPreferences 实例并存储数据
        SharedPreferences sharedPreferences = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(KEY_USERNAME, username);
        editor.apply(); // 异步保存数据

        Toast.makeText(this, "用户名已保存", Toast.LENGTH_SHORT).show();
    }

    // 从 SharedPreferences 加载用户名
    private void loadUsername() {
        // 获取 SharedPreferences 实例并读取数据
        SharedPreferences sharedPreferences = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        String username = sharedPreferences.getString(KEY_USERNAME, "尚未保存用户名");

        // 显示用户名
        textViewDisplay.setText(username);
    }
}
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="16dp">

    <EditText
            android:id="@+id/editTextUsername"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:hint="请输入用户名"
            android:inputType="text" />

    <Button
            android:id="@+id/buttonSave"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="保存用户名" />

    <Button
            android:id="@+id/buttonLoad"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="加载用户名" />

    <TextView
            android:id="@+id/textViewDisplay"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:paddingTop="16dp"
            android:text="用户名将显示在这里"
            android:textSize="18sp" />

</LinearLayout>

```



可以读取其他应用的SharedPreferences，不过这个已经成为了历史

![[Pasted image 20241224203435.png|1000]]



---

## SQLite

轻量又流行的嵌入式数据库，支持标准sql语言

### 基础

Android提供了一个`SQLiteOpenHelper`类，用于对数据库进行创建和升级  
`SQLiteOpenHelper`是一个抽象类，使用时需要创建自己的类去继承它。  
`SQLiteOpenHelper`有两个**抽象方法**`onCreate()`和`onUpgrade()`，必须在自己的类中重写这两个方法，然后分别在这两个方法中实现`创建`和`更新`数据库的逻辑。

```java
package com.learn;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

public class DB extends SQLiteOpenHelper {
    public DB(@Nullable Context context, @Nullable String name, @Nullable SQLiteDatabase.CursorFactory factory, int version) {
        super(context, name, factory, version);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // 创建数据库sql语句并执行
        String sql = "create table user(id integer primary key autoincrement,username varchar(20),password varchar(20),age integer)";
        db.execSQL(sql);

    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

    }
}

```

同时这个`SQLiteOpenHelper`中有两个实例方法：`getReadableDatabase()`和 `getWritableDatabase()` 打开（创建）一个数据库

当数据库只读时：
`getReadableDatabase()`方法返回的对象将以只读的方式去打开数据库  
`getWritableDatabase()`方法则将出现异常


**增加数据**

```java
public long insert(String table, String nullColumnHack, ContentValues values) ;
```

方法参数:

| **table**          | 表名                                                    |
| ------------------ | ----------------------------------------------------- |
| **nullColumnHack** | 可选参数，当values参数为空时，指定哪个字段设置为null,如果values不为空，则该参数值可以为空 |
| **values**         | 指定具体的字段，相当于map集合，键值对的形式存储                             |
| **返回值**            | 返回插入成功的行数，如果为-1表示失败                                   |

```java
private void inser() {
    DB dbHelper = new DB(MainActivity.this, "users.db", null, 1);
    SQLiteDatabase db = dbHelper.getWritableDatabase();
    // 创建存放数据的ContentValues对象
    ContentValues values = new ContentValues();
    values.put("username", "test");
    values.put("password", "123456");
    values.put("age", 20);
    // 数据库执行插入命令
    db.insert("user", null, values);

}
```


**删除数据**

```java
public int delete(String table, String whereClause, String[] whereArgs) 
```

| **table**       | 表名                         |
| --------------- | -------------------------- |
| **whereClause** | 查询条件                       |
| **whereClause** | 指定条件语句，可以使用占位符？            |
| **whereArgs**   | 当表达式中含有占位符，该参数用户指定各占位符参数的值 |
| **返回值**         | 删除成功的行数                    |

```java
private void del() {
    DB dbHelper = new DB(MainActivity.this, "users.db", null, 1);
    SQLiteDatabase db = dbHelper.getWritableDatabase();
    db.delete("user", "username=?", new String[]{"test"});
}
```


**更新数据**

```java
public int update(String table, ContentValues values, String whereClause, String[] whereArgs) 
```

| **table**       | 表名                         |
| --------------- | -------------------------- |
| **values**      | 指定要更新的字段及对应的字段值            |
| **whereClause** | 指定条件语句，可以使用占位符？            |
| **whereArgs**   | 当表达式中含有占位符，该参数用户指定各占位符参数的值 |
| **返回值**         | 返回影响的数据条数                  |
```java
private void up() {
    DB dbHelper = new DB(MainActivity.this, "users.db", null, 1);
    SQLiteDatabase db = dbHelper.getWritableDatabase();
    ContentValues values = new ContentValues();
    values.put("age", 21);
    db.update("user", values, "username=?", new String[]{"test"});
}
```


**查询数据**

```java
public Cursor query(String table, String[] columns, String selection,String[] 
selectionArgs, String groupBy, String having, String orderBy) 
```

| **table**         | 表名                |
| ----------------- | ----------------- |
| **columns**       | 指定要查询的列，如果为空，返回所有 |
| **selection**     | 查询条件 ，可以用占位符？     |
| **selectionArgs** | where对应的条件值       |
| **groupBy**       | 指定分组方式            |
| **having**        | 指定having条件        |
| **orderBy**       | 排序方式              |
```java
private void query() {
    DB dbHelper = new DB(MainActivity.this, "users.db", null, 1);
    SQLiteDatabase db = dbHelper.getWritableDatabase();
    // 创建游标对象
    Cursor cursor = db.query("user", new String[]{"id", "username", "age"}, "username=?", new String[]{"test"}, null, null, null);
    // 利用游标遍历所有数据对象
    while (cursor.moveToNext()) {
        String id = cursor.getString(cursor.getColumnIndex("id"));
        String username = cursor.getString(cursor.getColumnIndex("username"));
        int age = cursor.getInt(cursor.getColumnIndex("age"));
        Log.i("Mainactivity", "result: id=" + id + " username: " + username + "  age:" + age);
    }
    // 关闭游标，释放资源
    cursor.close();

}
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="16dp">


    <Button
            android:id="@+id/add"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="添加" />

    <Button
            android:id="@+id/del"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="删除" />

    <Button
            android:id="@+id/up"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="更新" />

    <Button
            android:id="@+id/query"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="查询" />

</LinearLayout>

```

```java
package com.learn;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;

import android.util.Log;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;


public class MainActivity extends AppCompatActivity {


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button buttonAdd = findViewById(R.id.add);
        Button buttonDel = findViewById(R.id.del);
        Button buttonUp = findViewById(R.id.up);
        Button buttonQuery = findViewById(R.id.query);
        buttonAdd.setOnClickListener(v -> inser());
        buttonDel.setOnClickListener(v -> del());
        buttonUp.setOnClickListener(v -> up());
        buttonQuery.setOnClickListener(v -> query());
    }

    private void query() {
        DB dbHelper = new DB(MainActivity.this, "users.db", null, 1);
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        // 创建游标对象
        Cursor cursor = db.query("user", new String[]{"id", "username", "age"}, "username=?", new String[]{"test"}, null, null, null);
        // 利用游标遍历所有数据对象
        while (cursor.moveToNext()) {
            String id = cursor.getString(cursor.getColumnIndex("id"));
            String username = cursor.getString(cursor.getColumnIndex("username"));
            int age = cursor.getInt(cursor.getColumnIndex("age"));
            Log.i("Mainactivity", "result: id=" + id + " username: " + username + "  age:" + age);
        }
        // 关闭游标，释放资源
        cursor.close();

    }

    private void inser() {
        DB dbHelper = new DB(MainActivity.this, "users.db", null, 1);
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        // 创建存放数据的ContentValues对象
        ContentValues values = new ContentValues();
        values.put("username", "test");
        values.put("password", "123456");
        values.put("age", 20);
        // 数据库执行插入命令
        db.insert("user", null, values);

    }

    private void del() {
        DB dbHelper = new DB(MainActivity.this, "users.db", null, 1);
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        db.delete("user", "username=?", new String[]{"test"});
    }

    private void up() {
        DB dbHelper = new DB(MainActivity.this, "users.db", null, 1);
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("age", 21);
        db.update("user", values, "username=?", new String[]{"test"});
    }
}
```

> 当然，所有这些操作都可以使用sql语句完成，不必使用封装好的


*如何快速查看数据库？*
Android Studio的视图中有`App Inspection`
![[Pasted image 20241224212339.png]]


### 高级

*待续*

---
---

# 网络编程

## 基础知识

请求类型
- 发送get：请求url资源
- 发送post：发送表单数据

http状态码：
- 100~199 : 成功接受请求，客户端需提交下一次请求才能完成整个处理过程
- 200: OK，客户端请求成功
- 300~399：请求资源已移到新的地址(302,307,304)
- 401：请求未授权
- 403：Forbidden，服务器收到请求，但是拒绝提供服务
- 404：Not Found，请求资源不存在，这个就不用说啦
- 500：Internal Server Error，服务器发生不可预期的错误
- 503：Server Unavailable，服务器

声明权限
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

---

## Socket

*待续*

## 初级应用


Android提供了一个网络的请求方法`HttpURLConnection`，只能完成一些比较简单的操作

使用步骤：
- 创建一个URL对象： `URL url = new URL(http://www.baidu.com/);`
- 调用URL对象的openConnection()来获取HttpURLConnection对象实例： `HttpURLConnection conn = (HttpURLConnection) url.openConnection();`
- 设置HTTP请求使用的方法:GET或者POST，或者其他请求方式比如：PUT `conn.setRequestMethod("GET");`
- 设置连接超时，读取超时的毫秒数，以及服务器希望得到的一些消息头 ` conn.setConnectTimeout(6*1000)`
- 调用getInputStream()方法获得服务器返回的输入流，然后输入流进行读取了 `InputStream in = conn.getInputStream();`
- 最后调用disconnect()方法将HTTP连接关掉 `conn.disconnect();`

其他：
- 对响应码进行判断： `if(conn.getResponseCode() != 200)`
- 直接访问界面，读取流： `final InputStream in = new URL("url").openStream();`


**学校实验内容**
*获取网页html数据、显示网页*

```xml
<?xml version="1.0" encoding="utf-8"?>
<android.widget.RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        tools:context=".MainActivity">

    <!-- EditText 用于输入路径或 URL -->
    <EditText
            android:id="@+id/html"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:hint="请输入路径或URL"
            android:inputType="textUri"
            android:padding="16dp"
            android:layout_marginTop="32dp"
            android:layout_alignParentTop="true"
            android:layout_centerHorizontal="true" />

    <!-- 按钮1：获取HTML代码 -->
    <Button
            android:id="@+id/get_html"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="获取HTML代码"
            android:layout_below="@id/html"
            android:layout_alignParentLeft="true"
            android:layout_alignParentStart="true"
            android:layout_marginTop="16dp" />

    <!-- 按钮2：可视化网页内容 -->
    <Button
            android:id="@+id/show_page"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="显示网页内容"
            android:layout_below="@id/html"
            android:layout_alignParentRight="true"
            android:layout_alignParentEnd="true"
            android:layout_marginTop="16dp" />

    <!-- TextView 用于显示 HTML 内容或错误信息 -->
    <TextView
            android:id="@+id/text"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:padding="16dp"
            android:scrollbars="vertical"
            android:text="在此显示返回的HTML内容"
            android:layout_below="@id/get_html"
            android:layout_centerHorizontal="true"
            android:layout_marginTop="16dp" />

    <!-- WebView 用于可视化网页内容 -->
    <WebView
            android:id="@+id/webview"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:layout_below="@id/text"
            android:layout_alignParentBottom="true" />

</android.widget.RelativeLayout>

```

写一个用来网络访问Url的方法
```java
public String getHtml(String src) {
    StringBuilder sb = new StringBuilder();
    try {
        // 由于只是获取html内容，这里直接获取Url流
        BufferedReader br = new BufferedReader(new InputStreamReader(new URL(src).openStream()));
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        return sb.toString();
    } catch (Exception e) {
        return "error: " + e;
    }
}
```

也可以用网络的请求方法`HttpURLConnection`来获取流，好处是可以自定义各种请求方法和其他配置
```java
public String getHtml(String src) {
    StringBuilder sb = new StringBuilder();
    try {
        URL url = new URL(src);
        HttpURLConnection coon = (HttpURLConnection) url.openConnection();
        coon.setRequestMethod("GET");
        coon.setConnectTimeout(5000);
        BufferedReader br = new BufferedReader(new InputStreamReader(coon.getInputStream()));
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        return sb.toString();
    } catch (Exception e) {
        return "error: " + e;
    }
}
```

之后我们只要完成，点击第一个按钮，在下面的文本控件设置对应的网页html，点击第二个按钮，让webview控件展示对应的网页即可。
但是值得注意的是，Android在API9以后**不允许在主线程上执行网络操作**，要想在调试阶段启用主线程上的网络访问，则需要
```java
// 设置线程策略，调用 permitAll() 方法表示允许在主线程中进行所有操作（包括网络请求、文件读写等）
// 将配置的线程策略 policy 应用到当前线程
StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
StrictMode.setThreadPolicy(policy);
```

注意：**在网络阻塞的时候，这可能会导致整个程序（主线程）阻塞，最终ANR（应用程序未响应）**

因此，**网络操作应该在子线程中进行**，同时Android**不允许子线程直接修改UI组件**，需要用`Hander`等作为桥梁

两个按钮的监听事件：
```java
Handler hd = new Handler(Looper.getMainLooper());

btn1.setOnClickListener(v -> {
        new Thread(new Runnable() {
            @Override
            public void run() {
                String res = getHtml(ed.getText().toString().trim());
                hd.post(new Runnable() {
                    @Override
                    public void run() {
                        webView.setVisibility(View.GONE);
                        tx.setText(res);
                    }
                });
            }
        }).start();
    });

    btn2.setOnClickListener(v -> {
        new Thread(new Runnable() {
            @Override
            public void run() {
                hd.post(new Runnable() {
                    @Override
                    public void run() {
                        tx.setText("");
                        webView.setVisibility(View.VISIBLE);
                        webView.loadUrl(ed.getText().toString().trim());
                    }
                });
            }
        }).start();
    });
}
```

同样的，这里实现的所有函数式接口都能用lambda表达式简化

总体代码：
```java
package com.learn;

import android.os.Bundle;


import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Handler hd = new Handler(Looper.getMainLooper());

        EditText ed = findViewById(R.id.html);
        Button btn1 = findViewById(R.id.get_html);
        Button btn2 = findViewById(R.id.show_page);
        TextView tx = findViewById(R.id.text);
        WebView webView = findViewById(R.id.webview);

        btn1.setOnClickListener(v -> new Thread(() -> {
            String res = getHtml(ed.getText().toString().trim());
            hd.post(() -> {
                webView.setVisibility(View.GONE);
                tx.setText(res);
            });
        }).start());

        btn2.setOnClickListener(v -> new Thread(() -> hd.post(() -> {
            tx.setText("");
            webView.setVisibility(View.VISIBLE);
            webView.loadUrl(ed.getText().toString().trim());
        })).start());
    }

    public String getHtml(String src) {
        StringBuilder sb = new StringBuilder();
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new URL(src).openStream()));
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            return sb.toString();
        } catch (Exception e) {
            Log.e("kmg", e.toString());
            return "error: " + e;
        }
    }
}
```

![[Pasted image 20241225172746.png]]

![[Pasted image 20241225173021.png]]



**学校实验内容：**
*图片查看器*

使用`BitMap`类，给`ImageView`设置背景


```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="16dp"
        tools:context=".MainActivity">

    <EditText
            android:id="@+id/url"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:hint="请输入图片URL"
            android:inputType="textUri" />

    <Button
            android:id="@+id/loadimage"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="加载图片" />

    <!--android:adjustViewBounds="true" 图片适应-->
    <ImageView
            android:id="@+id/imageview"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:adjustViewBounds="true" />

    <TextView
            android:id="@+id/status"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:textSize="20sp"
            android:paddingTop="20dp"
            android:gravity="center_horizontal" />

</LinearLayout>

```

逻辑代码：
```java
package com.learn;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;


import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.net.HttpURLConnection;
import java.net.URL;


public class MainActivity extends AppCompatActivity {
    private final Handler hd = new Handler(Looper.getMainLooper());
    private EditText ed;
    private Button btn;
    private TextView tx;
    private ImageView iv;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ed = findViewById(R.id.url);
        btn = findViewById(R.id.loadimage);
        tx = findViewById(R.id.status);
        iv = findViewById(R.id.imageview);

        btn.setOnClickListener(v -> {
            String src = ed.getText().toString().trim();
            if (src.isEmpty()) {
                tx.setText("请输入网址");
                tx.setVisibility(View.VISIBLE);
                iv.setVisibility(View.GONE);
                return;
            }
            new Thread(() -> {
                try {
                    Bitmap bitmap = loadImage(src);
                    if (bitmap != null) {
                        hd.post(() -> {
                            iv.setVisibility(View.VISIBLE);
                            iv.setImageBitmap(bitmap);
                            tx.setVisibility(View.GONE);
                        });
                    } else {
                        setErrorText(null);
                    }

                } catch (Exception e) {
                    setErrorText(e);
                }
            }).start();
        });
    }

    // 加载图片失败时，设置text同时让图片框消失
    private void setErrorText(Throwable e) {
        hd.post(() -> {
            if (e == null) {
                tx.setText("加载失败");
            } else {
                tx.setText("加载失败\n" + e);
            }
            tx.setVisibility(View.VISIBLE);
            iv.setVisibility(View.GONE);
        });
    }


    private Bitmap loadImage(String src) {
        HttpURLConnection coon = null;
        try {
            URL url = new URL(src);
            coon = (HttpURLConnection) url.openConnection();
            coon.setRequestMethod("GET");
            coon.setConnectTimeout(5000);
            var rescode = coon.getResponseCode();
            if (rescode == HttpURLConnection.HTTP_OK)
                return BitmapFactory.decodeStream(coon.getInputStream());
            else throw new Exception(String.valueOf(rescode));
        } catch (Exception e) {
            Log.e("kmg", e.toString());
            return null;
        } finally {
            if (coon != null)
                coon.disconnect();
        }
    }
}
```

![[Pasted image 20241225203725.png]]


---
---

# 传感器

主要是位置

## GPS

**学校实验内容**

![[Pasted image 20241226095037.png]]


谷歌提供了一个获取位置的API `FusedLocationProviderClient`。但是我们不用这个，因为他依赖于谷歌服务`Google Play`

使用`LocationManager`管理位置，使用`LocationListener`实时监听并获取位置信息

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:tools="http://schemas.android.com/tools"
        android:id="@+id/mainLayout"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="16dp"
        tools:context=".MainActivity">

    <Button
            android:id="@+id/btnStartStop"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="开始运动" />

    <TextView
            android:id="@+id/tvDateTime"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="日期和时间："
            android:textSize="16sp"
            android:layout_marginTop="16dp"/>

    <TextView
            android:id="@+id/tvLatitude"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="纬度信息："
            android:textSize="16sp"
            android:layout_marginTop="8dp"/>

    <TextView
            android:id="@+id/tvLongitude"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="经度信息："
            android:textSize="16sp"
            android:layout_marginTop="8dp"/>

</LinearLayout>

```

```xml

<!--声明精准位置权限与粗略位置权限-->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

在运行程序时候，应当首先检查是否正确获取了相关权限，否则可能会崩溃

自定义权限检查与获取函数：
```java
private boolean checkPermission() {
        int perFine = ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION);
        int perCoarse = ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION);
        return perFine == PackageManager.PERMISSION_GRANTED && perCoarse == PackageManager.PERMISSION_GRANTED;
    }

    /**
     * PER_CODE 权限请求码，唯一标识本次请求
     */
    private void requestPermission() {
        ActivityCompat.requestPermissions(this,
                new String[]{
                        Manifest.permission.ACCESS_FINE_LOCATION,
                        Manifest.permission.ACCESS_COARSE_LOCATION
                }, PER_CODE);
    }

    // 生成一个重写的onRequestPermissionsResult回调函数，用于处理权限请求结果
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        // 遍历 grantResults，判断是否全部授权
        if (requestCode == PER_CODE) {
            boolean allYes = true;
            for (int grantResult : grantResults) {
                if (grantResult != PackageManager.PERMISSION_GRANTED) {
                    allYes = false;
                    break;
                }
            }

            if (allYes) {
                Toast.makeText(this, "权限获取成功", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "需要精准位置权限才能使用该应用", Toast.LENGTH_SHORT).show();
                Log.e(TAG, "权限获取失败");
                btn.setEnabled(false);
            }
        }
    }
}
```

关于位置的实时获取，具体实现流程如下：

- 首先初始化 `LocationManager` 和 `LocationListener`，生成实现的`LocationListener`的所有方法
- 接着调用`LocationManager`的方法，向系统请求持续的位置信息更新
```java
locationManager.requestLocationUpdates(
    LocationManager.GPS_PROVIDER, // 位置提供器
    1000,                         // 时间间隔（毫秒）
    0,                            // 距离间隔（米）
    locationListener              // 位置监听器
);
```

- 此时`LocationListener`开始工作，自动实时更新位置数据，我们想要使用他获取的位置信息，只要使用一个`getLastKnownLocation`即可
```java
// 该方法会返回系统缓存的上一次位置更新时保存的位置信息。  
// 它不会主动请求新的位置信息，而是使用已经存在的历史记录。  
// 如果设备之前未启用定位服务，或者系统未缓存任何位置信息，则会返回 null。
location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
```

总体代码:
```java
package com.learn;

import android.Manifest;
import android.content.pm.PackageManager;

import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;


import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.io.File;
import java.io.FileWriter;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


public class MainActivity extends AppCompatActivity {
    private final Handler hd = new Handler(Looper.getMainLooper());
    private Button btn;
    private TextView tvd;
    private TextView tv1;
    private TextView tv2;
    private TextView txerr;

    private LocationManager locationManager;
    private LocationListener locationListener;

    private File dataFile;
    private FileWriter fw;

    private long startTime;

    private boolean isRunning;

    private final int PER_CODE = 6657;
    private final String TAG = "kmj";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btn = findViewById(R.id.btn);
        tvd = findViewById(R.id.tvd);
        tv1 = findViewById(R.id.tvLatitude);
        tv2 = findViewById(R.id.tvLongitude);
        txerr = findViewById(R.id.txerr);

        // 初始化 LocationManager 和 LocationListener
        locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
        // 实现所有方法
        locationListener = new LocationListener() {
            @Override
            public void onLocationChanged(@NonNull Location location) {

            }

            @Override
            public void onLocationChanged(@NonNull List<Location> locations) {
                LocationListener.super.onLocationChanged(locations);
            }

            @Override
            public void onFlushComplete(int requestCode) {
                LocationListener.super.onFlushComplete(requestCode);
            }

            @Override
            public void onStatusChanged(String provider, int status, Bundle extras) {
                LocationListener.super.onStatusChanged(provider, status, extras);
            }

            @Override
            public void onProviderEnabled(@NonNull String provider) {
                LocationListener.super.onProviderEnabled(provider);
            }

            @Override
            public void onProviderDisabled(@NonNull String provider) {
                LocationListener.super.onProviderDisabled(provider);
            }
        };

        btn.setOnClickListener(v -> {
            handleStartStop();
        });
    }

    // 处理开始和停止按钮的点击事件
    private void handleStartStop() {
        if (!isRunning) {
            if (checkPermission()) {
                startTracking();
                Log.d(TAG, "权限获取成功");
            } else {
                requestPermission();
            }
        } else {
            stopTracking();
            Toast.makeText(this, "停止", Toast.LENGTH_SHORT).show();
        }
    }

    private void startTracking() {
        try {
            // 写入文件，涉及到外部存储的知识点
            String filename = "运动数据" + new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date()) + ".csv";
            File src = getExternalFilesDir(null);
            if (src == null) {
                Toast.makeText(this, "无法获取存储权限", Toast.LENGTH_SHORT).show();
                Log.e(TAG, "无法获取存储权限");
                return;
            }
            dataFile = new File(getExternalFilesDir(null), filename);
            fw = new FileWriter(dataFile);
            // 写入表头
            fw.append("时间,纬度,经度\n");
        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(this, "无法获取存储权限", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            // 启动监视器
            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 1000, 0, locationListener);
        } catch (SecurityException e) {
            e.printStackTrace();
            Toast.makeText(this, "无位置权限", Toast.LENGTH_SHORT).show();
            return;
        }

        isRunning = true;
        btn.setText("停止运动");
        startTime = System.currentTimeMillis();

        // 利用Handler执行runnable任务，在任务中每隔1秒重新调用自己，原理是把Runnable添加到消息队列中
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                if (isRunning) {
                    updateData();
                    Log.d(TAG, "run: oon");
                    hd.postDelayed(this, 1000);
                }
            }
        };
        hd.post(runnable);

    }

    private void updateData() {
        Location location = null;
        try {
            // 获取最近位置
            location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
        } catch (SecurityException e) {
            e.printStackTrace();
        }

        String currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        tvd.setText("日期和时间：" + currentDateTime);
        if (location != null) {
            double latitude = location.getLatitude();
            double longitude = location.getLongitude();

            tv1.setText("纬度信息：" + latitude);
            tv2.setText("经度信息：" + longitude);
            txerr.setVisibility(View.GONE);
            try {
                String dataLine = currentDateTime + "," + latitude + "," + longitude + "\n";
                fw.append(dataLine);
                // 刷新文件，保证文件写入存储
                fw.flush();
            } catch (Exception e) {
                e.printStackTrace();
                Log.e(TAG, "无法写入文件");
                Toast.makeText(this, "无法写入文件", Toast.LENGTH_SHORT).show();
            }
        } else {
            txerr.setVisibility(View.VISIBLE);
            Log.e(TAG, "无法获取当前位置");
        }
    }

    private void stopTracking() {
        isRunning = false;

        btn.setText("开始运动");

        try {
            locationManager.removeUpdates(locationListener);
        } catch (SecurityException e) {
            e.printStackTrace();
        }

        try {
            if (fw != null) {
                fw.flush();
                fw.close();
            }
            Toast.makeText(this, "文件已保存到：" + dataFile.getAbsolutePath(), Toast.LENGTH_LONG).show();
            Log.d(TAG, "stopTracking: " + dataFile.getAbsolutePath());
        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(this, "无法写入文件", Toast.LENGTH_SHORT).show();
        }

        long totaltime = (System.currentTimeMillis() - startTime) / 1000;
        tvd.setText("运行已结束");
        tv1.setText("运动时长：" + totaltime + "秒");
        tv2.setText("下次再见");
    }

    private boolean checkPermission() {
        int perFine = ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION);
        int perCoarse = ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION);
        return perFine == PackageManager.PERMISSION_GRANTED && perCoarse == PackageManager.PERMISSION_GRANTED;
    }

    /**
     * PER_CODE 权限请求码，唯一标识本次请求
     */
    private void requestPermission() {
        ActivityCompat.requestPermissions(this,
                new String[]{
                        Manifest.permission.ACCESS_FINE_LOCATION,
                        Manifest.permission.ACCESS_COARSE_LOCATION
                }, PER_CODE);
    }

    // 生成一个重写的onRequestPermissionsResult回调函数，用于处理权限请求结果
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        // 遍历 grantResults，判断是否全部授权
        if (requestCode == PER_CODE) {
            boolean allYes = true;
            for (int grantResult : grantResults) {
                if (grantResult != PackageManager.PERMISSION_GRANTED) {
                    allYes = false;
                    break;
                }
            }

            if (allYes) {
                Toast.makeText(this, "权限获取成功", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "需要精准位置权限才能使用该应用", Toast.LENGTH_SHORT).show();
                Log.e(TAG, "权限获取失败");
                btn.setEnabled(false);
            }
        }
    }
}
```

*在虚拟机中测试*
![[Pasted image 20241226175344.png]]

这里可以设置虚拟位置，还可以设置虚拟路径

**Android15依然可以使用，注意虚拟机镜像不要选择平板镜像，请选择手机镜像，平板模式有无法定位的BUG**


*待续*

---
---

# 安卓逆向

使用apktool解包

使用jd(jdgui)、cfr、Procyon(其Gui分支为Luyten)进行java逆向

https://github.com/deathmarine/Luyten