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

