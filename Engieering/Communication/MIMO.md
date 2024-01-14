# Multi-Input Multi-Output (MIMO)

[TOC]
## Define
- 发送天线 $N_t$个
- 接收天线 $N_r$个

- 信道矩阵 $\boldsymbol H$

- 接收信号
$$
\boldsymbol y = \boldsymbol H \boldsymbol x + \boldsymbol z \quad ; z ~ N(\boldsymbol μ, \boldsymbol Σ_Z)
$$

## Property
### 信道容量
$$
C = \max_{\boldsymbol R_{xx}} \log_2 |\boldsymbol I + \frac{P_x}{P_z} · \boldsymbol H \boldsymbol R_{xx} \boldsymbol H^H|
$$


发送机预编码$V$, 接收机预编码$U^H$
$$
\begin{align*}
C &= \sum_i^{N_r} \log(1 + \frac{P_i^* σ_i}{σ_z^2})  \\
P_i^* &= \max\{ 0, \frac{1}{ν^*} - α_i \}  \\
\sum P_i^* &= P_x  \\
\end{align*}
$$

- 静态信道
	- 发送端、接收端知道$H$时
		$$
		C = \max_{\rho} \sum B \log_2 (1 + σ_i^2 \rho_i)
		$$

	- 发送端不知道$H$时

- 衰落信道
	- 发送端、接收端知道$H$时
		$$
		C = \E_H( \max_{R_{xx} |_{Tr(R_{xx} = \rho)} } B \log_2 ( 1 + \frac{P_i \gamma_i}{P} ) )
		$$

	- Proof
		$$
		\begin{align*}
			C &= \max I(X;Y)  \tag{定义} \\
				&= \max ( H(Y) - H(Y|X) ) \\
				&= \max ( H(Y) - H(H X + Z|X) ) \\
				&= \max ( H(Y) - H(Z) )  \tag{$X,Z$统计独立} \\
				&= \max ( H(Y) ) - N/2 \log (2 π e |\boldsymbol Σ_Z|^{1/N})
		\end{align*}
		$$
		- $H(Y)$取最大时达到信道容量. 平均功率受限的随机变量, 当$Y$为循环对称复Gauss分布时, $H(Y)$ 取得最大值.
		$$
		\begin{align*}
			\Rightarrow C &= \max_{\boldsymbol Σ_Y} N/2 \log(2 π e |\boldsymbol Σ_Y|^{1/N}) - N/2 \log (2 π e |\boldsymbol Σ_Z|^{1/N}) \\
				&= \max_{\boldsymbol Σ_Y} 1/2 \log \frac{|\boldsymbol Σ_Y|}{|\boldsymbol Σ_Z|}
		\end{align*}
		$$
		- $y$的自协方差矩阵
		$$
		\begin{align*}
			\boldsymbol Σ_Y &= E((\boldsymbol y - \bar {\boldsymbol y}) (y - \bar {\boldsymbol y})^H)  \tag{定义}  \\
				&= E(\boldsymbol y \boldsymbol y^H)  \tag{$\bar{\boldsymbol y} = 0$} \\
				&= E( (\boldsymbol H \boldsymbol x + \boldsymbol z) (\boldsymbol H \boldsymbol x + \boldsymbol z)^H)  \tag{代入} \\
				&= E( (\boldsymbol H \boldsymbol x) (\boldsymbol H \boldsymbol x)^H + z z^H)  \tag{$X,Z$统计独立} \\
				&= H E(x x^H) H^H + E(z z^H) \\
				&= \frac{P_x}{P_z} · \boldsymbol H \boldsymbol Σ_X \boldsymbol H^H + \boldsymbol Σ_Z
		\end{align*}
		$$
		$$
		\begin{align*}
		\Rightarrow C &= \max_{\boldsymbol Σ_X} 1/2 \log \frac{|\frac{P_x}{P_z} · \boldsymbol H \boldsymbol Σ_X \boldsymbol H^H + \boldsymbol Σ_Z|}{|\boldsymbol Σ_Z|}  \tag{代入} \\
		&= \max_{\boldsymbol Σ_X} 1/2 \log |\frac{P_x}{P_z} · \boldsymbol H \boldsymbol Σ_X \boldsymbol H^H + \boldsymbol I_{N_r}|
		\end{align*}
		$$

		- 发送机预编码$V$, 接收机预编码$U^H$, 将$\boldsymbol Σ_X$化为对角阵, 从而使多输入多输出信道化为多个并行的单输入单输出信道.
		$$
		\begin{align*}
			\Rightarrow C &= \max_{P_i} \sum_i^{N_r} \log(1 + \frac{P_i σ_i}{σ_z^2}) \\
			& \quad  s.t. \sum_i^{N_r} P_i = P_x
		\end{align*}
		$$
		- 解凸优化问题, 注水原理. 根据实际情景的具体参数, 代回信道容量解出数值结果.
		$$
		\begin{align*}
			P_i^* &= \max\{ 0, \frac{1}{ν^*} - α_i \} \\
			\sum P_i &= P_x
		\end{align*}
		$$

