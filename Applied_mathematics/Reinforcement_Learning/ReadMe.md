1. **Limited States and Discrete Actions**:
   - **Q-Learning**: Finds the optimal policy by maintaining a Q-table and updating Q-values for state-action pairs using the Bellman equation until convergence.
   - **State–Action–Reward–State–Action (SARSA)**: Similar to Q-learning but updates the Q-values differently based on the next action taken.
2. **Unlimited States and Discrete Actions**:
   - **Deep Q-Networks (DQN)**: Combines convolutional layers with fully connected layers to produce Q-values, mainly used in environments with unlimited states.
   - **Double DQN (DDQN)**: Utilizes two networks to reduce overestimation of Q-values by DQN.
   - **Dueling DQN**: Decomposes the Q-value function into two separate functions to better evaluate actions.
   - **Deep Recurrent Q-Network (DRQN)**: Integrates a recurrent LSTM layer to process sequences of states.
   - **Deep SARSA**: Adapts SARSA to environments with unlimited states using deep neural networks.
3. **Unlimited States and Continuous Actions**:
   - **Policy Gradient Algorithms**: Includes algorithms like REINFORCE, Actor-Critic, Trust Region Policy Optimization (TRPO), and Proximal Policy Optimization (PPO), which are designed for environments requiring continuous action spaces.





- **Value-Based**:
  - Q-Learning
  - SARSA
  - Deep Q-Network (DQN)
  - Double DQN
  - Dueling DQN
  - Prioritized Experience Replay
  - Distributional DQN
  - Noisy DQN
- **Policy-Based**:
  - REINFORCE
  - Trust Region Policy Optimization (TRPO)
  - Proximal Policy Optimization (PPO)
  - Actor-Critic Methods
  - Asynchronous Advantage Actor-Critic (A3C)
  - Soft Actor-Critic (SAC)
  - Deterministic Policy Gradients (DPG)
  - Twin Delayed DDPG (TD3)
- **Model-Based**:
  - Dyna-Q
  - Monte Carlo Tree Search (MCTS)
- **Hybrid Methods**:
  - Deep Deterministic Policy Gradient (DDPG)
  - Hindsight Experience Replay (HER)
- **Multi-Agent RL**:
  - Independent Q-Learning
  - Multi-Agent DDPG (MADDPG)
- **Hierarchical RL**:
  - Option-Critic Architecture
  - Hierarchical-DQN (h-DQN)