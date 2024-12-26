
文档使用Obsidian编写，一定要使用Obsidian查看，否则无法正常显示

使用
```bash
git clone --recurse-submodules https://github.com/KomeijiReimu/Android.git
```

克隆包含子模块的仓库

*待续* 是考试不考或者上课没讲的部分


所有标注**学校实验内容**都是考试要考的

其中编程题三个具体项目分别为：

**网格布局**
还包括一个进度条（默认圆形加载条）
![[06cba22135487796f18c9cce760d28f5.jpg|1175]]

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:id="@+id/mainLayout"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical">

    <RelativeLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content">

        <TextView
                android:id="@+id/txtx"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_alignParentStart="true"
                android:gravity="center"
                android:layout_centerVertical="true"
                android:textSize="30sp"
                android:text="京海市" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="消息"
                android:layout_toRightOf="@id/txtx"
                android:layout_marginLeft="20dp" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_alignParentEnd="true"
                android:text="扫一扫" />

    </RelativeLayout>

    <GridLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:columnCount="3"
            android:rowCount="3"
            android:layout_marginTop="30dp"
            android:orientation="horizontal">

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />

        <Button
                android:layout_width="wrap_content"
                android:layout_height="80dp"
                android:layout_columnWeight="1"
                android:text="按钮" />
    </GridLayout>
</LinearLayout>

```

![[Pasted image 20241226211222.png|475]]


**网络编程**（文档中有）

**实验6.2（位置 + 文件存储）**（文档中传感器一栏）


设计题要画流程图

