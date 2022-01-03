function payoff=Payoff_c(j_e, j_c, i_e)
    global alpha
    global pi_f
    global pi_t
    global N
    global executor_threshold
    global c
    global LOCAL_SCHEME
    global FLEXIBLE_INCENTIVE
    global enhancement_factor
    global error

    if LOCAL_SCHEME == 1
        value_to_test_delta = j_e;
    else
        value_to_test_delta = i_e;
    end

    if FLEXIBLE_INCENTIVE == 0
        executive_pool = pi_f;
    else
        executive_pool = pi_t * enhancement_factor * j_e / (j_c+j_e);
    end

    payoff = payoff_defector_collective_game(j_c + j_e) - c;
    if value_to_test_delta >= N*executor_threshold
        payoff = payoff + (1-error)*alpha*executive_pool - (1-alpha) * error * executive_pool;
    end
end
