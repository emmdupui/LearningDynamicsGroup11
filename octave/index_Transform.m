function [i_e, i_c] = index_Transform(i)
    global Z;
    i_e=0;
    i_c=0;
    while loc_Transform(i_e, i_c) ~= i
        if i_e + i_c < Z
            i_c = i_c + 1;
        else
            i_c = 0;
            i_e = i_e + 1;
        end
    end
end