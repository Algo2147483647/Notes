# General Relativity

[TOC]

## Scene

## Phenomenon & Experiment

### Perihelion precession of Mercury

This anomalous rate of precession of the perihelion of Mercury's orbit was first recognized in 1859 as a problem in celestial mechanics, by Urbain Le Verrier. His re-analysis of available timed observations of transits of Mercury over the Sun's disk from 1697 to 1848 showed that the actual rate of the precession disagreed from that predicted from Newton's theory by 38″ (arcseconds) per tropical century (later re-estimated at 43″ by Simon Newcomb in 1882). Subsequently, Einstein's 1915 general theory accounted for Mercury's anomalous precession. In general relativity, this remaining precession, or change of orientation of the orbital ellipse within its orbital plane, is explained by gravitation being mediated by the curvature of spacetime. Einstein showed that general relativity agrees closely with the observed amount of perihelion shift. This was a powerful factor motivating the adoption of general relativity.

<img src="assets/Apsidendrehung.png" alt="img" style="zoom:5%;" />

### LIGO: discovery of gravitational waves

On 11 February 2016, the **Laser Interferometer Gravitational-Wave Observatory** (LIGO) collaboration announced the first observation of gravitational waves, from a signal detected at 09:50:45 GMT on 14 September 2015 of two black holes with masses of 29 and 36 solar masses merging about 1.3 billion light-years away. During the final fraction of a second of the merger, it released more than 50 times the power of all the stars in the observable universe combined. The signal increased in frequency from 35 to 250 Hz over 10 cycles (5 orbits) as it rose in strength for a period of 0.2 second. The mass of the new merged black hole was 62 solar masses. Energy equivalent to three solar masses was emitted as gravitational waves. The signal was seen by both LIGO detectors in Livingston and Hanford, with a time difference of 7 milliseconds due to the angle between the two detectors and the source. 

<img src="assets/LIGO_measurement_of_gravitational_waves.svg" alt="LIGO_measurement_of_gravitational_waves" style="zoom: 33%;" /><img src="assets/OIP.FHQn4YvQW5fGH3iyDRZSQgAAAA" alt="img" style="zoom:35%;" />

## Description

### Curved Space-Time & Metric

在n维时空中，度规是一个对称的二次微分形式（双线性型），通常表示为g。度规g具有以下特性：

1. 对称性：度规g是对称的，即gᵢⱼ = gⱼᵢ，其中i和j是时空的坐标指标。这表示度规的元素在互换指标i和j时不变。
2. 非退化性：度规矩阵的行列式不为零，即det(g) ≠ 0。这意味着度规允许我们计算空间中的长度和角度。
3. 正定、负定或不定性：度规可以具有正定、负定或不定的性质，这取决于度规的具体形式。正定度规表示时空是欧几里德空间，负定度规表示时空是洛伦兹空间（在特殊相对论中使用），不定度规表示时空具有复杂的性质。

度规的数学表达通常采用度规张量（metric tensor）或度规矩阵（metric matrix）的形式。在度规张量形式中，度规的元素表示为gᵢⱼ，i和j分别表示时空的坐标指标。度规矩阵形式通常表示为g_ij，其中i和j也是坐标指标。



度规张量（metric tensor）是描述时空的几何性质的重要数学工具，在广义相对论中起着关键作用。度规张量通常用符号$g_{\mu\nu}$表示，其中μ和ν代表四维时空的坐标分量。其数学定义如下：

度规张量$g_{\mu\nu}$是一个二阶对称张量，具有16个独立分量（μ和ν可以分别取0、1、2、3，代表时空的四个维度）。这些分量满足以下性质：

1. $g_{\mu\nu}$是对称的：$g_{\mu\nu} = g_{\nu\mu}$，因此，它的分量$g_{\mu\nu}$和$g_{\nu\mu}$是相等的。

2. $g_{\mu\nu}$在局部描述了时空的几何结构，它们用来计算两个事件之间的间隔或距离。在平直时空中，度规张量通常采用Minkowski度规，但在弯曲时空中，度规张量的分量会随着位置的变化而变化，以反映引力场的存在。

3. 度规张量的分量$g_{\mu\nu}$可以通过测量两个事件之间的间隔（或线元素）来确定，通常表示为ds²，其中ds²可以通过以下方式计算：
   ds² = $g_{\mu\nu}dx^\mu dx^\nu$
   其中$dx^\mu$和$dx^\nu$是两个事件之间的坐标差，而$g_{\mu\nu}$是度规张量的分量。

4. 度规张量的逆矩阵$g^{\mu\nu}$（也称为逆度规张量）用来升降指标，即从下标μ和ν变到上标μ和ν的操作。逆度规张量的分量满足：
   $g^{\mu\nu}g_{\nu\sigma} = \delta^\mu_\sigma$
   这里，$δ^\mu_\sigma$是Kronecker δ符号，它在μ和σ相等时为1，否则为0。

