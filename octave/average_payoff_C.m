function average_payoff_C=average_payoff_C(i_e,i_c)
    %%%%%%%
    global Z
    global normal
    global N
    %%%%%%%%%%%
    i_ad=Z-i_e-i_c;
    s1=0;
    for j_e = 0 : N -1
        for j_c = 0 : N-1-j_e
            j_ad = N-1-j_e-j_c;
            %%%%%%%%%
            if j_c>(i_c-1)
                E1=0;
            else
                E1=nchoosek((i_c-1), j_c);%
            end
            %%%%%%%%%
            if j_e>i_e
                E5=0;
            else
                E5=nchoosek(i_e, j_e);%
            end%%%%%%%
            if j_ad>i_ad
                E6=0;
            else
                E6=nchoosek(i_ad, j_ad);%
            end
            %%%%%%%%%
             s1 = s1 + Payoff_c(j_e, j_c+1) * E1 * E5 * E6;
        end
    end
    average_payoff_C=s1/normal;
end
