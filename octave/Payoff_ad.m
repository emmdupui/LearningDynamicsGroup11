function payoff=Payoff_ad(j_e, j_c, i_e)
    global alpha
    global pi_f
    global pi_t
    global N
    global executor_threshold
    global c
    global LOCAL_SCHEME
    global FLEXIBLE_INCENTIVE
    global enhancement_factor

    if LOCAL_SCHEME == 1
        value_to_test_delta = j_e;
    else
        value_to_test_delta = i_e;
    end

    if FLEXIBLE_INCENTIVE == 0
        executive_pool = pi_f;
    else
        j_ac = N - j_c - j_e;
        executive_pool = pi_t * enhancement_factor * j_e / j_ac;
    end

    payoff = payoff_defector_collective_game(j_c + j_e);
    if value_to_test_delta >= N*executor_threshold
        payoff = payoff - (1-alpha)*executive_pool;
    end
end
