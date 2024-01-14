import torch
import torch.nn as nn
import torch.optim as optim
import gym

# Set up the environment
env = gym.make('CartPole-v0')

# Define the Actor-Critic network
class ActorCritic(nn.Module):
    def __init__(self, num_inputs, num_actions, hidden_size):
        super(ActorCritic, self).__init__()
        self.critic = nn.Sequential(
            nn.Linear(num_inputs, hidden_size),
            nn.ReLU(),
            nn.Linear(hidden_size, 1)
        )

        self.actor = nn.Sequential(
            nn.Linear(num_inputs, hidden_size),
            nn.ReLU(),
            nn.Linear(hidden_size, num_actions),
            nn.Softmax(dim=-1)
        )

    def forward(self, x):
        value = self.critic(x)
        probs = self.actor(x)
        return probs, value

# Initialize the Actor-Critic network
num_inputs = env.observation_space.shape[0]
num_outputs = env.action_space.n
hidden_size = 256
lr = 1e-3
network = ActorCritic(num_inputs, num_outputs, hidden_size)
optimizer = optim.Adam(network.parameters(), lr=lr)

# Define the training loop
def compute_returns(next_value, rewards, masks, gamma=0.99):
    R = next_value
    returns = []
    for step in reversed(range(len(rewards))):
        R = rewards[step] + gamma * R * masks[step]
        returns.insert(0, R)
    return returns

# Training loop
num_episodes = 1000
for episode in range(num_episodes):
    state = env.reset()
    log_probs = []
    values = []
    rewards = []
    masks = []
    entropy = 0

    for _ in range(1000):
        state = torch.FloatTensor(state)
        probs, value = network(state)

        action = probs.multinomial(num_samples=1)
        next_state, reward, done, _ = env.step(action.item())

        log_prob = torch.log(probs.squeeze(0)[action])
        entropy += -(log_probs * probs).sum()

        log_probs.append(log_prob)
        values.append(value)
        rewards.append(torch.tensor([reward], dtype=torch.float))
        masks.append(torch.tensor([1-done], dtype=torch.float))

        state = next_state

        if done:
            break

    next_state = torch.FloatTensor(next_state)
    _, next_value = network(next_state)
    returns = compute_returns(next_value, rewards, masks)

    log_probs = torch.cat(log_probs)
    returns = torch.cat(returns).detach()
    values = torch.cat(values)

    advantage = returns - values

    actor_loss = -(log_probs * advantage.detach()).mean()
    critic_loss = advantage.pow(2).mean()

    optimizer.zero_grad()
    total_loss = actor_loss + critic_loss - 0.001 * entropy
    total_loss.backward()
    optimizer.step()

    print('Episode: {}, Total loss: {:.4f}'.format(episode, total_loss.item()))

print("Training finished.")
