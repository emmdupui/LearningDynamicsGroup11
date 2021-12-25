function pos=loc_Transform(i_e, i_c)
    % Map a population state to an integer (position) between 1 and len
    global Z;
    pos = (Z*(Z+1) - (Z-i_e+1)*(Z-i_e))/2 + i_e + i_c + 1;
end
