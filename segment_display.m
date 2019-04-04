function [jotsu,IOS] = segment_display(path_input,path_label,fn)

% figure
% subplot(2,2,1);
[ I_1, T ] = read_input_label(path_input,path_label,fn);
I = double(I_1)/255;
% imshow(I_1)
% title('original image')

%subplot(2,2,2);
% Preprocessing and postprocessing options
%pre
channel='blue'; % color channel
hair_removal = true; % dullrazor shaving
compute_blackframe = true; % removing blackframe in preproc
%post
compute_filling = true; % morphological filling of the holes in the ROI
compute_CCA = true; % denoising of small "islands" (keeping regions with area > 1000)
clear_border = true; % if true, removes regions that touches the border of the image

I = imresize(I,[538 720], 'bilinear');
T = imresize(T,[538 720], 'nearest'); % 'nearest' preserves T as a binary mask

[IpreProc, blackM, Ishaved]=preProc(I,channel, hair_removal, compute_blackframe);

% imshow(Ishaved)
% title('hair removed image')
%ostu
[threshold, eta,sigList] = otsu(IpreProc((IpreProc-2*blackM)>0));
Iotsu = double(IpreProc < threshold)-blackM;
Iotsu = double(Iotsu>0);

IsegtOtsu=postProc(Iotsu,compute_filling, compute_CCA, clear_border);
jotsu = jaccard(IsegtOtsu,T);
IOS = cal_IOS(T,IsegtOtsu);
% subplot(2,2,3);
% title('segmentation mask')
% imshow(IsegtOtsu)
% 

line1 = sprintf('%s : jaccard = %3g, IOS= %3g',fn,jotsu, IOS);
image(I)
title(line1)
hold on
[c,h] = contour(double(IsegtOtsu));
h.LineColor='red';
[c,h]=contour(T);
h.LineColor='green';
legend('s','T')
hold off 
line = strcat('cross_validation/',fn,'_cross','.png');
saveas(gcf,line)

end

