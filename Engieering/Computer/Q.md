[TOC]

# 性能监控

## Java Heap Dump

Java Heap Dump 是特定时刻 JVM 内存中所有对象的快照。它们对于解决内存泄漏问题和分析 Java 应用程序中的内存使用情况非常有用。
Java Heap Dump 通常以二进制格式的 hprof 文件存储。我们可以使用 jhat 或 JVisualVM 之类的工具打开和分析这些文件。同样，使用 MAT 工具分析是很常见的。

### jmap

