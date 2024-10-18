function main()

% addpath('TEST IMAGE 1\');
addpath('TEST IMAGE 2\');


Image_all_org(:,:,1)=im2double(imread('WL780_P05_HV130_0000.png'));
Image_all_org(:,:,2)=im2double(imread('WL780_P05_HV130_0001.png'));
Image_all_org(:,:,3)=im2double(imread('WL780_P05_HV130_0002.png'));
Image_all_org(:,:,4)=im2double(imread('WL780_P05_HV130_0003.png'));
Image_all_org(:,:,5)=im2double(imread('WL780_P05_HV130_0004.png'));
Image_all_org(:,:,6)=im2double(imread('WL780_P05_HV130_0005.png'));
Image_all_org(:,:,7)=im2double(imread('WL780_P05_HV130_0006.png'));
Image_all_org(:,:,8)=im2double(imread('WL780_P05_HV130_0007.png'));
Image_all_org(:,:,9)=im2double(imread('WL780_P05_HV130_0008.png'));
Image_all_org(:,:,10)=im2double(imread('WL780_P05_HV130_0009.png'));



[M,N,K]=size(Image_all_org);

  [thr,position,fleg]=copula_threshold(sum(Image_all_org(:,:,1:round(K/2)),3),sum(Image_all_org(:,:,round(K/2)+1:K),3));

     denoised_image=svd_copula(position,Image_all_org,fleg,floor(K));
     figure
     imshow(denoised_image,[])
     Rimg_denoise =(denoised_image- min(denoised_image(:)))./ (max(denoised_image(:))-min(denoised_image(:)));
     

     imwrite( Rimg_denoise,strcat('Denoised_SVD_COPULA.png'));


end