度规张量是广义相对论中的核心概念，它描述了引力场如何影响时空的几何结构，允许我们在弯曲时空中进行物理量的测量和运动的描述。在求解爱因斯坦场方程等方程时，度规张量的具体形式和分量通常是未知的，需要通过实际问题的边界条件和物理情境来确定。

#### Geodesic

**定义**

对于任意两点，测地线是连接它们的曲线，使得沿该曲线的物理距离或时间间隔是局部最小或局部极大的。这是为什么经常听说测地线是两点之间“最短”的路径，尽管在某些情境下，这可能意味着局部极大而非局部最小。

物理意义：在曲率的时空中，自由下落的物体（不受任何非引力外力作用的物体）将沿测地线移动。

从度规得到测地线方程的过程涉及到一系列的微分几何计算。

**2. 克里斯托弗尔联络**

利用度规和它的导数，我们可以计算Christoffel符号，也称为克里斯托弗尔联络：
$$
\Gamma^{\lambda}_{\mu\nu} = \frac{1}{2} g^{\lambda\sigma} (\partial_{\mu}g_{\nu\sigma} + \partial_{\nu}g_{\mu\sigma} - \partial_{\sigma}g_{\mu\nu})
$$
其中，\( g^{\lambda\sigma} \) 是度规的逆。

**3. 测地线方程**

测地线方程可以从测地线的定义推导出来，即沿测地线移动的自由下落物体的四速度与克里斯托弗尔联络的卷积是零。如果 \( x^\mu(\lambda) \) 描述了物体的轨迹，其中 \( \lambda \) 是仿射参数（例如固有时间），那么测地线方程为：

$$
\frac{d^2 x^\mu}{d\lambda^2} + \Gamma^{\mu}_{\alpha\beta} \frac{dx^\alpha}{d\lambda} \frac{dx^\beta}{d\lambda} = 0
$$

这就是测地线方程，它告诉我们自由下落物体如何在曲率时空中移动。

为了得到具体的轨迹，你需要为特定的度规解上述的微分方程。例如，对于施瓦西度规（描述一个非旋转黑洞的度规），解测地线方程会给你物体在黑洞周围的轨迹，包括经典的光的弯曲轨迹。

### Einstein gravitational field equation

$$
G_{\mu\nu} = \frac{8\pi G}{c^4} T_{\mu\nu}
$$



1. **基本原则**
   
   为了构造一个描述引力的理论，首先，我们希望该理论满足**广义协变性**，意味着它的形式在任何坐标变换下都保持不变。这个原则导致我们使用张量和曲率来描述引力。

2. **作用原则**
   
   在物理学中，一个广泛使用的原则是最小作用原则。系统的动力学由作用量给出，并且该作用在实际物理路径上是极小（或者更准确地说是稳定）的。因此，我们需要一个描述引力效应的作用。

3. **度规和Ricci标量**

   在广义相对论中，引力被看作是由于时空的曲率产生的。曲率可以通过度规张量 $g_{\mu\nu}$ 的导数来描述。Ricci标量 $R$ 是描述曲率的一个特别重要的标量，它来自Riemann曲率张量，这是描述曲率最自然的张量。

   我们的目标是找到一个广义协变的、关于度规的函数，作为动作的引力部分。最简单的广义协变标量，可以从度规和其导数构建的，就是Ricci标量 $R$。因此，引力的作用可以采取 $\sqrt{-g} R$ 的形式，其中 $\sqrt{-g}$ 是度规行列式的平方根，确保我们实际上是在整个四维体积上积分。

4. **物质作用**

   物质的作用 $S_M$ 通常由物质的拉格朗日密度 $\mathcal{L}_M$ 给出，这是一个与所考虑的物质和场有关的函数。对于给定的物理系统，$\mathcal{L}_M$ 可能会有不同的形式，但通常它会依赖于度规，因为度规决定了如何测量时空间隔。

5. **结合**

   将上述内容结合起来，我们得到爱因斯坦-希尔伯特动作：
   $$
   S = \int d^4x \sqrt{-g} \left( \frac{R}{16\pi G} + \mathcal{L}_M \right)
   $$
   
   其中 $\frac{1}{16\pi G}$ 是一个常数，确保在弱场极限下回归到牛顿引力。

这种动作提供了一个简洁、优雅且广泛协变的方式来描述引力和物质的相互作用。



爱因斯坦的引力场方程是描述广义相对论中引力的基本方程之一。这个方程可以从最小作用量原理（作用量最小原理）出发，通过变分原理推导得出。下面是推导爱因斯坦的引力场方程的基本步骤：

1. 定义作用量：首先，我们定义整个系统的作用量\(S\)，这个作用量由两部分组成：物质部分的作用量\(S_m\)和引力部分的作用量\(S_g\)。作用量的总和可以写成：
   $$
   S = S_m + S_g
   $$

2. 物质部分的作用量：物质部分的作用量\(S_m\)通常是关于物质场的拉格朗日密度\(L_m\)的积分，乘以一个因子\(-1/c\):
   $$
   S_m = -\frac{1}{c}\int L_m \sqrt{-g} d^4x\
   $$
   这里，\(c\)是光速，\(g\)是度规张量的行列式（即度规张量的行列式分量的乘积），\(d^4x\)是时空坐标的微元体积。

