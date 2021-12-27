function average_payoff_AD=average_payoff_AD(i_e,i_c)
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
            if j_c>i_c
                E1=0;
            else
                E1=nchoosek(i_c, j_c);%
            end
            %%%%%%%%%
            if j_e>i_e
                E5=0;
            else
                E5=nchoosek(i_e, j_e);%
            end%%%%%%%
            if j_ad>i_ad-1
                E6=0;
            else
                E6=nchoosek(i_ad-1, j_ad);%
            end
            %%%%%%%%%
             s1 =s1 +Payoff_ad(j_e, j_c,i_e) * E1 * E5 * E6;
        end
    end
    average_payoff_AD=s1/normal;
end
