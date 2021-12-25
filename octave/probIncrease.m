% c_increase -> 1 if we want to compute T^C+-, 0 if we want to compute T^E+-
% increase -> 1 if we want to compute the increase probability
function prob=probIncrease(state_matrix, state, i_e, i_c, c_increase, increase)
    if c_increase == 1
        if increase == 1
            i_c = i_c + 1;
        else
            i_c = i_c - 1;
        end
    else
        if increase == 1
            i_e = i_e + 1;
        else
            i_e = i_e - 1;
        end
    end

    if i_e < 0 || i_c < 0 || i_e > 100 || i_c > 100
        prob = 0;
    else
        prob=0;
        new_state = loc_Transform(i_e, i_c);
        if new_state <= size(state_matrix)(1)
            prob  = state_matrix(state, new_state);
        end
    end


    if c_increase == 1
        if increase == 1
            i_e = i_e - 1;
        else
            i_e = i_e + 1;
        end
    else
        if increase == 1
            i_c = i_c - 1;
        else
            i_c = i_c + 1;
        end
    end


    if i_e < 0 || i_c < 0 || i_e > 100 || i_c > 100
        prob = prob + 0;
    else
        prob=0;
        new_state = loc_Transform(i_e, i_c);
        if new_state <= size(state_matrix)(1)
            prob = prob + state_matrix(state, new_state);
        end
    end

end