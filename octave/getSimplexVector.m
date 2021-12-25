function [x_vect,y_vect] = getSimplexVector(state_matrix, i_e, i_c)
    state = loc_Transform(i_e, i_c);
    x_vect = probIncrease(state_matrix, state, i_e, i_c, 1, 1) - probIncrease(state_matrix, state, i_e, i_c, 1, 0);
    y_vect = probIncrease(state_matrix, state, i_e, i_c, 0, 1) - probIncrease(state_matrix, state, i_e, i_c, 0, 0);
end