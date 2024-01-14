# Multi-user MIMO

[TOC]

## Define

- $N_t$ 个发送天线, 
- $N_u$ 个用户,
- $N_r$ 个接收天线 (每个用户)
-  发送信号 $x = W s$
用户i的接收信号 
$$
y_i = H_i x + n_i  \\
    = H_i W s + n_i
$$

$$
s \in C^{N_u × 1}  \tag{原始信号}
x \in C^{N_t × 1}  \tag{发送信号}
y_i \in C^{N_r × 1}  \tag{用户i的接收信号}
n_i \in C^{N_r × 1}  \tag{用户i的噪声}
W \in C^{N_t × N_u}  \tag{预编码矩阵}
H_i \in C^{N_r × N_t}  \tag{信道矩阵}
$$

## Problem
### Pre coding (downlink)
- 目的
将多用户之间的干扰消除掉. 前提是发送端知道信道状态信息.
- 非线性预编码
- 脏纸编码
- 迫零脏纸编码
- 串行迫零脏纸编码
- Tomlinson-Harashima 预编码
- Trellis 预编码
- 线性预编码
### Beamforming
$x = W s  \tag{发送信号}$
波束成形仅仅需要在发送端乘一个线性的波束成形矩阵.
- 随机波束成形
- 迫零波束成形
- MMSE波束成形
- 块对角化预编码
- 预编码矩阵
$$
W_i = V_{i (2)} V'_{i (1)}
$$
其中, 
$V_{i (2)}, V'_{i (1)}$ 来自 
$$
\tilde H_i = (\mb H_1 \\ \vdots \\ H_{i-1} \\ H_{i+1} \\ \vdots \\ H_n \me)
= U_i (\mb Σ & 0 \\ 0 & 0 \me) (\mb V_{i (1)}^H \\ V_{i (2)}^H \me)  \tag{$V_{i (2)}$}
H'_i = H_i V_{i (2)} = U' (\mb Σ & 0 \\ 0 & 0 \me) (\mb V'^H_{i (1)} \\ V'^H_{i (2)} \me)  \tag{$V'^H_{i (1)}$}
$$

- 信道容量
$C = \sum_i \log |I + \frac{Σ^2 P}{σ_n^2}|$
其中, $P$是功率分配的对角矩阵.
- Proof
发送信号, 接收信号,
$
x = \sum_i W_i s_i  \tag{发送信号}
y = H_i x + n_i  \tag{接收信号}
= H_i \sum_j W_j s_j + n_i
= H_i W_i s_i + H_i \sum_{i ≠ j} W_j s_j + n_i 
$
目的, 是找到$W_i$使得干扰项归零
$
\{\mb
H_i W_i = I
H_j W_j = \.0  &\qu; i ≠ j
\me\right.  \tag{干扰项归零}
$
即,
$
\{\mb
\tilde H_i W_i = \.0  &\qu ...(1)
H W = (\mb H_1 W_1 && \.0\\ & \ddots &\\ \.0 && H_n W_n \me)  &\qu ...(2)
\me\right.
$
$
\tilde H_i = (\mb H_1 \\ \vdots \\ H_{i-1} \\ H_{i+1} \\ \vdots \\ H_n \me)
H = (\mb H_1 \\ \vdots \\ H_n \me)
W = (\mb W_1 & ... & W_n \me)
$
对于$(1)$, 即$W_i$在$\tilde H_i$的零空间内. 矩阵论有, 矩阵$\tilde H_i$的SVD分解中$V$矩阵的第$r~n$列是其零空间的基向量组 $Null (A) = Span(v_{r+1}, ... , v_n)$. 即, $V_{i (2)}^H$ 满足$(1)$, 可将其作为预编码矩阵的一部分$W_i = V_{i (2)} W_{i (2)}$.
$
\tilde H_i = U_i (\mb Σ & \.0 \\ \.0 & \.0 \me) (\mb V_{i (1)}^H \\ V_{i (2)}^H \me)
H_i V_{i (2)}^H = \.0
$
对于$(2)$, 令$H'_i = H_i V_{i (2)}$, 对其SVD分解, 则以$V'^H_{i (1)}$作为预编码矩阵的后部分$W_i = V_{i (2)} V'^H_{i (1)}$, 以$U'_{i (1)}$作为接受端处理矩阵, 则可以满足$(2)$.
$
H_i W_i = H_i V_{i (2)} W_{i (2)}  \tag{代入}
= H'_i W_{i (2)}

H'_i = (\mb U'_{i (1)} & U'_{i (2)} \me) (\mb Σ & \.0 \\ \.0 & \.0 \me) (\mb V'^H_{i (1)} \\ V'^H_{i (2)} \me)
=> U'^H_{i (1)} H'_i V'_{i (1)} = Σ
$
综上, 预编码矩阵为 $W_i = V_{i (2)} V'_{i (1)}$

信道容量, 可得
$C = \sum_i \log |I + \frac{Σ^2 P}{σ_n^2}|$

