function  [X_approx] = low_rank_approx(U,S,V, r_size)

 [r,c] = size(S);
 X_approx =zeros(r,c);
 
 for i = 1 : r_size 
     X_approx = X_approx + S(i,i)*U(:,i)*V(:,i)';
 end


end