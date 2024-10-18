function suma_final_all=svd_copula(position,Image_all,fleg,K)
% program that determines the value of thresholds and applies SVD decomposition
% inputs: position-selected 1D time series of row or cols with "role"
% backgrounds 1D time series, Image_all-image stack of raw TPLSM images,
% fleg-indicator of colons or row, K-number of images in stack.
% output: suma_final_all-denoised image.


no_mages=size(Image_all,3);

 Image_all(:,:,1)=Image_all(:,:,1);

Image_noise=[];


no_mages_for_noise=K;

    if (fleg==1) %fleg 1-cols, 

           for i=1:1:no_mages_for_noise
                

             Image_noise(:,i)=Image_all(:,position,i);

            end

            avrage_noise=sum(Image_noise,2);


            [U,S,V] = svd( avrage_noise); 

    else

              for i=1:1:no_mages_for_noise


            Image_noise(i,:)=Image_all(position,:,i);

          end

          avrage_noise=sum(Image_noise,1);


            [U,S,V] = svd( avrage_noise); 


    end
position_noise=find(S~=0);
threshold=S(position_noise(end))
sum_final=0;

avrage_image=sum(Image_all(:,:,1:no_mages),3);


[U,S,V] = svd(avrage_image);
    S_vec=diag(S);
   thr_image=find(S_vec<threshold,1)

 S_vec_for_thr=S_vec(thr_image:end);


   
 thr_for_diff_m=test_value_m(S_vec_for_thr,thr_image);

for p=1:1:length(thr_for_diff_m)
    

     
    [X_approx] = low_rank_approx(U,S,V,thr_for_diff_m(p)); 
    sum_final=sum_final+X_approx;


   suma_final_all(:,:,p)=sum_final;
    sum_final=0;
end




end