# Time Series

## Define

设 $T$ 是一个有序的时间集合（例如，连续的时间点、自然数序列等），对于每一个 $t \in T$，都存在一个相应的观测值 $x_t$。那么时间序列 $\{x_t\}$ 可以定义为一个实值或者复值函数，它将时间集合 $T$ 中的每个时间点映射到一个实数或复数值：
$$
X: T \rightarrow \mathbb{R} \quad \text{or} \quad X: T \rightarrow \mathbb{C}
$$
其中，$X(t) = x_t$ 表示在时间 $t$ 的观测值。

在更严格的数学表述中，时间序列 $\{x_t\}_{t \in T}$ 被视为一个随机过程（如果观测值是随机变量）或者一个确定性序列（如果观测值是确定的数值）。

- **随机时间序列**：$x_t$ 是在时间点 $t$ 的一个随机变量，整个序列 $\{x_t\}$ 表示一个随时间变化的随机过程。
- **确定性时间序列**：$x_t$ 是在时间点 $t$ 的一个确定性的值，整个序列 $\{x_t\}$ 描述了一个随时间变化的确定性过程。

## Problem

### [Time Series Decomposition](./Time_Series_Decomposition.md)

### Prediction

[Autoregressive Integrated Moving Average](./Autoregressive_Integrated_Moving_Average.md)