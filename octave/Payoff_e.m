function payoff=Payoff_e(j_e, j_c, i_e, i_c)
    global alpha
    global pi_f
    global N
    global executor_threshold
    global c
    global pi_t

    payoff = payoff_defector_collective_game(j_c + j_e) - c - pi_t;
    if j_e >= N*executor_threshold
        payoff += alpha*pi_f;
    endif
endfunction
