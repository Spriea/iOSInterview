# iOSInterview
App Store《面试题大全》开源，设计全套无服务器实现上线，版本更新。markdown语法展示等。

# 说明
由于是线上APP，项目里有集成广告SDK，暂时不支持模拟器运行，请使用真机运行，如果需要模拟器运行，请剔除集成的广告

# 上线版本更新实现原理
通过免费的在线文档创建[面试题大全](https://www.yuque.com/docs/share/9ac5cc5e-068d-4815-8de1-83bd23ed6e74)，将标题包装成json“%”替换成引号，具体请看文档链接。

# 无服务内购实现
苹果内购成功后，在keychain里面存储标识符，每次进入APP后先去keychain，标识符，如果keychain标识符有值，则表示已经内购过了

# App文档大概实现原理
本地json索引markdown文件或者html内容标签文件。
如果是markdown文件则通过MMMarkdown.framework转换语法为HTML。
然后加载本地基本HTML文件架构，以及.css。通过js将加载好的HTML字符串插入到html的body里面，具体实现请查看源代码，欢迎大家一起来维护

