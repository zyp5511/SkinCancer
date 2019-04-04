function [S] = im_read(D)
%IM_READ Summary of this function goes here
%   Detailed explanation goes here

S = dir(fullfile(D,'*.jpg')); % pattern to match filenames.
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    %I = imread(F);
    %S(k).data = I;
end

end

