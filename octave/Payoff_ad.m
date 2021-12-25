function payoff=Payoff_ad(j_e, j_c, i_e, i_c)
    global alpha
    global pi_f
    global N
    global executor_threshold
    global c

    payoff = payoff_defector_collective_game(j_c + j_e);
    if j_e >= N*executor_threshold
        payoff = payoff - (1-alpha)*pi_f;
    endif
end
