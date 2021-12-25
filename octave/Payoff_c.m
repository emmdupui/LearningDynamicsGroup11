function payoff=Payoff_c(j_e, j_c, i_e, i_c)
    global alpha
    global pi_f
    global N
    global executor_threshold
    global c

    payoff = payoff_defector_collective_game(j_c + j_e) - c;
    if j_e >= N*executor_threshold
        payoff = payoff + alpha*pi_f;
    end
end
