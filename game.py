from typing import Union, List

import numpy as np
from egttools.analytical import StochDynamics
from egttools import sample_simplex, calculate_nb_states
from egttools.utils import transform_payoffs_to_pairwise
from utils import *
import random
import matplotlib.pyplot as plt
from egttools.plotting import draw_stationary_distribution
import egttools as egt


class FixedIncentivesGame(egt.games.AbstractGame):
    def __init__(self, population_state: List[int], group_size: int, endowment: float, c: float, risk: float,
                 M: int, alpha: int, n_E: float, total_incentives: float, pi_t: float, local_scheme=True) -> None:
        """

        :param population_state: (i_E, i_C, i_D) respectively, the number of executors, the number of cooperators,
         the number of defector in the population. i_E + i_C + i_D = N
        :param group_size: N
        :param endowment: amount of "money" that players own
        :param c: amount of "money" that a player can invest
        :param risk: If the collective target is not reached, probability of risk to lose everything
        :param M: minimum number M of cooperators to ensure the benefit of everyone within the group
        :param alpha: positive incentive on every cooperator,
        :param n_E: threshold of executors to apply the reward/punishment scheme
        :param total_incentives: total incentives per executor
        :param pi_t: each executor invests p_t to the sanctioning pool
        :param local_scheme: True if local scheme applied
        """
        super().__init__()
        self.population_state = population_state
        self.group_size = group_size
        self.endowment = endowment
        self.c = c
        self.M = M
        self.risk = risk
        self.alpha = alpha

        self.nb_strategies = 3
        self.nb_states = calculate_nb_states(self.group_size, self.nb_strategies)

        self.payoffs = np.zeros(shape=(self.nb_strategies, self.nb_states), dtype=np.float64)
        self.total_incentives = total_incentives
        self.pi_t = pi_t
        self.n_E = n_E
        self.local_scheme = local_scheme
        self.calculate_payoffs()

    def play(self, group_composiiton: Union[List[int], np.ndarray], game_payoffs: np.ndarray) -> None:
        """
        Fill game_payoffs with the average payoff of the strategies
        :param group_composiiton: composition of the group. Respectively  j_e, j_c, j_d
        :param game_payoffs: array of size self.nb_strategies
        :return:
        """
        # Gather contributions
        j_e, j_c, j_d = group_composiiton

        game_payoffs[0] = self.competing_payoff_executor(j_c, j_e)
        game_payoffs[1] = self.competing_payoff_cooperator(j_c, j_e)
        game_payoffs[2] = self.competing_payoff_defector(j_c, j_e)

    def calculate_payoffs(self) -> np.ndarray:
        """
        Fill self.payoffs. For each possible configuration, compute the payoffs of the strategies
        :return: self.payoffs
        """
        payoffs_container = np.zeros(shape=(self.nb_strategies,), dtype=np.float64)
        for i in range(self.nb_states):
            # Get group composition
            group_composition = sample_simplex(i, self.group_size, self.nb_strategies)
            self.play(group_composition, payoffs_container)
            for strategy_index, strategy_payoff in enumerate(payoffs_container):
                self.payoffs[strategy_index, i] = strategy_payoff
            # Reinitialize payoff vector
            payoffs_container[:] = 0

        return self.payoffs

    def simple_payoff_defector(self, j_c: int) -> float:
        """
        Return the average payoff of defectors in Collective-risk social dilemma game
        :param j_c: number of cooperators
        :return: average payoff
        """
        return self.endowment * heaviside_function(j_c - self.M) + (1 - self.risk) * self.endowment * (
                1 - heaviside_function(j_c - self.M))

    def simple_payoff_cooperator(self, j_c: int) -> float:
        """
        Return the average payoff of cooperators in Collective-risk social dilemma game
        :param j_c: number of cooperators
        :return: average payoff
        """
        return self.simple_payoff_defector(j_c) - self.c

    def competing_payoff_defector(self, j_c: int, j_e: int) -> float:
        simple_payoff = self.simple_payoff_defector(j_c + j_e)
        return simple_payoff + self.alpha * (1 - self.alpha) * self.delta(j_e) * self.total_incentives

    def competing_payoff_cooperator(self, j_c: int, j_e: int) -> float:
        simple_payoff = self.simple_payoff_defector(j_c + j_e)
        return simple_payoff + self.alpha * self.alpha * self.delta(j_e) * self.total_incentives - self.c

    def competing_payoff_executor(self, j_c: int, j_e: int) -> float:
        simple_payoff = self.simple_payoff_defector(j_c + j_e)
        return simple_payoff + self.alpha * self.alpha * self.delta(j_e) * self.total_incentives - self.c - self.pi_t

    def delta(self, j_e: int) -> int:
        if self.local_scheme:
            return heaviside_function(j_e - self.n_E)  # 1 if j_e >= n_E
        return heaviside_function(self.population_state[0] - self.n_E)

    def payoffs(self) -> np.ndarray:
        return self.payoffs

    def payoff(self, strategy: int, group_composition: List[int]) -> float:
        """
        Return the average payoff of a given strategy in a group composition (j_e, j_c, j_d)
        :param strategy:
        :param group_composition:
        :return:
        """
        if strategy > self.nb_strategies:
            raise IndexError(f'You must specify a valid index for the strategy [0, {self.nb_strategies}].')
        elif len(group_composition) != self.nb_strategies:
            raise Exception(f'The group composition list must be of size {self.nb_strategies}')

        j_e, j_c, j_d = group_composition
        if strategy == 0:
            return self.competing_payoff_executor(j_c, j_e)
        elif strategy == 1:
            return self.competing_payoff_cooperator(j_c, j_e)
        else:
            return self.competing_payoff_defector(j_c, j_e)


if __name__ == "__main__":
    Z = 100
    N = 4
    M = 0.75 * N
    b = 1
    c = 0.1
    r = 0.2
    mu = 1 / Z
    alpha = 1
    n_E = 0.25 * M
    pi_e = 0.3
    pi_t = 0.03

    # well-mixed population?
    population = [0, 0, 0]
    for i in range(len(population) - 1):
        population[i] = random.randint(0, Z - sum(population))
    population[-1] = Z - sum(population)

    game = FixedIncentivesGame(population, N, b, c, r, M, alpha, n_E, pi_e, pi_t)

    payoff_matrix = transform_payoffs_to_pairwise(3, game)

    analytical_evolver = StochDynamics(3, payoff_matrix, Z, N)
    transition_matrix, fixation_probability = analytical_evolver.transition_and_fixation_matrix(0.1)
    stationary_distribution = egt.utils.calculate_stationary_distribution(transition_matrix)

    fig, ax = plt.subplots(figsize=(5, 5), dpi=150)
    G = draw_stationary_distribution(["Exec", "Coop", "Defec"],
                                     1 / Z, fixation_probability, stationary_distribution,
                                     node_size=600,
                                     font_size_node_labels=8,
                                     font_size_edge_labels=8,
                                     font_size_sd_labels=8,
                                     edge_width=1,
                                     min_strategy_frequency=0.00001,
                                     ax=ax)
    plt.axis('off')
    plt.show()  # display

    print(payoff_matrix)
    print(game.nb_states)