## Problem
### 预编码
	- 发送机预编码$V$, 接收机预编码$U^H$, 将$\boldsymbol Σ_X$化为对角阵, 从而使多输入多输出信道化为多个并行的单输入单输出信道.

### 接收机预编码
- Problem
	$$
	\boldsymbol y = \boldsymbol H \boldsymbol x + \boldsymbol z
	$$

	知$\boldsymbol y, \boldsymbol H$ 求$\boldsymbol x$. 

- 迫零法
	- Problem
		不考虑$z$, 解线性方程
		$$
		\boldsymbol y = \boldsymbol H \boldsymbol x
		$$

		知$\boldsymbol y, \boldsymbol H$ 求$\boldsymbol x$. 

	- Answer
		$$
		\boldsymbol x_{\text{估计}} = \boldsymbol H^+ \boldsymbol y
		$$

- 最小均方误差 (MMSE)
	- Problem
		$$
		\begin{align*}
			\min_{\boldsymbol W} \quad & E(||\boldsymbol W \boldsymbol y - \boldsymbol x||_2^2) 
		\end{align*}
		$$

	- nswer
		$$
		\boldsymbol W = \boldsymbol H^H (\boldsymbol H \boldsymbol H^H + \frac{σ_z^2}{P} \boldsymbol I)^{-1}
		$$

		- Proof
			$$
			\begin{align*}
				\min_{\boldsymbol W} \quad & E(||\boldsymbol W \boldsymbol y - \boldsymbol x||_2^2) 
				\Rightarrow \min_{\boldsymbol W} \quad & E( (\boldsymbol W \boldsymbol y - \boldsymbol x) (\boldsymbol W \boldsymbol y - \boldsymbol x)^H ) 
			\end{align*}
			$$

			$$
			\begin{align*}
			\Rightarrow E( (\boldsymbol W \boldsymbol y - \boldsymbol x) \boldsymbol y^H ) &= 0
			E( \boldsymbol W \boldsymbol y \boldsymbol y^H - \boldsymbol x \boldsymbol y^H ) &= 0
			\boldsymbol W E(\boldsymbol y \boldsymbol y^H) &= E(\boldsymbol x \boldsymbol y^H)
			\Rightarrow \boldsymbol W &= E(\boldsymbol x \boldsymbol y^H) E(\boldsymbol y \boldsymbol y^H)^{-1}
			&= E(\boldsymbol x (\boldsymbol H \boldsymbol x + \boldsymbol z)^H) · E((\boldsymbol H \boldsymbol x + \boldsymbol z) (\boldsymbol H \boldsymbol x + \boldsymbol z)^H)^{-1}  \tag{代入}
			&= E( \boldsymbol x \boldsymbol x^H \boldsymbol H^H + \boldsymbol x \boldsymbol z^H) · E(\boldsymbol H \boldsymbol x (\boldsymbol H \boldsymbol x)^H + 2 \boldsymbol z (\boldsymbol H \boldsymbol x)^H + \boldsymbol z \boldsymbol z^H)^{-1}
			&= E(\boldsymbol x \boldsymbol x^H) \boldsymbol H^H · (\boldsymbol H E(\boldsymbol x \boldsymbol x^H) \boldsymbol H^H + E(\boldsymbol z \boldsymbol z^H))^{-1}
			&= \boldsymbol Σ_X \boldsymbol H^H · (\boldsymbol H \boldsymbol Σ_X \boldsymbol H^H + \boldsymbol Σ_Z)^{-1}
			&= P \boldsymbol H^H · (P \boldsymbol H \boldsymbol H^H + σ_z^2 \boldsymbol I)^{-1}
			&= \boldsymbol H^H · (\boldsymbol H \boldsymbol H^H + \frac{σ_z^2}{P} \boldsymbol I)^{-1}
			\end{align*}
			$$

- 混合模数预编码

* 多用户MIMO
