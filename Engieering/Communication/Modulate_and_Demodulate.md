# Modulate & Demodulate

[TOC]

## Analog modulation

### 调幅 AM
$$
\begin{align*}
y(t) &= ( A_0 + x(t) ) \cos(ω_c t)  \tag{时域}\\
Y(t) &= π A_0 (δ(ω + ω_c) + δ(ω - ω_c)) + 1/2 ( X(ω + ω_c) + X(ω - ω_c))  \tag{频域}
\end{align*}
$$

### 抑制载波双边带调制 DSB
$$
\begin{align*}
y(t) &= x(t) \cos(ω_c t)  \tag{时域}\\
Y(t) &= 1/2 ( X(ω + ω_c) + X(ω - ω_c))  \tag{频域}
\end{align*}
$$

### 单边带调制 SSB
$$
\begin{align*}
y(t) &= 1/2 x(t) \cos(ω_c t) \mp 1/2 \hat x(t) \sin(ω_c t)  \tag{时域}
\end{align*}
$$

### 残留边带调制 VSB

### 调频 FM
### 调相 PM

## Digital Modulation
### 幅度、相位调制

### 脉幅调制 PAM

### 相移调制 PSK
二元相移调制 BPSK
  		* 四元相移调制 QPSK

### 正交幅度调制 QAM

### 频率调制

#### 频移键控 FSK

#### 最小频移键控 MSK

#### 连续相位频移键控 CPFSK
