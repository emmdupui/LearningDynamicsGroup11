function averageAchievement = averageGroupAchievment(stationary_distribution)
    global Z
    global N
    global M
    averageAchievement = 0;
    for i_e = 0 : Z
        for i_c = 0 : Z - i_e
            i_ad = Z - i_c - i_e;
            state = loc_Transform(i_e, i_c);

            a = 0;
            for j_c = 0 : Z
                for j_e = 0 : N-j_c
                    j_ad = N - j_c - j_e;
                    if j_c + j_e - M >= 0
                        if j_c > i_c
                            E1 = 0;
                        else
                            E1 = nchoosek(i_c, j_c);
                        end

                        if j_e > i_e
                            E2 = 0;
                        else
                            E2 = nchoosek(i_e, j_e);
                        end

                        if j_ad > i_ad
                            E3 = 0;
                        else
                            E3 = nchoosek(i_ad, j_ad);
                        end

                        a = a + E1 * E2 * E3;
                    end
                end
            end

            if N > Z
                E5 = 0;
            else
                E5 = nchoosek(Z, N);
            end

            if E5 ~= 0
                a = a/E5;
            else
                a = 0;
            end

            averageAchievement = averageAchievement + a * stationary_distribution(state);
        end
    end
end
