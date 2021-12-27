function plotSimplex(state_matrix, stationary_distribution)
    global Z

    x_src = [];
    y_src = [];
    x_length = [];
    y_length = [];
    for i_e = 0 : Z
        if mod(i_e, 4) == 0 %faster and clearer
            for i_c = 0 : Z - i_e
                if mod(i_c, 4) == 0 %faster and clearer
                    line = loc_Transform(i_e, i_c);

                    [x_vect, y_vect] = getSimplexVector(state_matrix, i_e, i_c);

                    x_shift = i_e/2;

                    x_src = [x_src i_c + x_shift];
                    y_src = [y_src i_e];

                    x_shift = y_vect/2;
                    x_length = [x_length x_vect + x_shift];
                    y_length = [y_length y_vect];
                end
            end
        end
    end

    quiver(x_src, y_src, x_length, y_length);xlim([-10 Z+10]);ylim([-10 Z+10]);
    text(Z/2, Z+5, "E");
    text(Z+5, 0 , "C");
    text(-5, 0, "D");

    average_achievement = averageGroupAchievment(stationary_distribution)*100;
    text(Z/2-5, -5, strcat("\\eta_G = ", num2str(average_achievement), "%"));
    axis off
end