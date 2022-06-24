﻿# PenTool: A Qt-based simulation software Demo

Born for industrial simulation software development

##### Version:1.0

##### Author：WangShuaiPeng

##### Mail：1946262980@qq.com

##### [Personal Website](http://101.43.234.220:8090/)

##### [CSDN](https://blog.csdn.net/qq_47898198)

## Introduction 

```
In the past year, I have been developing the Qt host computer from scratch, and I want to export and open source some of my own gains.

Qt is undoubtedly a great cross-platform framework. After the mature and stable QtWidget, Qt will focus on QtQuick. Although its Qml may not be as good as the three-piece web interface development in some aspects, its potential and future can be seen of. However, as a newborn, Qml is indeed in sharp contrast with UI libraries, development documents, and web front-end and back-end development with a stable and comfortable development environment. At this stage, it is difficult to find a complete, easy-to-use and stable UI component library.

Here, this software uses T2D as the UI component library selection of the software to speed up the development of the software. On this basis, it enriches the modules that may be needed in the Qt host computer. You can use it as a software demo to learn, or you can directly use it as a software demo. Use as a simple project framework. The demo will continue to update some useful modules. 

So, close to the topic, what does this demo bring us?
```

### Software Module

#### Sqlite database management

```
The demo has developed three tables with simple addition, deletion, modification and query functions and UI visualization operations. You can refer to, modify, add or delete independently.
```

#### Multi-threading (thread pool) processing computing tasks

```
The demo imagines the requirement of a computing task and designs a multi-threading design scheme based on it. The computing task that the thread should execute is specified through different task IDs and different constructors of the semaphore and work class. You can take a moment to read the source code. and modify it as you wish.
```


![在这里插入图片描述](https://img-blog.csdnimg.cn/f0f809dbb6154198888caa273972886d.png)

#### Fast Fourier and graphing

```
The back end of the demo performs fast Fourier transform on some time-domain and frequency-domain fake data and draws waveforms. The processing results are consistent with Matlab. The function is generated by matlabCoder and can be used with confidence. I hope for a faster speed. It is recommended to use the fftw library.
```

#### BIGEMap-3D earth satellite trajectory drawing

```
The demo uses the third-party interface BIGEMap to draw 3D earth and satellite trajectories. You can learn from it and modify and develop it. For details, see the introduction below.
```

#### Reading and writing of INI configuration files

```
The demo visually manages some system configuration parameters of the software based on the INI file, and supports user-defined parameters of the software.
```

#### Simple Lincese software encryption

```
See the source code for specific implementation
```

#### ......

### Software Demo

##### [Figma prototype link](https://www.figma.com/file/SWHyOkFPrDCuUm0HNF5SWi/myApp?node-id=0%3A1)

![请添加图片描述](https://img-blog.csdnimg.cn/185c2172d7bc4e10b2b9e27f3539ad55.gif)


| module                         |                             biu                              |                             biu                              |
| ------------------------------ | :----------------------------------------------------------: | :----------------------------------------------------------: |
| login interface                | ![在这里插入图片描述](https://img-blog.csdnimg.cn/a49a6f6abe754ad4b48a03b604227281.png) | ![在这里插入图片描述](https://img-blog.csdnimg.cn/a0b9c4f79b7d462c82f6ad8bfc6cb547.png) |
| database management            | ![在这里插入图片描述](https://img-blog.csdnimg.cn/50fa5f9315d3414b998e28ede0fc838b.png) | ![在这里插入图片描述](https://img-blog.csdnimg.cn/df2bd975488b4a05b1374888815f36f6.png) |
| Operation console              | ![在这里插入图片描述](https://img-blog.csdnimg.cn/5705cc4d22e94040a0ac72ddab6ef9c1.png) | ![在这里插入图片描述](https://img-blog.csdnimg.cn/4e6270726f064abcb5ecfc602d95ee20.png) |
| parameter configuration module | ![在这里插入图片描述](https://img-blog.csdnimg.cn/ea3d3f3f445b47279b260fb3138c8839.png) | ![在这里插入图片描述](https://img-blog.csdnimg.cn/ae0fc9c8507c443096048a0d5591ca2f.png) |

### Development Environment

| Operating environment | Version | link documentation                                  |
| --------------------- | ------- | --------------------------------------------------- |
| Qt                    | V5.12.7 | [download](https://download.qt.io/archive/qt/5.12/) |
| Toou-2D               | V1.0    | [download](https://github.com/ShowFL/Toou-2D/)      |
| qcustomplot           | V3.0    | Already downloaded, no need for your configuration  |



### Start here - Instructions for use

- ```
  Make sure your Qt development environment is configured correctly and available
  ```

- ```
  You need to download Toou-2D and compile and run (in the process of compiling and running it, the UI framework will extend the components designed and developed by itself into the Qml component library that comes with Qt, and you can write Qml without any other operations. When using these useful components, you can use it like a native qml component).
  ```

- ```
  Regarding the database login of the software, considering the user's convenience, the original plan was to use mysql for data management, but after changing to sqlite users, there is no need to download and configure the database. Therefore, you can directly click login to enter the database, and the login page therefore appears redundant. But if you really want to use other databases such as mysql, this page will reduce your development burden, you can continue to improve on this basis, or you can delete it directly.
  ```

- ```
  Then, before we start our operation, or when we use the software for the first time, we need to log in to the database and add some satellites and target data, waiting for our new projects to choose and use.
  ```

- ```
  When this is done, then start your trial. Oh yes, if you do not set Lincese, the software will be closed after 5 minutes, you can modify it in main.qml!
  ```

### Future Plan

	One year after I came into contact with industrial software design in the summer vacation of my sophomore year, compared to the previous writing of Internet software or platforms, I feel that the research and development of industrial software has allowed me to gain more professional business and lower-level knowledge besides user business. Although it's been a year, I still don't know much about other professional businesses, so I sincerely hope that more interested and like-minded buddies can work together to provide some interesting and useful gadget services to workers in the professional field, and hope to participate in the future. To the research and development of a well-known domestic industrial software.

### Last words to say

&emsp;If my work is helpful to you, please leave a **star**~