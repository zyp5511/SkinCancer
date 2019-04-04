function [I4] = local_histeq(im,mask)
%LOCAL_HISTEQ Summary of this function goes here
%   Detailed explanation goes here

 I2 = rgb2gray(im);
 %colormap gray;
 
 %using hist eq. built in fn
 I3= histeq(I2);
 z= imhist(I3);

 y = imhist(I2);

 %my equalization
 r = size(I2,1);
 c = size(I2,2);
 A= zeros(1,256);
 I4 = mask*0;
 %counting number of pixels of the image and putting the count in Array A
 for j=1:r
   for x=1:c
        if mask(j,x) == 255
            v=I2(j,x);
            A(v+1)=A(v+1)+1;
        end
   end
 end

    %pi=n/size
   number_pix = sum(A);
   pi= A./number_pix;

  %calculate CI (cumulated pi )
   ci(1)=pi(1);
   for yy=2:256
        ci(yy) = ci(yy-1)+ pi(yy);
   end

   %calculate T=range *Ci
   T=ci.*255;

   %equilization..replacing each pixel with T value
   for j=1:r
       for x=1:c
           if mask(j,x) == 255
                I4(j,x) =T(I2(j,x)+1);
           end
       end
   end

   vv= imhist(I4);



%   figure
%   subplot(3,2,1)
%   imshow(I2)
%   subplot(3,2,2)
%   plot(y)
% 
%  subplot(3,2,3)
%  imshow(I3)
%   subplot(3,2,4)
%   plot(z)
% 
%   subplot(3,2,5)
%   imshow(I4)
%   subplot(3,2,6)
%   plot(vv)
%   
%   figure
%   map = hsv(256); % Or whatever colormap you want.
%   rgbImage = ind2rgb(I4, map); % im is a grayscale or indexed image.
%   imshow(rgbImage)
end

