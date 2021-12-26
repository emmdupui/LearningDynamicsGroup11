function payoff=payoff_defector_collective_game(j_c)
    global b
    global M
    global r

    if j_c >= M
        payoff = b;
    else
        payoff = (1-r)*b;
    end
end
