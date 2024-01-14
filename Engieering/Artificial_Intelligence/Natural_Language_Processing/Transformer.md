# Transformer

[TOC]

## Process
  - Basic structure
    - Multi-Head Self-Attention
    - Position-wise Feedforward Layer 
      $$y = W_2 (\text{ReLU}(W_1 x + b_1)) + b_2$$ 
  - Encoder
    $$\text{EncoderLayer}_i(x) = \text{LayerNorm}(x + \text{MultiHead}(\text{LayerNorm}(x)))$$
    $$\text{Encoder}(x) = \text{Position-wiseFeedforward}(\text{EncoderLayer}_N(...(\text{EncoderLayer}_1(x))))$$
  - Decoder  
    $$\text{DecoderLayer}_i(x, y) = \text{LayerNorm}(x + \text{MultiHead}(\text{LayerNorm}(\text{MaskedSelfAttention}(x, y))))$$
    $$\text{Decoder}(x, y) = \text{Position-wiseFeedforward}(\text{DecoderLayer}_N(...(\text{DecoderLayer}_1(x, y))))$$