3. 引力部分的作用量：引力部分的作用量\(S_g\)通常由爱因斯坦-希尔伯特作用量给出，它与度规张量\(g_{\mu\nu}\)及其曲率有关：
   $$
   S_g = \frac{c^3}{16\pi G}\int R\sqrt{-g} d^4x
   $$
   其中，\(G\)是引力常数，\(R\)是时空的标量曲率，\(d^4x\)是时空坐标的微元体积。

4. 最小作用量原理：根据最小作用量原理，物理系统的真实运动轨迹对应于使总作用量\(S\)最小的情况。因此，我们需要对总作用量\(S\)进行变分，找到一个满足最小作用量原理的度规张量\(g_{\mu\nu}\)。

5. 变分原理：对作用量\(S\)进行变分，得到度规张量\(g_{\mu\nu}\)的场方程。这可以通过变分原理实现，即对作用量\(S\)关于度规张量\(g_{\mu\nu}\)的变分求解：
   $$
   \frac{\delta S}{\delta g_{\mu\nu}} = 0
   $$
   
6. 场方程：将变分原理应用于总作用量\(S = S_m + S_g\)，分别对\(S_m\)和\(S_g\)进行变分，然后得到引力场方程，也就是爱因斯坦场方程：
   $$
   G_{\mu\nu} = \frac{8\pi G}{c^4} T_{\mu\nu}
   $$
   这里，\(G_{\mu\nu}\)是爱因斯坦张量，\(T_{\mu\nu}\)是能动张量，它描述了物质分布在时空中的能量和动量分布。

通过这个推导过程，我们可以得到爱因斯坦的引力场方程，它描述了引力场如何由物质分布所决定，并建立了广义相对论的基础。这个方程在描述引力场的行为和预测引力场的效应方面非常成功，例如描述了黑洞、宇宙膨胀和引力透镜等现象。

## Example

### Schwarzschild's solution & Black Hole

施瓦西解是描述一个静态、对称、无电荷的黑洞的解。

1. **选择球对称度规**

  考虑到问题的对称性，我们选择一个球对称、静态的度规：

$$
ds^2 = -e^{2\alpha(r)} dt^2 + e^{2\beta(r)} dr^2 + r^2 (d\theta^2 + \sin^2\theta d\phi^2)
$$

2. **计算克里斯托弗尔联络**

  为了计算Einstein张量，我们需要首先计算Christoffel符号和Riemann曲率张量。这些计算涉及到度规和它的一阶、二阶导数。

  使用以下公式计算Christoffel符号：
$$
  \Gamma^{\lambda}_{\mu\nu} = \frac{1}{2} g^{\lambda\sigma} (\partial_{\mu}g_{\nu\sigma} + \partial_{\nu}g_{\mu\sigma} - \partial_{\sigma}g_{\mu\nu})
$$

3. **计算Riemann曲率张量**
    $$
    R^\rho_{\sigma\mu\nu} = \partial_{\mu}\Gamma^\rho_{\nu\sigma} - \partial_{\nu}\Gamma^\rho_{\mu\sigma} + \Gamma^\rho_{\mu\lambda}\Gamma^\lambda_{\nu\sigma} - \Gamma^\rho_{\nu\lambda}\Gamma^\lambda_{\mu\sigma}
    $$

4. **计算Ricci张量**
    $$
    R_{\mu\nu} = R^\rho_{\mu\rho\nu}
    $$

5. **计算Ricci标量**
    $$
    R = g^{\mu\nu} R_{\mu\nu}
    $$

6. **将Ricci张量和标量代入Einstein方程**
    $$
    R_{\mu\nu} - \frac{1}{2}g_{\mu\nu}R = 0
    $$

考虑到 $T_{\mu\nu} = 0$（真空解）。

7. **解方程**

  代入我们选择的度规，我们得到一组微分方程。解这组方程，我们可以找到 *α*(*r*) 和 *β*(*r*)。为了得到施瓦西解，我们还需要加上合适的边界条件，例如：远离源（r到无穷大）时，度规应该趋于Minkowski度规。

  解出 $\alpha$ 和 $\beta$，我们得到：
$$
  e^{2\alpha} = 1 - \frac{2GM}{r}
$$

$$
  e^{2\beta} = \frac{1}{1 - \frac{2GM}{r}}
$$

8. **得到施瓦西解**
    $$
    ds^2 = -\left(1 - \frac{2GM}{r}\right) dt^2 + \frac{dr^2}{1 - \frac{2GM}{r}} + r^2 (d\theta^2 + \sin^2\theta d\phi^2)
    $$

再次强调，为了在这里简洁，上述过程省略了很多具体的张量代数和微分方程的计算。如果你需要具体的中间计算步骤，可能需要一个专门的广义相对论教材或更长篇幅的讲解。



### Gravitational Wave