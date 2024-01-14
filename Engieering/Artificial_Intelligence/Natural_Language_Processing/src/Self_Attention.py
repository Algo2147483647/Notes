import torch
import torch.nn as nn
import torch.nn.functional as F

# Multi-Head Attention
class MultiHeadAttention(nn.Module):
    def __init__(self, d_model, n_heads):
        super().__init__()
        self.d_model = d_model
        self.n_heads = n_heads
        self.d_k = d_model // n_heads
        
        self.Q_linear = nn.Linear(d_model, d_model)
        self.K_linear = nn.Linear(d_model, d_model)
        self.V_linear = nn.Linear(d_model, d_model)
        self.out_linear = nn.Linear(d_model, d_model)
    
    def forward(self, x, mask=None):
        batch_size = x.size(0)
        Q = self.Q_linear(x).view(batch_size, -1, self.n_heads, self.d_k).transpose(1,2)
        K = self.K_linear(x).view(batch_size, -1, self.n_heads, self.d_k).transpose(1,2)
        V = self.V_linear(x).view(batch_size, -1, self.n_heads, self.d_k).transpose(1,2)
        
        scores = torch.matmul(Q, K.transpose(-2, -1)) / torch.sqrt(torch.tensor(self.d_k).float())

        if mask is not None:
            mask = mask.unsqueeze(1)
            scores = scores.masked_fill(mask == 0, -1e9)
        
        attention = F.softmax(scores, dim=-1)
        out = torch.matmul(attention, V).transpose(1,2).contiguous().view(batch_size, -1, self.d_model)
        out = self.out_linear(out)
        return out, attention
    
# Position-wise Feedforward
class PositionwiseFeedforward(nn.Module):
    def __init__(self, d_model, d_ff):
        super().__init__()
        self.linear1 = nn.Linear(d_model, d_ff)
        self.linear2 = nn.Linear(d_ff, d_model)
    
    def forward(self, x):
        x = self.linear1(x)
        x = F.relu(x)
        x = self.linear2(x)
        return x
