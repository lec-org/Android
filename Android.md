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

### 约束布局

`ConstraintLayout`是`Android官方`在2016年Google的I/O大会推出的一种可以灵活控制子控件的位置和大小的新布局方式，也是目前Android的几大布局中功能最强大的布局。在最新版的`Android Studio中`，创建布局文件的默认根元素都是`ConstraintLayout`了。`ConstraintLayout`非常适合使用**可视化**的方式来编写界面，但并不太适合使用XML的方式来进行编写

https://guolin.blog.csdn.net/article/details/53122387
https://blog.csdn.net/huweiliyi/article/details/122894823


### 帧布局

这个布局直接在屏幕上开辟出一块空白的区域,当我们往里面添加控件的时候,会默认把他们放到这块区域的左上角,而这种布局方式却没有任何的定位方式,所以它应用的场景并不多
帧布局的大小由控件中最大的子控件决定

略


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


## Adapter（适配器）

适配器是 UI 组件和数据之间的桥梁，**它帮助我们将数据填充到 UI 组件当中**
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