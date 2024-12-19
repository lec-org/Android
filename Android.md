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
        EdgeToEdge.enable(this);
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