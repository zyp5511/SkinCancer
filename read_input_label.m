function [ image, label ] = read_input_label(path_input,path_label,imNum)
image_i_fn = strcat(path_input ,'/', imNum,'.jpg');
label_i_fn = strcat(path_label ,'/',imNum,'_segmentation.png');
label = imread(label_i_fn);
image = imread(image_i_fn);
label = label(2:end-1,2:end-1,:);
image = image(2:end-1,2:end-1,:);
end

