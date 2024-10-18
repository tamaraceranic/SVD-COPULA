function thr_for_diff_m=test_value_m(S_vec_for_thr,thr_image)

%   m=[10 20 30 40 50 60 70 80 90 100];
% input: S_vec_for_thr-vector of singular values less then first threshold
% (sth0), thr_image-number of singular value that corresponds to the first
% threshold (sth0)
% thr_for_diff_m-number of singular value after applying of adjustment of
% threshold (sth)

m=60; %default value
thr_for_diff_m=[];

    for r=1:1:length(m)

       std_thr=[];
        for k=1:1:length(S_vec_for_thr)-m(r)

          std_WIN =std(S_vec_for_thr(k:(k)+m(r)));
          std_thr=[std_thr std_WIN];

       end

       ind=find( abs(diff(std_thr))<0.0050,1); %%default value

       if (isempty(ind))
           ind=0;
           thr_final=thr_image;
       else
       thr_final=thr_image+ind+m(r);
       end

       thr_for_diff_m=[thr_for_diff_m thr_final];
    end

end