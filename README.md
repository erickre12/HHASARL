# Hyper-heuristic Adaptive Simulated Annealing with Reinforcement Learning (HHASARL)
This repository contains the source code for the HHASA$_{RL}$ algorithm, an innovative approach for solving the Capacitated Electric Vehicle Routing Problem (CEVRP). The algorithm is designed to optimize the routing of electric vehicles with charging station considerations.

## Features

- Hybrid Heuristic and Reinforcement Learning approach.
- Simulated Annealing combined with reinforcement learning methods.

## Project Status
The project has been released! You can now access the codebase and documentation in the public repository. We're excited to share our work with the community and welcome feedback and contributions.

# How to Run
To run the algorithm, follow these steps:

1. Ensure you have MATLAB installed on your system.
2. Open the Main.m file in MATLAB.
3. Set the parameters RL, print, and draw as follows:
   
   RL = 2; % Choose RL algorithm (0 for Rand, 1 for Epsilon-greedy, 2 for Thomson Sampling, 3 for Upper Confidence Bound 1)
   
   print = 0; % Set to 1 to print output for each iteration, 0 otherwise
   
   draw = 0; % Set to 1 to visualize results, 0 otherwise
   
5. Run the Main.m script.
6. Review the results obtained.

# Competition
The HHASARL algorithm has been tested and evaluated in the CEC-12 Competition on Electric Vehicle Routing Problem. You can find more information about the competition [here](https://mavrovouniotis.github.io/EVRPcompetition2020/).

# Citation
If you use this code for your research, please cite our paper.
```
@article{rodriguez2022new,
  title={A new hyper-heuristic based on adaptive simulated annealing and reinforcement learning for the capacitated electric vehicle routing problem},
  author={Rodr{\'\i}guez-Esparza, Erick and Masegosa, Antonio D and Oliva, Diego and Onieva, Enrique},
  journal={arXiv preprint arXiv:2206.03185},
  year={2022}
}

```
## Contact

- Erick Rodríguez-Esparza
- erick.rodriguez@deusto.es
