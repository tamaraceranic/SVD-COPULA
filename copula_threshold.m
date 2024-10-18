function [thr,position,fleg]=copula_threshold(image1,image2 )
% inputs: image 1, image 2-averaged images of the first and the second
% halves of image stack, respectively.
% outputs: thr-value of copula parameters; fleg-indicator of colons or row
% position-number of selected row or colons in image

    M=size(image1,1);
    N=size(image1,2);
    COP_all_rows=[];
    COP_all_cols=[];

        for i=1:1:M

            x1= image1(i,:);
            x2= image2(i,:);

         
            
            COP = copula_parametri_delF(x1,x2);

            COP_all_rows=[COP_all_rows COP];


        end
        
          for i=1:1:N

            x1= image1(:,i);
            x2= image2(:,i);

            COP = copula_parametri_delF(x1,x2);

            COP_all_cols=[COP_all_cols COP];
    %         x3= Image_all(250,:,k);
    %         x4= Image_all(250,:,k+1);
    %   
    %         COP2 = copula_parametri_delF(x3,x4);

        end
   % po vrstama 
   thr_rows_less=99;
   thr_rows_larger=99;
   thr_cols_larger=99;
   thr_cols_less=99;
   
     [thr_rows_larger,position_rows_larger]=find(COP_all_rows>=0);
     [sort_COP_all_rows_larger_0,I]=sort(COP_all_rows(position_rows_larger));
    
         if (~isempty(sort_COP_all_rows_larger_0))
         thr_rows_larger=sort_COP_all_rows_larger_0(1);
         else
         thr_rows_larger=99;    
         end
     
     [thr_rows_less,position_rows_less]=find(COP_all_rows<0); 
     [sort_COP_all_rows_less_0,I]=sort(COP_all_rows(position_rows_less));

         if (~isempty(sort_COP_all_rows_less_0))
         thr_rows_less=sort_COP_all_rows_less_0(end);
         else
             thr_rows_less=99;
         end

      if (thr_rows_larger~=99 && thr_rows_less~=99)  
          
          %proveri im i snagu
          [thr_rows_larger_candidate,position_rows_larger_candidate]=find(COP_all_rows==thr_rows_larger);
          [thr_rows_smaller_candidate,position_rows_smaller_candidate]=find(COP_all_rows==thr_rows_less);
           s1= image1(position_rows_larger_candidate,:);
           s2= image1(position_rows_smaller_candidate,:);
           s1_sec= image2(position_rows_larger_candidate,:);
           s2_sec= image2(position_rows_smaller_candidate,:);
           
           power_s1=(sum(s1.^2)/length(s1)+sum(s1_sec.^2)/length(s1_sec))/2;
           power_s2=(sum(s2.^2)/length(s2)+sum(s2_sec.^2)/length(s2_sec))/2;
          
          if (power_s1<power_s2)

                thr_rows=thr_rows_larger_candidate;
                power_s1_row=power_s1;
                position_rows=position_rows_larger_candidate;
             else
                 
                 thr_rows=thr_rows_smaller_candidate;
                      power_s1_row=power_s2;
                 position_rows=position_rows_smaller_candidate;   
         end
           
           

      elseif (thr_rows_larger~=0 && thr_rows_less==99 )
              [thr_rows,position_rows]=find(COP_all_rows==thr_rows_larger);
               thr_rows=thr_rows_larger;
               s1= image1(position_rows,:);
               s2=image2(position_rows,:);
               
                power_s1=(sum(s1.^2)/length(s1)+sum(s2.^2)/length(s2))/2;
           
                power_s1_row=power_s1;
      elseif (thr_rows_larger==99 && thr_rows_less~=0)
              [thr_rows,position_rows]=find(COP_all_rows==thr_rows_less);
               thr_rows=thr_rows_less;  
                s1= image1(position_rows,:);
                s2=image2(position_rows,:);
               
                power_s1=(sum(s1.^2)/length(s1)+sum(s2.^2)/length(s2))/2;
              
                power_s1_row=power_s1;
               
               
               
     end
  %kolona   
  
      [thr_cols_larger,position_cols_larger]=find(COP_all_cols>=0);
     [sort_COP_all_cols_larger_0,I]=sort(COP_all_cols(position_cols_larger));
     
       if (~isempty(sort_COP_all_cols_larger_0))
            thr_cols_larger=sort_COP_all_cols_larger_0(1);
       else
           thr_cols_larger=99;
       end
     
     [thr_cols_less,position_cols_less]=find(COP_all_cols<0); 
     [sort_COP_all_cols_less_0,I]=sort(COP_all_cols(position_cols_less));
     
       if (~isempty(sort_COP_all_cols_less_0))
          thr_cols_less=sort_COP_all_cols_less_0(end);
       else
          thr_cols_less=99; 
       end
     
     
    
   if ( thr_cols_larger~=99  && thr_cols_less~=99 )  
       
                 %proveri im i snagu
          [thr_cols_larger_candidate,position_cols_larger_candidate]=find(COP_all_cols==thr_cols_larger);
          [thr_cols_smaller_candidate,position_cols_smaller_candidate]=find(COP_all_cols==thr_cols_less);
           s1= image1(:,position_cols_larger_candidate);
           s1_sec= image2(:,position_cols_larger_candidate);
           s2= image1(:,position_cols_smaller_candidate);
           s2_sec= image2(:,position_cols_smaller_candidate);
           
           power_s1=(sum(s1.^2)/length(s1)+sum(s1_sec.^2)/length(s1_sec))/2;
           power_s2=(sum(s2.^2)/length(s2)+sum(s2_sec.^2)/length(s2_sec))/2;
          
          if (power_s1<power_s2)

                thr_cols=thr_cols_larger_candidate;
                position_cols=position_cols_larger_candidate;
                 power_s1_col=power_s1;
             else
                 
               thr_cols=thr_cols_smaller_candidate;
               position_cols=position_cols_smaller_candidate;
               power_s1_col=power_s2;
         end
           
       

             
  elseif ((thr_cols_larger)~=0 && (thr_cols_less)==99 )
             
              [thr_cols,position_cols]=find(COP_all_cols==thr_cols_larger);
              s1= image1(:,position_cols);
              s1_sec= image2(:,position_cols);
              power_s1_col=(sum(s1.^2)/length(s1)+sum(s1_sec.^2)/length(s1_sec))/2;
            
              thr_cols=thr_cols_larger;
  elseif ((thr_cols_larger)==99 && (thr_cols_less)~=0 )
              [thr_cols,position_cols]=find(COP_all_cols==thr_cols_less);
               thr_cols=thr_cols_less;  
               s1= image1(:,position_cols);
               s1_sec= image2(:,position_cols);
              power_s1_col=(sum(s1.^2)/length(s1)+sum(s1_sec.^2)/length(s1_sec))/2;
          
               
  end
     

        
     if (power_s1_row>power_s1_col)
         
         position=position_cols;
         thr=thr_cols;
         fleg=1;
         
     else
         
           position=position_rows;
           thr=thr_rows;
           fleg=2;
     end
    

     
end