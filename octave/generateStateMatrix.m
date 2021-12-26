function state_matrix = generateStateMatrix()
    global Z
    global mu
    global belta
    global s

    len = (Z+1) * (Z+2) /2;
    state_matrix = zeros(len,len);
    % test every possible configuration in the population Z
    for i_e = 0 : Z
        for i_c = 0 : Z - i_e
            i_ad = Z - i_e - i_c; % number of defector
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %up AD to C (i_c, i_e) + (1, 0),
            neighborLoc11 = i_e;
            neighborLoc12 = i_c + 1;
            neighborLoc13 = Z-neighborLoc11 - neighborLoc12;
            % if valid state
            if  neighborLoc11 >= 0 &&  neighborLoc11<=Z &&  neighborLoc12>=0 &&  neighborLoc12<=Z && neighborLoc13>=0 && neighborLoc13<=Z
                loc_source1 = loc_Transform(i_e,i_c);
                loc_target1 = loc_Transform(neighborLoc11,neighborLoc12);
                average_payoff_neighbor11=average_payoff_AD(i_e,i_c);%AD
                average_payoff_neighbor12=average_payoff_C(i_e,i_c);%C
                state_matrix(loc_source1, loc_target1)=(1-mu) * i_ad*i_c *(1 + exp(belta * (average_payoff_neighbor11 - average_payoff_neighbor12)))^-1/(Z*(Z - 1)) + mu * i_ad/(s* Z);% D to P
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %down C to AD
            neighborLoc21=i_e;
            neighborLoc22=i_c -1;
            neighborLoc23=Z-neighborLoc21-neighborLoc22;
            if neighborLoc21>=0 &&  neighborLoc21<=Z &&  neighborLoc22>=0 &&  neighborLoc22<=Z && neighborLoc23>=0 && neighborLoc23<=Z
                average_payoff_neighbor21=average_payoff_C(i_e,i_c);%C
                average_payoff_neighbor22=average_payoff_AD(i_e,i_c);%AD
                loc_source2 =  loc_Transform(i_e, i_c);
                loc_target2 = loc_Transform(neighborLoc21, neighborLoc22);
                state_matrix(loc_source2, loc_target2)=(1-mu) * i_c*i_ad *(1 + exp(belta * (average_payoff_neighbor21 - average_payoff_neighbor22)))^-1/(Z*(Z - 1)) + mu * i_c/(s* Z);% P to D
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % left E to AD
            neighborLoc31 = i_e-1;
            neighborLoc32 = i_c;
            neighborLoc33 = Z-neighborLoc31-neighborLoc32;
            if neighborLoc31 >= 0 &&  neighborLoc31 <= Z &&  neighborLoc32>=0 &&  neighborLoc32<=Z && neighborLoc33>=0 && neighborLoc33<=Z
                average_payoff_neighbor31=average_payoff_E(i_e,i_c);%E
                average_payoff_neighbor32=average_payoff_AD(i_e,i_c);%AD
                loc_source3 = loc_Transform(i_e,i_c);
                loc_target3 = loc_Transform(neighborLoc31,neighborLoc32);
                state_matrix(loc_source3, loc_target3)=(1-mu) * i_e* i_ad*(1 + exp(belta * (average_payoff_neighbor31 - average_payoff_neighbor32)))^-1/(Z*(Z - 1))  + mu * i_e/(s* Z);% C to D
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % right  AD to E
            neighborLoc41=i_e+1;
            neighborLoc42=i_c;
            neighborLoc43=Z-neighborLoc41-neighborLoc42;
            if neighborLoc41>=0 &&  neighborLoc41<=Z &&  neighborLoc42>=0 &&  neighborLoc42<=Z && neighborLoc43>=0 && neighborLoc43<=Z
                average_payoff_neighbor41=average_payoff_AD(i_e,i_c);%AD
                average_payoff_neighbor42=average_payoff_E(i_e,i_c);%E
                loc_source4 = loc_Transform(i_e,i_c);
                loc_target4 = loc_Transform(neighborLoc41,neighborLoc42);
                state_matrix(loc_source4, loc_target4)=(1-mu) * i_ad* i_e*(1 + exp(belta * (average_payoff_neighbor41 - average_payoff_neighbor42)))^-1/(Z*(Z - 1))  + mu * i_ad/(s* Z);% D to C
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % left-up   E to C
            neighborLoc51=i_e-1;
            neighborLoc52=i_c+1;
            neighborLoc53=Z-neighborLoc51-neighborLoc52;
            if neighborLoc51>=0 &&  neighborLoc51<=Z &&  neighborLoc52>=0 &&  neighborLoc52<=Z && neighborLoc53>=0 && neighborLoc53<=Z
                average_payoff_neighbor51=average_payoff_E(i_e,i_c);%E
                average_payoff_neighbor52=average_payoff_C(i_e,i_c);%C
                loc_source5 = loc_Transform(i_e,i_c);
                loc_target5 = loc_Transform(neighborLoc51,neighborLoc52);
                state_matrix(loc_source5, loc_target5)=(1-mu) * i_e* i_c*(1 + exp(belta * (average_payoff_neighbor51 - average_payoff_neighbor52)))^-1/(Z*(Z - 1))  + mu * i_e/(s* Z);% E to C
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % right-down  C to E
            neighborLoc61=i_e+1;
            neighborLoc62=i_c-1;
            neighborLoc63=Z-neighborLoc61-neighborLoc62;
            if neighborLoc61>=0 &&  neighborLoc61<=Z &&  neighborLoc62>=0 &&  neighborLoc62<=Z && neighborLoc63>=0 && neighborLoc63<=Z
                average_payoff_neighbor61=average_payoff_C(i_e,i_c);%C
                average_payoff_neighbor62=average_payoff_E(i_e,i_c);%E
                loc_source6 = loc_Transform(i_e,i_c);
                loc_target6 = loc_Transform(neighborLoc61,neighborLoc62);
                state_matrix(loc_source6, loc_target6)=(1-mu) * i_c* i_e*(1 + exp(belta * (average_payoff_neighbor61 - average_payoff_neighbor62)))^-1/(Z*(Z - 1))  + mu * i_c/(s* Z);%C to E
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       end
    end
    A1=diag(1 - sum(state_matrix, 2));%Diagonal element
    state_matrix =  A1 + state_matrix;%Probability transition matrix
end