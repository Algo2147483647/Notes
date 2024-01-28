# Viscous Fluid
[TOC]
## Scene

## Phenomenon & Experiment

## Description
### Navier Stokes Equations  
$$
ρ \left(\frac{∂\boldsymbol v}{∂t} + (\boldsymbol v · ∇) \boldsymbol v \right) =  - ∇ P  + ρ \boldsymbol f + η ∇^2 \boldsymbol v + \left(ζ + \frac{η}{3} \right) ∇ (∇ · \boldsymbol v)
$$

For dimension $d$, the component formula is 
$$
ρ \left(\frac{∂ v_x}{∂t} + \sum_{i=1}^{\dim} v_i \frac{∂ v_d}{∂x_i}\right) =  - \frac{∂ P}{∂d}  + ρ  f_d + η \sum_{i=1}^{\dim} \left(\frac{∂^2 v_d}{∂ x_i^2}\right) + \left(ζ + \frac{η}{3} \right) \frac{∂\left(\sum\limits_{i=1}^{\dim} \frac{∂ v_d}{∂x_i}\right)}{∂x_i}
$$

For incompressible fluid, we have $∇ ·\boldsymbol v ≡ 0$ and
$$
\frac{∂\boldsymbol v}{∂t} + (\boldsymbol v·∇) \boldsymbol v = -\frac{1}{ρ} ∇ P  + \boldsymbol f + \frac{η}{ρ} ∇^2 \boldsymbol v  \tag{$∇ ·\boldsymbol v ≡ 0$}
$$
- $η$: Viscosity
- $ρ$: Density
- Pressure: $∇ ·∇ P = ∇ ·v·ρ/ dt$

## Example

