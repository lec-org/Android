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

*其实`super.onCreate(savedInstanceState)`下的代码都是为全面屏而准备的*


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




## 布局检查器

https://developer.android.google.cn/studio/debug/layout-inspector?hl=zh-cn

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

*待续*

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


## 回调处理

*待续*

## 多线程

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

# 四大组件

activity、service、content provider、broadcast receiver

## activity

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

- 复杂自定义对象传递（序列化）
	**Serializable**
		Serializable 接口允许您传递自定义对象。要使用 Serializable，您需要实现该接口并在传递对象之前对其进行序列化。在目标 Activity 中，反序列化对象以访问数据。
	**Parcel**
		Parcel 是 Android 框架中用于高效序列化和反序列化对象的类。它比 Serializable 更高效，但需要更多的手动编码。





