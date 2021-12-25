function plotSimplex(state_matrix)
    global Z

    x_src = [];
    y_src = [];
    x_length = [];
    y_length = [];
    for i_e = 0 : Z
        i_e
        for i_c = 0 : Z - i_e
            if mod(i_c, 3) == 0 %faster and clearer
                line = loc_Transform(i_e, i_c);

                [x_vect, y_vect] = getSimplexVector(state_matrix, i_e, i_c);

                x_shift = i_e/2;

                x_src = [x_src i_c + x_shift];
                y_src = [y_src i_e];
                x_length = [x_length x_vect];
                y_length = [y_length y_vect];
            end
        end
    end
    quiver(x_src, y_src, x_length, y_length);xlim([0 100]);ylim([0 100]);
end